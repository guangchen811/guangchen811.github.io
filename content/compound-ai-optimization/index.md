---
title: "Optimizing Compound AI Systems: A Researcher's Map (2024–2026)"
date: 2026-03-11
draft: false
tags:
  - compound-ai
  - optimization
  - survey
categories:
  - Research
summary: "The field has produced 15+ papers on automatically optimizing compound AI systems. This post organizes them into a coherent map: instruction optimization, structure optimization, and their interplay."
ShowToc: true
TocOpen: true
math: true
---

Everyone builds compound AI systems now. RAG pipelines, multi-hop reasoning chains, tool-augmented agents, code-generation workflows — the pattern is the same: multiple LLM calls orchestrated in a directed graph, each with its own prompt, tools, and context.

Yet most teams still optimize these systems by hand-tuning one prompt at a time.

Since Matei Zaharia's influential [BAIR blog post](https://bair.berkeley.edu/blog/2024/02/18/compound-ai-systems/) coined the term "compound AI systems" in early 2024, the research community has produced over 15 papers on *automatic* optimization of these systems — published at NeurIPS 2024, ICLR 2025–2026, Nature, and EMNLP 2025. The results are striking: GEPA outperforms manual prompt engineering by 13%; AFlow discovers workflows that match GPT-4o at 5% of the cost; MASS shows that optimizing prompts matters more than adding agents.

But the landscape is fragmented. DSPy, TextGrad, Trace, OPTIMAS, GEPA, ADAS, AFlow, MASS — what does each do? When should you use which?

This post is the map I wish I had when I started reading these papers. It organizes the field along two axes, compares methods head-to-head, and ends with a practical decision guide.

## The Landscape at a Glance

