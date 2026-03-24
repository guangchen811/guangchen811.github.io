---
title: "Optimizing Compound AI Systems: A Researcher's Map"
date: 2026-03-11
draft: true
tags:
  - compound-ai
  - optimization
categories:
  - Research
summary: "A narrative guide through the methods for automatically optimizing compound AI systems — from textual gradients and execution traces to evolutionary search and structure discovery."
ShowToc: true
TocOpen: true
math: true
---

In 2024, FactSet replaced a single GPT-4 call (55% accuracy, 10s latency) with a compound system — Gemini for formula generation, Llama-3 for argument filling, GPT-3.5 for assembly, plus a retrieval layer — and hit [87% accuracy at 3s latency](https://www.databricks.com/blog/factset-genai). A 32-point accuracy jump, not from a better model, but from a better *system*.

This is not an isolated case. Databricks [reports](https://bair.berkeley.edu/blog/2024/02/18/compound-ai-systems/) that 60% of LLM applications in production use retrieval-augmented generation and 30% use multi-step chains. AlphaCode 2 generates up to a million candidate solutions, filters and clusters them, and reaches the [85th percentile of competitive programmers](https://storage.googleapis.com/deepmind-media/AlphaCode2/AlphaCode2_Tech_Report.pdf). Medprompt's chain of nearest-neighbor search, chain-of-thought, and ensembling [outperforms domain-specialized medical models](https://arxiv.org/abs/2311.16452) while using a general-purpose GPT-4.

The pattern has a name: **compound AI systems** — systems that tackle AI tasks using multiple interacting components, including multiple calls to models, retrievers, or external tools ([Zaharia et al. 2024](https://bair.berkeley.edu/blog/2024/02/18/compound-ai-systems/)). This is a broader category than "agentic AI": agents are one design pattern *within* compound systems, alongside RAG pipelines, ensembles, cascades, and tool-augmented generation. A [workshop](https://www.databricks.com/dataaisummit/session/compound-ai-systems-workshop) at the 2024 Data+AI Summit, bringing together researchers from OpenAI, Google DeepMind, Stanford, Berkeley, and others, validated this as a first-class research direction.

The empirical case is strong — but it comes with a caveat. Not every task needs a compound system. If a single well-prompted model call already achieves your accuracy target, the additional complexity of a multi-component pipeline is pure overhead: more latency, more cost, more failure modes to debug. The BAIR blog noted that tripling an LLM's training budget might only improve coding accuracy from 30% to 35%, while engineering a system around the same model can reach 80% — but that gap varies enormously by task. The right question is not "should I build a compound system?" but **"when I do, how do I optimize it automatically, rather than hand-tuning one prompt at a time?"**

This post is my attempt at a map. It is written for ML researchers and engineers who already build multi-component LLM pipelines and want to understand the optimization landscape — what methods exist, how they relate, and which one to reach for in practice. Since 2023, methods like DSPy, TextGrad, Trace, OPTIMAS, GEPA, ADAS, AFlow, and MASS have attacked this question from remarkably different angles. Rather than cataloguing them in isolation, I trace the central tension that drives their evolution: **credit assignment** — figuring out which component caused a system-level failure, and how to fix it.

## The Shared Problem

Every method in this post, despite superficial differences, solves a variant of the same optimization.

**Notation.** Let $\mathcal{S} = (M_1, \ldots, M_n)$ be a compound AI system with $n$ modules. Each module $M_i$ has parameters $\theta_i$ — these may be prompts (instructions and few-shot demonstrations), model selection choices, numerical hyperparameters, or even trainable weights. We write $\theta = (\theta_1, \ldots, \theta_n)$ for the full configuration. Given training data $\mathcal{D} = \lbrace(x^{(j)}, y^{(j)})\rbrace_{j=1}^N$ and an evaluation metric $\mathcal{L}$, the general objective is:

$$\theta^* = \arg\max_{\theta} \; \mathbb{E}_{(x, y) \sim \mathcal{D}} \left[ \mathcal{L}\bigl(\mathcal{S}(x;\, \theta), \, y\bigr) \right]$$

The challenge is that $\mathcal{S}$ is a black-box pipeline of LLM calls — non-differentiable, stochastic, and expensive to evaluate. The methods below differ along four axes:

1. **What to optimize**: instructions only, or also the pipeline structure?
2. **What feedback signal to use**: scalar scores, textual critique, or execution traces?
3. **How to search**: Bayesian optimization, gradient-inspired updates, evolutionary search, or tree search?
4. **How to assign credit**: when the system fails, how does the method identify *which module* to change?

The fourth axis — credit assignment — is the one that most sharply distinguishes these methods and drives the field's evolution. A [survey by Lee et al. (2025)](https://arxiv.org/abs/2506.08234) proposed a 2×2 taxonomy along the first two axes:

<div align="center">
<img src="taxonomy_2x2.png" alt="2×2 taxonomy of compound AI optimization methods" style="max-width: 680px; width: 100%;">
<figcaption><em>The optimization landscape organized by structural flexibility (rows) and feedback type (columns). Top-left: fixed structure + numerical feedback (DSPy, OPTIMAS). Top-right: fixed structure + textual feedback (TextGrad, Trace, GEPA). Bottom-left: flexible structure + numerical feedback — nearly empty, since discovering new topologies typically requires richer-than-scalar signals. Bottom-right: flexible structure + textual feedback (ADAS, AFlow, MASS).</em></figcaption>
</div>

Most methods sit in the top row because, in practice, most production pipelines have an engineer-designed DAG that rarely changes. What changes are the prompts, the demonstrations, and the model configurations within each node. I start there — and in what follows, I use credit assignment as the thread that connects each method to the next.

## Instruction Optimization

Instruction optimization treats the pipeline topology as fixed and tunes each module's parameters. The field has evolved rapidly, driven by increasingly sophisticated answers to the credit assignment problem: from binary pass/fail, to per-variable textual critique, to learned local reward functions, to evolutionary search with trajectory-level reflection.

<div align="center">
<img src="evolution_timeline.png" alt="Evolution timeline of compound AI optimization methods from 2023 to 2026" style="max-width: 760px; width: 100%;">
<figcaption><em>Two parallel tracks of compound AI optimization research. Instruction optimization (top) and structure optimization (bottom) have evolved independently until MASS (2026), which bridges both.</em></figcaption>
</div>

### The Programming Abstraction: DSPy

[DSPy](https://arxiv.org/abs/2310.03714) ([Khattab et al. 2023](https://arxiv.org/abs/2310.03714)) introduced the foundational abstraction: treat LLM pipelines as *programs* with learnable parameters. Signatures define I/O contracts, modules define operations, and optimizers automatically tune prompts and demonstrations.

In our shared formulation, DSPy's $\theta_i$ are instructions and few-shot demonstrations for each module. Its compiler bootstraps demonstrations by running a teacher program, filtering execution traces that pass the metric, and using those passing traces as demos. [MIPROv2](https://arxiv.org/abs/2406.11695) ([Opsahl-Ong et al. 2024](https://arxiv.org/abs/2406.11695)) upgraded this with joint instruction and demonstration optimization via Bayesian surrogate search.

What DSPy got right is the *declarative programming model* — separating *what* a module does (its signature) from *how* it's prompted (its parameters) is what makes automatic optimization possible in the first place.

But DSPy's credit assignment is the crudest of all the methods here: **binary end-to-end filtering**. A trace either passes the metric or it doesn't. If a 5-module pipeline fails, BootstrapFewShot cannot tell you whether module 2's retrieval was poor or module 4's reasoning went wrong. Demonstration selection is similarly blunt — no diversity measurement, no adaptation to optimization progress. This leaves a clear question: can we get richer feedback about *where* things went wrong?

### Textual Gradients: TextGrad

[TextGrad](https://arxiv.org/abs/2406.07496) ([Yuksekgonul et al., Nature 2025](https://doi.org/10.1038/s41586-025-08661-4)) answered with an elegant analogy: backpropagation, but with words instead of numbers. In the forward pass, each module $M_i$ produces its output. In the backward pass, an LLM critic generates *textual gradients* — natural language critiques that propagate backward through the computation graph:

**Forward:** $\quad z_i = M_i\bigl(\lbrace z_j : j \in \mathrm{pa}(i)\rbrace;\, \theta_i\bigr)$

**Backward:** $\quad g_i = \mathrm{LLM}_{\text{critic}}\bigl(z_i, \, \mathcal{L}, \, \lbrace g_j : j \in \mathrm{ch}(i)\rbrace\bigr)$

**Update:** $\quad \theta_i \leftarrow \mathrm{LLM}_{\text{edit}}(\theta_i, \, g_i)$

<div align="center">
<img src="textgrad_overview.png" alt="TextGrad overview: backpropagation analogy with textual gradients" style="max-width: 680px; width: 100%;">
<figcaption><em>TextGrad mirrors PyTorch's autograd: variables, loss functions, and gradient descent all have textual counterparts. The critique ("the SQL query misses the JOIN on table X") propagates backward through the computation graph. (Image source: <a href="https://arxiv.org/abs/2406.07496">Yuksekgonul et al. 2024</a>)</em></figcaption>
</div>

This is a genuine leap in credit assignment: from DSPy's "the system failed" to TextGrad's "module 3's SQL query misses the JOIN on table X." The critique tells you *how* to improve, not just *whether* something is good.

But textual gradients have failure modes that the analogy to real gradients obscures. Real gradients are computed by chain rule — they are *mathematically correct* local derivatives. Textual gradients are *generated by a critic LLM*, which can misattribute failures (blaming module 2 when module 4 is at fault), hallucinate improvements that degrade performance, or generate critiques too vague to act on ("try to be more precise"). The quality of optimization is bounded by the quality of the critic, and there is no formal guarantee that textual gradient descent converges. Moreover, each node in the backward pass requires an LLM call, making the full backward pass expensive.

TextGrad can also only optimize text-expressible variables. Model selection, numerical hyperparameters, and trainable weights are outside its reach. This raises a natural question: what if we gave the optimizer more context — not just backward critiques, but the entire execution trace?

### Execution Traces as a Universal Signal: Trace/OPTO

[Trace](https://arxiv.org/abs/2406.16218) ([Cheng, Nie & Swaminathan, NeurIPS 2024](https://arxiv.org/abs/2406.16218)) generalized the idea. Where TextGrad propagates critiques node-by-node, Trace captures the *entire execution trace* — the full computation graph with all intermediate values — and hands it to an optimizer LLM in one shot:

$$\theta' = \mathrm{OptoPrime}(\theta, \, \tau)$$

where $\tau = (\mathcal{G}, f)$ contains the computation graph $\mathcal{G}$ with all intermediate values and output feedback $f$.

<div align="center">
<img src="trace_overview.png" alt="Trace/OPTO framework: execution trace as optimization signal" style="max-width: 680px; width: 100%;">
<figcaption><em>Trace converts any workflow into an OPTO instance: the execution trace (a DAG of intermediate computations and values) is formatted as a pseudo-code report and passed to an optimizer LLM. (Image source: <a href="https://arxiv.org/abs/2406.16218">Cheng et al. 2024</a>)</em></figcaption>
</div>

Trace's credit assignment is structurally richer than TextGrad's: the optimizer sees the full graph and can reason about interactions between modules, not just local critiques. It handles heterogeneous parameters and non-differentiable operations — prompt optimization, hyperparameter tuning, code debugging, and even robot controller design all fit the same abstraction.

The trade-off is generality vs. specialization. Trace is competitive with specialized optimizers across diverse tasks but doesn't achieve state-of-the-art on any single one — a common fate of universal frameworks. More critically, the full execution trace can hit context length limits for large computation graphs. A 10-module pipeline with verbose intermediate outputs may exceed even 128K context windows, creating a fundamental scaling bottleneck.

Both TextGrad and Trace still assume all parameters are text-expressible. But real compound AI systems also have model selection choices, numerical hyperparameters, retrieval parameters, and sometimes trainable weights. What if we want to optimize *all* of these — including the non-textual ones?

### Learning Local Rewards: OPTIMAS

[OPTIMAS](https://arxiv.org/abs/2507.03041) ([Wu et al., ICLR 2026](https://arxiv.org/abs/2507.03041)) tackles heterogeneous parameters head-on with a different kind of credit assignment: a learned **Local Reward Function (LRF)** for each component. The key insight is that if you can learn a reward function scoring each module's output *locally* while correlating with the *global* system metric, you can decouple the optimization — tuning each component independently with whatever method suits its parameter type.

The LRF for module $i$ is:

$$r_i(x_i, z_i) = h_i \cdot \phi([x_i, z_i])$$

where $\phi$ is a shared LLM backbone and $h_i$ is a component-specific linear projection head. The critical property is **local-global alignment**: if the local reward prefers output $z_i^+$ over $z_i^-$, then using $z_i^+$ should also lead to better global performance. The LRF is trained via a preference loss (Bradley-Terry — the same framework used to train reward models in RLHF) on pairs of component outputs where one led to a globally better outcome than the other.

<div align="center">
<img src="optimas_overview.png" alt="OPTIMAS framework: heterogeneous configs with local reward functions" style="max-width: 680px; width: 100%;">
<figcaption><em>OPTIMAS learns a Local Reward Function per component, enabling independent optimization of heterogeneous parameters — prompts via OPRO, hyperparameters via grid search, weights via RL. (Image source: <a href="https://arxiv.org/abs/2507.03041">Wu et al. 2026</a>)</em></figcaption>
</div>

Once LRFs are trained, each component is optimized independently: OPRO for prompts, grid search for hyperparameters, RL for weights. This decoupling brings both efficiency (no full system runs once LRFs are trained) and a convergence guarantee under mild assumptions — the only method here that offers one.

But decoupling has costs. A scalar reward tells you "this is 0.73" but not "the query misses the JOIN on table X" — the directional guidance that makes TextGrad effective is lost. Coordinate-wise optimization also cannot discover optima that require multiple components to change simultaneously. And the local-global alignment assumption can break in tightly coupled systems: when a retriever and a reader must co-adapt, independently optimized local rewards may not compose into a globally optimal solution.

OPTIMAS answers "what to change" (the component with the lowest local reward) but not "how to change it" (the specific direction of improvement). Can we get both?

### Evolutionary Search on a Pareto Front: GEPA

[GEPA](https://arxiv.org/abs/2507.19457) ([Agrawal et al., ICLR 2026 Oral](https://arxiv.org/abs/2507.19457)) combines rich diagnostic feedback with structured search. The algorithm iteratively:

1. **Samples** execution trajectories (both successes and failures)
2. **Reflects** on them in natural language — diagnosing failures and attributing them to specific modules
3. **Proposes** prompt updates based on the diagnosis
4. **Maintains** a Pareto front of the best prompt configurations across training instances

The Pareto front is what makes GEPA escape local optima. Rather than keeping a single "best prompt," GEPA maintains a diverse set of non-dominated configurations — candidates where no other candidate is better on *every* training instance. New candidates are sampled proportionally to how frequently they appear in the instance-wise Pareto frontier, biasing search toward configurations that are uniquely good at solving specific types of inputs.

<div align="center">
<img src="gepa_overview.png" alt="GEPA: trajectory reflection and Pareto front search" style="max-width: 680px; width: 100%;">
<figcaption><em>GEPA combines natural language reflection on execution trajectories with evolutionary search over a Pareto front of prompt candidates. (Image source: <a href="https://arxiv.org/abs/2507.19457">Agrawal et al. 2026</a>)</em></figcaption>
</div>

The results are striking: +13% over MIPROv2, +6% over GRPO with 35x fewer rollouts, all on frozen LLMs without fine-tuning. GEPA is now integrated into DSPy 3.0 as a first-class optimizer.

GEPA's credit assignment sits between TextGrad's per-variable critique (more precise but more expensive) and DSPy's binary filtering (cheaper but uninformative): trajectory-level reflection lets the optimizer reason about which module went wrong and why. The Pareto front adds something none of the other methods have — *diversity maintenance* — which is likely responsible for the sample efficiency gains.

The limitation: GEPA only optimizes text prompts, inheriting TextGrad's blind spot for numerical hyperparameters and model selection. And the quality of the reflection depends on the LLM's ability to diagnose failures in domains it may not fully understand — a shared vulnerability with all critique-based approaches.

### When Weights Are Available: RL Approaches

When you have access to model weights — open models like Llama or Qwen — you can optimize at both the prompt level and the weight level simultaneously.

[BetterTogether](https://arxiv.org/abs/2407.10930) ([Paria et al., EMNLP 2024](https://arxiv.org/abs/2407.10930)) is a meta-optimizer that alternates prompt optimization and weight fine-tuning in configurable sequences, now integrated into DSPy 3.0. [mmGRPO / Arbor](https://arxiv.org/abs/2508.04660) ([Ziems et al. 2025](https://arxiv.org/abs/2508.04660)) generalizes Group Relative Policy Optimization to multi-module LM programs, grouping LM calls by module across rollouts and handling variable-length trajectories. The combination "BetterTogether(PO, mmGRPO)" alternates prompt optimization and RL fine-tuning.

For teams running open models, the question is no longer "prompt engineering or fine-tuning?" but "how to orchestrate both?"

### Comparing the Approaches

| | DSPy/MIPROv2 | TextGrad | Trace/OPTO | OPTIMAS | GEPA |
|---|---|---|---|---|---|
| **Credit assignment** | Binary pass/fail | Per-variable critique | Full trace to optimizer | Learned per-component score | Trajectory-level reflection |
| **Feedback** | Metric score | Textual critique | Execution trace | Learned LRF (scalar) | NL reflection |
| **Parameters** | Instructions + demos | Text variables | Any parameterized workflow | Prompts, weights, hyperparams | Instructions (prompts) |
| **Search** | Bootstrap + Bayesian | Critique-guided rewrite | Graph-level generative update | Coordinate descent + LRF | Evolutionary + Pareto front |
| **Sample efficiency** | Moderate | Low (full backward pass) | Moderate | Moderate (LRF training) | High (35x fewer than RL) |
| **Heterogeneous configs** | Partial | No (text only) | Yes | Yes (key strength) | No (text only) |
| **Convergence guarantee** | No | No | No | Yes (under assumptions) | No |

A critical gap: **TextGrad, GEPA, and OPTIMAS have never been evaluated on the same benchmarks.** Each paper uses different tasks and models. Direct comparison is impossible.

The table also reveals natural complementarities. OPTIMAS's LRF answers "which candidate is better" (fast scoring) but not "how to generate better candidates" — exactly what TextGrad's critiques provide. GEPA's trajectory reflection is rich but text-only — OPTIMAS's LRF could extend it to non-text parameters. These are not idle speculations: the mathematical frameworks are compatible, and a two-phase approach — use textual critique to *generate* candidates, then use learned LRFs to *score* them cheaply — could combine the strengths of both while avoiding the scaling costs of full backward passes.

## Structure Optimization

All the methods above assume a fixed pipeline topology designed by a human. But what if the topology itself is a variable to optimize? Structure optimization searches over the space of possible module arrangements — which components to include, how to wire them, how many copies to run.

This is a harder problem: the search space is combinatorially larger and the feedback signals needed to evaluate entire topologies are richer than those needed to tweak a single prompt. It is no coincidence that the 2x2 taxonomy's bottom-left quadrant (flexible structure + numerical feedback) is nearly empty — discovering useful new topologies typically requires the kind of rich, textual feedback that can describe *why* a structure works.

### Code as Search Space: ADAS

[ADAS](https://arxiv.org/abs/2408.08435) ([Hu et al., ICLR 2025](https://arxiv.org/abs/2408.08435)) proposed a striking idea: define the search space as *arbitrary Python code*. A meta-agent (LLM) iteratively writes new agent implementations, evaluates them, and adds them to an ever-growing archive. The search space is Turing-complete — it can theoretically discover any possible agentic system.

ADAS's historical significance is as the first method to propose code-as-search-space for agentic systems, directly inspiring both AFlow and MASS. But its archive is a flat list of (agent, score) pairs with no structure, leading to context bloat as it grows. A flat archive cannot answer "which *part* of this agent was good?" — the credit assignment problem again, now at the topology level.

### MCTS over Workflows: AFlow

[AFlow](https://arxiv.org/abs/2410.10762) ([Zhang et al., ICLR 2025](https://arxiv.org/abs/2410.10762)) replaced ADAS's flat archive with **Monte Carlo Tree Search**. Tree nodes represent complete workflows; expansion means asking an LLM to modify code. The tree structure tracks which modifications helped on which branch — a form of structured credit assignment over topologies that ADAS's flat archive cannot provide.

AFlow introduced reusable **operators** (Ensemble, Review & Revise, etc.) as building blocks and uses a soft mixed probability for node selection that balances exploration and exploitation:

$$P_{\text{select}}(i) = \lambda \cdot \frac{1}{n} + (1 - \lambda) \cdot \frac{\exp\bigl(\alpha \cdot (s_i - s_{\max})\bigr)}{\sum_j \exp\bigl(\alpha \cdot (s_j - s_{\max})\bigr)}$$

where $s_i$ is workflow $i$'s score, $\alpha = 0.4$ controls score sensitivity, and $\lambda = 0.2$ balances uniform exploration against exploitation.

<div align="center">
<img src="aflow_mcts.png" alt="AFlow: MCTS-based workflow search" style="max-width: 680px; width: 100%;">
<figcaption><em>AFlow applies Monte Carlo Tree Search to workflow discovery. Each node is a complete workflow; expansion creates modified variants. (Image source: <a href="https://arxiv.org/abs/2410.10762">Zhang et al. 2024</a>)</em></figcaption>
</div>

The results are compelling: 80.3% average across 6 benchmarks (+19.5% over ADAS), and workflows discovered with GPT-4o-mini transfer to other models — small models with AFlow-discovered workflows match GPT-4o performance at 4.55% of the inference cost.

But AFlow searches structure while using default prompts for each node. This is like designing a car's chassis while ignoring the engine tuning — it leaves significant performance on the table. Can we optimize both simultaneously?

### Prompts Matter More Than Topology: MASS

[MASS](https://arxiv.org/abs/2502.02533) ([Zhou et al., ICLR 2026](https://arxiv.org/abs/2502.02533)) delivers what may be the most important empirical finding in this space:

> **A single prompt-optimized CoT agent outperforms multi-agent topologies with default prompts at comparable token budgets.**

On MATH with Gemini 1.5 Pro, optimizing the prompt of a single agent and then scaling with self-consistency dominates all multi-agent configurations — self-refine, debate, ensemble — that use default prompts. *Prompt quality trumps agent quantity.*

MASS operationalizes this with a 3-stage pipeline:

1. **Stage 1 (Local Prompt Warmup):** Optimize prompts for each topology block independently using MIPROv2
2. **Stage 2 (Topology Search):** Search over topologies using **influence scores** — $I_i = \mathcal{L}^*(\mathcal{S}_i) / \mathcal{L}^*(\mathcal{S}_0)$ — measuring the relative gain from each topology dimension. Block selection follows $p_i = \mathrm{Softmax}(I_i, \, t)$.
3. **Stage 3 (Global Prompt Re-optimization):** Re-optimize all prompts jointly for the best topology — because locally-optimized prompts are not globally optimal when composed

<div align="center">
<img src="mass_pipeline.png" alt="MASS 3-stage pipeline: local prompt warmup, topology search, global re-optimization" style="max-width: 680px; width: 100%;">
<figcaption><em>MASS's 3-stage framework: first optimize prompts locally per block (Stage 1), then search over topologies using influence-weighted pruning (Stage 2), then re-optimize prompts globally for the best topology (Stage 3). (Image source: <a href="https://arxiv.org/abs/2502.02533">Zhou et al. 2026</a>)</em></figcaption>
</div>

Important caveats: the "topology search" is constrained to a fixed block ordering `[summarize, reflect, debate, aggregate]` where the search decides which blocks to include and their scale — this is block selection, not arbitrary graph search like AFlow. And MASS uses MIPROv2 as its plug-in prompt optimizer, making it difficult to disentangle how much of the gain comes from topology search versus MIPROv2's prompt optimization.

### When Does Structure Actually Matter?

MASS and the concurrent ["Rethinking Multi-Agent Workflows"](https://arxiv.org/abs/2601.12307) ([ICLR 2026](https://arxiv.org/abs/2601.12307)) converge on a nuanced answer:

**Structure matters less than expected** for homogeneous systems (same LLM in every role). A single well-prompted agent with self-consistency often suffices. Multi-turn conversation within one agent can approximate multi-agent debate, with better KV cache efficiency.

**Structure matters more than expected** when modules are **heterogeneous** (different LLMs, tools, retrievers, or code executors play genuinely different roles), when the task requires **tool integration** (retrieval, code execution, API calls), or when specific topologies are **task-dependent** (debate helps on HotpotQA but hurts on LiveCodeBench).

The practical takeaway: **optimize prompts first, then consider adding structure.**

## A Practitioner's Guide

Given the landscape above, which method should you actually use? The answer depends on three factors: what kind of parameters you need to optimize, whether your model weights are accessible, and whether your pipeline topology is settled.

**Your topology is fixed and you only need to optimize prompts.** Start with **DSPy/MIPROv2** — it is the most mature, best-documented, and has the largest community. If MIPROv2 plateaus, try **GEPA** (now in DSPy 3.0) for its superior sample efficiency. If you need per-module diagnostic feedback to understand *why* your pipeline is failing, use **TextGrad** — it is slower but the critiques are invaluable for debugging.

**Your system has heterogeneous parameters** (prompts + hyperparameters + model choices). **OPTIMAS** is the only method designed for this case. Its LRF decouples optimization across parameter types. If you also have open model weights, combine with **BetterTogether** to alternate prompt and weight optimization.

**You are uncertain about the right topology.** First, try MASS's finding: optimize a single-agent prompt with MIPROv2 and scale with self-consistency. If that is insufficient, run MASS's 3-stage pipeline. For unconstrained topology search (research exploration), use **AFlow** — its MCTS scales better than ADAS's flat archive and discovered workflows transfer across models.

**You need a general-purpose optimizer and do not want to choose.** **Trace/OPTO** handles the widest range of parameter types and pipeline structures. It will not be the best at any single thing, but it is a safe default for exploratory work.

**Cost considerations.** All methods require hundreds of system evaluations. Budget roughly 500-2000 LLM calls for optimization. GEPA is the most sample-efficient (35x fewer rollouts than RL). TextGrad is the most expensive per iteration (backward pass through every node). For production teams with tight budgets, DSPy/MIPROv2 offers the best effort-to-improvement ratio.

## What I Think Matters Most

Rather than listing open questions, let me argue for the three directions I believe will have the most impact.

**First, a unified benchmark.** This is boring but essential. GEPA, OPTIMAS, and TextGrad have never been evaluated on the same tasks with the same models. Without controlled comparison, the field is navigating by anecdote. A benchmark suite covering diverse pipeline depths (2-module to 10+), parameter types (text, numerical, model choice), and domains (QA, code, math, retrieval-heavy) would let us retire methods that do not work and double down on those that do. This is the highest-leverage contribution anyone could make right now.

**Second, bridging credit assignment approaches.** The fundamental complementarity between OPTIMAS's scalar LRFs (fast, handles heterogeneous parameters, but directionless) and TextGrad/GEPA's textual feedback (rich, directional, but text-only) is begging to be exploited. A two-phase approach — use textual critique to *generate* candidates, then use learned LRFs to *score* them cheaply — could combine the strengths of both while avoiding the scaling costs of full backward passes. The mathematical frameworks are compatible; the engineering is within reach.

**Third, scaling beyond toy pipelines.** Every method has been validated on systems with $\leq 5$ components. Real production pipelines at companies like FactSet have 10-20+ modules. The credit assignment problem becomes qualitatively harder at this scale: the combinatorial space of module interactions explodes, execution traces exceed context windows, and Pareto fronts become intractably high-dimensional. The method that first demonstrates robust optimization at the 10+ module scale — likely through some form of hierarchical decomposition — will define the next generation of this field.

The broader picture is encouraging. In three years, we have gone from hand-tuned prompts to automatic optimizers with convergence guarantees (OPTIMAS), 35x sample efficiency over RL (GEPA), and transferred workflows that let small models match large ones at 5% of the cost (AFlow). The lesson from process reward models ([Lightman et al. 2023](https://arxiv.org/abs/2305.20050)) — that process supervision dramatically outperforms outcome supervision (78.2% vs. 72.4% on MATH) — is playing out in compound AI optimization: the methods that best attribute credit to individual components are the methods that optimize most effectively. [Databricks Agent Bricks](https://www.databricks.com/blog/introducing-agent-bricks) is the first production deployment, reporting 2x accuracy improvements. The gap between research and production is closing — and the methods described here are how it closes.

## Further Reading

For readers who want to go deeper, here are entry points organized by topic:

- **Foundations:** [Zaharia et al., "The Shift to Compound AI Systems"](https://bair.berkeley.edu/blog/2024/02/18/compound-ai-systems/) — the BAIR blog post that named the paradigm
- **Survey:** [Lee et al. (2025)](https://arxiv.org/abs/2506.08234) — the most comprehensive survey, with the 2x2 taxonomy used in this post
- **DSPy ecosystem:** [Khattab et al. (2023)](https://arxiv.org/abs/2310.03714) for the programming model; [Opsahl-Ong et al. (2024)](https://arxiv.org/abs/2406.11695) for MIPROv2; [Agrawal et al. (2026)](https://arxiv.org/abs/2507.19457) for GEPA
- **Textual optimization:** [Yuksekgonul et al. (Nature 2025)](https://doi.org/10.1038/s41586-025-08661-4) for TextGrad; [Cheng et al. (NeurIPS 2024)](https://arxiv.org/abs/2406.16218) for Trace
- **Heterogeneous optimization:** [Wu et al. (ICLR 2026)](https://arxiv.org/abs/2507.03041) for OPTIMAS
- **Structure search:** [Hu et al. (ICLR 2025)](https://arxiv.org/abs/2408.08435) for ADAS; [Zhang et al. (ICLR 2025)](https://arxiv.org/abs/2410.10762) for AFlow; [Zhou et al. (ICLR 2026)](https://arxiv.org/abs/2502.02533) for MASS
- **RL approaches:** [Paria et al. (EMNLP 2024)](https://arxiv.org/abs/2407.10930) for BetterTogether; [Ziems et al. (2025)](https://arxiv.org/abs/2508.04660) for Arbor
- **Process supervision:** [Lightman et al. (ICLR 2024)](https://arxiv.org/abs/2305.20050) — the principle underlying per-module credit assignment