A [survey by Lee et al. (EMNLP 2025)](https://arxiv.org/abs/2506.08234) proposed a 2×2 taxonomy for compound AI optimization. I find it useful, with one simplification — most methods cluster along a simpler distinction:

- **What to optimize**: instructions (prompts, demos, configs) vs. structure (topology, wiring)
- **What feedback to use**: numerical signals (scalar scores) vs. natural language feedback (textual critique, reflection)

Here's how the major methods map:

<div align="center">
<img src="taxonomy_2x2.png" alt="2×2 taxonomy of compound AI optimization methods" style="max-width: 680px; width: 100%;">
<figcaption><em>Figure 1: The optimization landscape organized by structural flexibility (rows) and feedback type (columns). Most methods cluster in the top row (fixed structure). The bottom-right quadrant is nearly empty.</em></figcaption>
</div>

Most methods sit in the top row — **fixed structure**, because in practice most production pipelines have an engineer-designed DAG that rarely changes. What changes are the prompts, the demonstrations, and the model configurations within each node.

The bottom-right quadrant is nearly empty: there are few methods that search over structures using numerical signals. This is partly because structure search naturally benefits from rich NL feedback (an LLM can describe *why* a workflow failed and *how* to restructure it).

## Part I: Instruction Optimization

Instruction optimization treats the pipeline topology as fixed and tunes each module's parameters — primarily prompts (instructions + few-shot demonstrations), but also model selection, hyperparameters, and weights.

### The Evolution

The field has moved fast. The figure below shows the two parallel tracks — instruction optimization and structure optimization — and how they've converged over time:

<div align="center">
<img src="evolution_timeline.png" alt="Evolution timeline of compound AI optimization methods from 2023 to 2026" style="max-width: 760px; width: 100%;">
<figcaption><em>Figure 2: Two parallel tracks of compound AI optimization research. MASS (2026) is the first method to bridge both tracks.</em></figcaption>
</div>

Let me walk through each branch.

### Branch 1: The DSPy Line — Programming, Not Prompting

[DSPy](https://arxiv.org/abs/2310.03714) (Khattab et al., 2023) introduced the key abstraction: treat LLM pipelines as *programs* with learnable parameters. Signatures define I/O, modules define operations, and *teleprompters* (optimizers) automatically tune prompts and demonstrations.

DSPy's compiler bootstraps few-shot demonstrations by running a teacher program, filtering traces that pass a metric, and using passing traces as demos. [MIPROv2](https://dspy.ai/learn/optimization/optimizers/) upgraded this with joint instruction + demonstration optimization via Bayesian search.

**What DSPy got right:** The declarative programming model. Separating *what* a module does (signature) from *how* it's prompted (parameters) made optimization possible.

**What remains crude:** Demonstration selection. BootstrapFewShot generates candidates by end-to-end metric filtering — it doesn't identify *which* module caused a failure, doesn't measure diversity, and doesn't adapt to optimization progress. This is still DSPy's weakest link.

### Branch 2: TextGrad — Backpropagation via Text

[TextGrad](https://doi.org/10.1038/s41586-025-08661-4) (Yuksekgonul et al., Nature 2025) introduced a compelling analogy: **textual gradients**. An LLM generates critiques ("the SQL query misses the JOIN on table X") that propagate backward through the computation graph, just as numerical gradients flow through a neural network. An optimizer LLM then incorporates the critique to produce an updated variable.

TextGrad mirrors PyTorch's abstractions — `tg.Variable`, `tg.BlackboxLLM`, `tg.TextLoss`, `tg.TGD` — making it immediately familiar to ML practitioners.

**Strengths:** Rich directional feedback. The critique tells you *how* to improve, not just *whether* something is good. General across domains (prompts, code, molecules, treatment plans). Interpretable — gradients are human-readable.

**Limitations:** Only works for text-expressible variables. Cannot optimize model selection, numerical hyperparameters, or weights. Full backward pass through the computation graph is expensive. No convergence guarantee.

### Branch 3: Trace/OPTO — Execution Traces as the Universal Signal

[Trace](https://arxiv.org/abs/2406.16218) (Cheng, Nie, Swaminathan; NeurIPS 2024) generalized the idea further. It frames compound AI optimization as **OPTO** (Optimization with Trace Oracle): the optimizer receives the full execution trace of a workflow (analogous to a computation graph with intermediate values) plus feedback on the output, and updates parameters.

Their LLM-based optimizer, **OptoPrime**, represents the execution trace in context and performs what they call "generative backpropagation." Like TextGrad, it uses LLM feedback, but it operates on the *execution trace* rather than propagating critiques node-by-node.

Trace uses PyTorch-like syntax (`trace.node`, `trace.bundle`) to convert any workflow optimization problem into an OPTO instance. It handles heterogeneous parameters and non-differentiable operations.

**Strengths:** Most general framework — subsumes prompt optimization, hyperparameter tuning, code debugging, and even robot controller design. Clean API.

**Limitations:** Context length bottleneck for large graphs. Competitive with specialized optimizers but not state-of-the-art on any single task — a jack of all trades.

### Branch 4: OPTIMAS — Local Rewards for Heterogeneous Systems

[OPTIMAS](https://arxiv.org/abs/2507.03041) (Wu et al., ICLR 2026) tackled a problem others ignored: **heterogeneous configurations**. Real compound AI systems don't just have prompts — they have model selection choices, numerical hyperparameters, retrieval parameters, and sometimes trainable weights. TextGrad and GEPA can only optimize text.

OPTIMAS's key idea: learn a **Local Reward Function (LRF)** per component, implemented as a shared LLM backbone with component-specific projection heads. The LRF satisfies *local-global alignment*: maximizing a component's local reward correlates with improving global system performance. Each component is then optimized independently using whatever method suits its type — OPRO for prompts, grid search for hyperparameters, RL for weights.

**Strengths:** The only method that handles truly heterogeneous configurations. Higher data efficiency (avoids full system runs once LRFs are trained). Convergence guarantee under mild conditions. 11.9% average improvement across 5 diverse systems.

**Limitations:** Scalar reward only — no directional guidance ("this is 0.73" vs. "the query misses the JOIN"). Tiny search space (3 prompt candidates per iteration). Coordinate-wise optimization cannot discover optima requiring multiple components to change simultaneously.

### Branch 5: GEPA — The Current Champion

[GEPA](https://arxiv.org/abs/2507.19457) (Agrawal et al., **ICLR 2026 Oral**) combines trajectory-level reflection with evolutionary search. The algorithm:

1. **Sample** execution trajectories (both successes and failures)
2. **Reflect** on them in natural language — diagnose problems, attribute failures to specific modules
3. **Propose** prompt updates based on the diagnosis
4. **Maintain** a Pareto front of best prompts across multiple objectives

The Pareto front is what makes GEPA escape local optima that plague greedy optimizers. Instead of a single "best prompt," GEPA maintains a diverse set of prompts that trade off different objectives.

**Results:** +13% over MIPROv2, +6% over GRPO (reinforcement learning) with 35× fewer rollouts. Works on frozen LLMs — no fine-tuning needed. Now integrated into DSPy 3.0 as a first-class optimizer.

**Why it's the current champion for instruction optimization:** It combines the richness of NL reflection (like TextGrad) with structured search (Pareto front), and it's dramatically more sample-efficient than RL approaches.

### Branch 6: The RL Branch — mmGRPO and BetterTogether

The newest direction composing RL with prompt optimization:

- [**BetterTogether**](https://arxiv.org/abs/2407.10930) (EMNLP 2024, now in DSPy 3.0): A meta-optimizer that alternates prompt optimization and weight fine-tuning in configurable sequences.
- [**mmGRPO / Arbor**](https://arxiv.org/abs/2508.04660) (Ziems et al., 2025): Generalizes GRPO (Group Relative Policy Optimization) to multi-module LM programs. Groups LM calls by module across rollouts, handles variable-length trajectories. "BetterTogether(PO, mmGRPO)" alternates prompt optimization and RL fine-tuning.

This branch matters because it bridges the gap between *prompt-only* optimization and *weight-level* fine-tuning. When you have access to model weights (open models like Llama, Qwen), you can optimize at both levels simultaneously.

### Head-to-Head: Comparing the Approaches

Here is how the major instruction optimizers compare along key dimensions:

| | OPTIMAS | TextGrad | GEPA | Trace/OPTO | DSPy/MIPROv2 |
|---|---|---|---|---|---|
| **Feedback type** | Scalar (learned LRF) | Textual critique | NL reflection on trajectories | Execution trace + feedback | Metric score |
| **What it optimizes** | Prompts, weights, hyperparams, model selection | Text-expressible variables | Instructions (prompts) | Any parameterized workflow | Instructions + demonstrations |
| **Search strategy** | Coordinate descent + LRF scoring | Critique-guided rewrite | Evolutionary + Pareto front | Graph-level generative update | Bootstrap + Bayesian search |
| **Sample efficiency** | Moderate (needs LRF training data) | Low (full backward pass) | High (35× fewer than RL) | Moderate | Moderate |
| **Heterogeneous configs** | Yes (key strength) | No (text only) | No (text only) | Yes | Partial |
| **Convergence guarantee** | Yes (under assumptions) | No | No | No | No |
| **Best result reported** | +11.9% avg (5 systems) | Nature publication, diverse domains | +13% over MIPROv2 (ICLR Oral) | Competitive across domains | Baseline for most comparisons |
| **Code** | [optimas](https://optimas.stanford.edu/) | [textgrad](https://github.com/zou-group/textgrad) | [gepa](https://github.com/gepa-ai/gepa) | [Trace](https://github.com/microsoft/Trace) | [dspy](https://github.com/stanfordnlp/dspy) |

A critical gap: **TextGrad, GEPA, and OPTIMAS have never been compared on the same benchmarks.** Each paper uses different tasks. The field badly needs a unified benchmark — this is one of the most important open problems.

### The Hybrid Opportunity

These approaches have complementary strengths. Some natural combinations that haven't been built yet:

- **OPTIMAS's LRF + TextGrad's critique**: LRF answers "which candidate is better" (fast scoring), critique answers "how to generate better candidates" (directional guidance). This could address OPTIMAS's blind 3-candidate search.
- **GEPA's trajectory reflection + OPTIMAS's heterogeneous support**: GEPA currently only optimizes text prompts. Extending its reflection mechanism to score non-text configurations would broaden its applicability.
- **Trace's execution graph + GEPA's Pareto search**: Trace provides a principled way to extract optimization signals from execution traces; GEPA provides a principled way to search over prompt candidates.

## Part II: Structure Optimization

Structure optimization goes beyond tuning parameters within a fixed topology — it also searches over the topology itself: which modules to include, how to wire them, how many copies to run.

### The Evolution

The structure optimization track (teal in Figure 2) evolved from ADAS's pioneering code-as-search-space idea through AFlow's MCTS-based refinement to MASS's joint optimization with prompts.

### ADAS: Code as Search Space

[ADAS](https://arxiv.org/abs/2408.08435) (Hu et al., ICLR 2025) proposed a striking idea: define the search space as *arbitrary Python code*. A meta-agent (LLM) iteratively writes new agent implementations, evaluates them, and adds them to an ever-growing archive. The code-based search space is Turing-complete — it can theoretically discover any possible agentic system.

**Historical significance:** First to propose code-as-search-space for agentic systems. Directly inspired AFlow and MASS.

**Limitation:** Linear search. The archive is a flat list of (agent, score) pairs with no structure. The meta-agent sees the full archive each iteration, leading to context bloat. AFlow's tree structure directly addressed this.

### AFlow: MCTS over Workflows

[AFlow](https://arxiv.org/abs/2410.10762) (Zhang et al., ICLR 2025) replaced ADAS's flat archive with **Monte Carlo Tree Search (MCTS)**. Tree nodes represent complete workflows; expansion means asking an LLM to modify code. The tree structure tracks which modifications helped on which branch — structured experience management.

AFlow introduced reusable **operators** (Ensemble, Review & Revise, etc.) as building blocks, constraining the search space without eliminating expressiveness.

**Results:** 80.3% average across 6 benchmarks, +19.5% over ADAS. Workflows found with GPT-4o-mini transfer to other models, and small models with AFlow-found workflows reach GPT-4o performance at 4.55% of inference cost.

**Limitation:** No prompt optimization — searches structure but uses default prompts. As MASS later showed, this leaves significant performance on the table.

### MASS: Prompts Matter More Than Topology

[MASS](https://arxiv.org/abs/2502.02533) (Zhou et al., ICLR 2026) is the most important paper for understanding the interplay between instruction and structure optimization. Its key finding is counter-intuitive:

> **A single prompt-optimized CoT agent outperforms multi-agent topologies with default prompts at comparable token budgets.**

On MATH with Gemini 1.5 Pro, optimizing the prompt of a single agent (via MIPRO) and then scaling with self-consistency dominates all multi-agent configurations (self-refine, debate, ensemble) that use default prompts. *Prompt quality trumps agent quantity.*

MASS's 3-stage pipeline operationalizes this insight:

1. **Stage 1 (Local Prompt Warmup):** Optimize prompts for each topology block independently
2. **Stage 2 (Topology Search):** Search over a pruned set of influential topologies using influence-weighted sampling
3. **Stage 3 (Global Prompt Re-optimization):** Re-optimize all prompts jointly for the best topology — because locally-optimized prompts aren't globally optimal when composed

**Results:** 78.8% average on 8 tasks with Gemini 1.5 Pro, outperforming both manually crafted and auto-generated baselines.

**Important caveats:**
- The "topology search" is constrained: a fixed ordering `[summarize, reflect, debate, aggregate]` where the search decides which blocks to include and their scale parameters. This is block selection, not arbitrary graph search like AFlow.
- MASS uses MIPRO as its plug-in prompt optimizer — gains may largely come from MIPRO itself.
- Influence scores are measured independently per block, missing interaction effects.

### Comparison: Structure Optimizers

| | ADAS | AFlow | MASS |
|---|---|---|---|
| **Search space** | Arbitrary Python code | Code with predefined operators | Fixed block ordering (constrained) |
| **Search method** | Flat archive + meta-LLM | MCTS with tree-structured experience | Influence-weighted pruning + 3-stage |
| **Prompt optimization** | None | None | Yes (MIPRO plug-in) |
| **Key strength** | Maximum expressiveness | Structured search, cost-efficient | Joint optimization, best overall results |
| **Key weakness** | Linear search, context bloat | No prompt optimization | Constrained topology space |
| **Avg. performance** | 67.2 (6 tasks) | 80.3 (6 tasks) | 78.8 (8 tasks) |

### When Does Structure Actually Matter?

MASS and the concurrent work ["Rethinking Multi-Agent Workflows"](https://arxiv.org/abs/2601.12307) (ICLR 2026) converge on a nuanced answer:

**Structure matters less than you think** for homogeneous systems (same LLM in every role). A single well-prompted agent with self-consistency often suffices. Multi-turn conversation within one agent can approximate multi-agent debate, with better KV cache efficiency.

**Structure matters more than you think** when:
- Modules are **heterogeneous** — different LLMs, tools, retrievers, or code executors play genuinely different roles
- The task requires **tool integration** — retrieval, code execution, API calls add capabilities a single LLM doesn't have
- Specific topologies are **task-dependent** — debate helps on HotpotQA (+3%) but hurts on LiveCodeBench (−15%); tool-use helps on LiveCodeBench (+10%)

The practical takeaway: **optimize prompts first, then consider adding structure.**

## Part III: The Credit Assignment Problem

Underlying both instruction and structure optimization is a shared challenge: **credit assignment**. When a compound AI system produces a wrong answer, which module caused the failure?

This problem is fundamental because the quality of your optimization depends on the quality of your feedback signal. If you can't tell whether the retriever or the generator failed, you can't optimize either one effectively.

### How Different Methods Handle Credit Assignment

| Method | Approach | Signal type |
|---|---|---|
| DSPy/MIPROv2 | End-to-end metric filtering | Binary (pass/fail) |
| TextGrad | Backward propagation of critique through graph | Textual per-variable |
| OPTIMAS | Learned LRF per component with local-global alignment | Scalar per-component |
| GEPA | NL reflection on full execution trajectories | Textual per-module (implicit) |
| Trace/OPTO | Full execution trace passed to optimizer | Structured (trace + feedback) |
| JudgeFlow | Dedicated judge module inspects traces, assigns rank-based responsibility scores | Scalar per-block (explicit) |

The trend is clear: methods are moving from coarse signals (end-to-end pass/fail) toward fine-grained, per-module attribution. This mirrors the lesson from [PRM](https://arxiv.org/abs/2305.20050) (Lightman et al., ICLR 2024): **process supervision dramatically outperforms outcome supervision** — 78.2% vs. 72.4% on MATH. The same principle applies to compound AI: per-module feedback should outperform end-to-end feedback.

## Practical Guide: Which Method Should You Use?

Here is a decision framework based on your system's characteristics:

**Start with your constraints:**

1. **Is your pipeline structure fixed?**
   - **Yes** → instruction optimization only (most common case)
   - **No** → consider structure optimization (Section II)

2. **Do you have heterogeneous configs?** (not just prompts — also model selection, hyperparams, weights)
   - **Yes** → **OPTIMAS** (the only method that handles all config types)
   - **No** → next question

3. **Do you have access to model weights?** (open-source models like Llama, Qwen)
   - **Yes** → **BetterTogether / mmGRPO** (combine prompt + weight optimization)
   - **No** → next question

4. **Is sample efficiency critical?** (expensive API calls, limited budget)
   - **Yes** → **GEPA** (35× fewer rollouts than RL, +13% over MIPROv2)
   - **No** → next question

5. **Do you want interpretable optimization?** (need to understand *why* prompts changed)
   - **Yes** → **TextGrad** (human-readable critiques as gradients)
   - **No** → **DSPy/MIPROv2** (battle-tested, widest ecosystem, production-ready with Databricks Agent Bricks)

6. **Do you also need structure search?**
   - **With prompt optimization** → **MASS** (joint, but constrained topology)
   - **Without prompt optimization** → **AFlow** (most expressive structural search)
   - **General-purpose framework** → **Trace/OPTO** (handles anything, excels at nothing specifically)

## Open Problems

Despite rapid progress, several fundamental problems remain:

**1. No unified benchmark.** GEPA, OPTIMAS, and TextGrad are each evaluated on different tasks with different models. The field's most needed contribution isn't a new method — it's a standardized benchmark that enables apples-to-apples comparison.

**2. Scalability ceiling.** Every method in this survey has been validated on systems with ≤5 components. Real production pipelines can have 10–20+ modules. Whether coordinate descent (OPTIMAS), backward propagation (TextGrad), or evolutionary search (GEPA) scale to this regime is unknown.

**3. Co-optimization is primitive.** MASS's 3-stage pipeline is the only attempt at joint instruction + structure optimization, and its topology search is constrained. A principled co-optimizer that combines AFlow's structural expressiveness with GEPA's instruction optimization does not exist yet.

**4. Data selection is the weakest link.** Instruction optimization has matured rapidly (OPRO → MIPROv2 → GEPA in three years). But *which examples each module learns from* — demonstration selection — is still handled by DSPy's 2023-era bootstrap + random search. Principled, system-aware example selection remains wide open.

**5. Production gap.** Optimization requires hundreds of system runs, making it expensive. [Databricks Agent Bricks](https://www.databricks.com/blog/introducing-agent-bricks) is the first production deployment of these ideas, reporting 2× accuracy improvements and development time reduction from weeks to one day. But for most teams, compound AI optimization remains a research tool, not a production practice.

## Reference Table

| Method | Venue | Optimizes | Feedback | Code |
|---|---|---|---|---|
| [DSPy](https://arxiv.org/abs/2310.03714) | arXiv 2023 | Instructions + demos | Metric score | [github](https://github.com/stanfordnlp/dspy) |
| [OPRO](https://arxiv.org/abs/2309.03409) | ICLR 2024 | Instructions | Metric score | — |
| [PRM](https://arxiv.org/abs/2305.20050) | ICLR 2024 | Reward models | Step-level labels | — |
| [Trace/OPTO](https://arxiv.org/abs/2406.16218) | NeurIPS 2024 | Any parameter | Execution trace | [github](https://github.com/microsoft/Trace) |
| [TextGrad](https://doi.org/10.1038/s41586-025-08661-4) | Nature 2025 | Text variables | Textual critique | [github](https://github.com/zou-group/textgrad) |
| [ADAS](https://arxiv.org/abs/2408.08435) | ICLR 2025 | Topology (code) | NL feedback | [github](https://github.com/ShengranHu/ADAS) |
| [AFlow](https://arxiv.org/abs/2410.10762) | ICLR 2025 | Topology (code) | NL feedback | [github](https://github.com/FoundationAgents/AFlow) |
| [BetterTogether](https://arxiv.org/abs/2407.10930) | EMNLP 2024 | Prompts + weights | Metric score | [dspy](https://github.com/stanfordnlp/dspy) |
| [OPTIMAS](https://arxiv.org/abs/2507.03041) | ICLR 2026 | Heterogeneous configs | Learned LRF (scalar) | [project](https://optimas.stanford.edu/) |
| [GEPA](https://arxiv.org/abs/2507.19457) | ICLR 2026 (Oral) | Instructions | NL reflection | [github](https://github.com/gepa-ai/gepa) |
| [MASS](https://arxiv.org/abs/2502.02533) | ICLR 2026 | Prompts + topology | NL feedback + metric | — |
| [mmGRPO](https://arxiv.org/abs/2508.04660) | arXiv 2025 | Prompts + weights (RL) | Policy gradient | [github](https://github.com/Ziems/arbor) |

---

*This post surveys the optimization landscape as of March 2026. The field is moving fast — I expect several of the "open problems" listed above to have initial solutions by the end of the year. If I missed a relevant paper or got something wrong, please let me know.*
