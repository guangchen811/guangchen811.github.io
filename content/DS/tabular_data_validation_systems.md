---
title: "Tabular Data Validation Systems"
date: 2026-03-18
draft: true
tags:
- Data Quality
- Data Validation
- Data Management
---

Data pipelines fail quietly. A column that was always populated starts arriving with nulls. An identifier that was supposed to be unique now has duplicates. A categorical field that encoded status codes now contains free-form text. These problems rarely cause immediate crashes — they propagate silently, corrupt downstream aggregations, and surface as hard-to-diagnose inconsistencies weeks later. Tabular data validation systems exist to make these problems explicit before they spread. This post examines how two widely used frameworks — Deequ and Great Expectations — approach the problem, focusing not on their feature lists but on the systems design decisions that give each its character.

## What Is Tabular Data Validation?

Tabular data validation is the task of checking whether a dataset satisfies a set of expected structural and semantic properties before the data is consumed downstream. In practice, these properties are often simple to state but costly to enforce consistently at scale: a key column should be unique, required attributes should not be missing, numerical values should stay within an acceptable range, and categorical values should come from a known domain.

From a systems perspective, data validation is not just about detecting bad records. It is about making data quality checks explicit, repeatable, and executable as part of a data pipeline. Without such a system, validation often appears as ad hoc SQL queries, notebook code, one-off dashboards, or manual inspection. These approaches may work temporarily, but they do not provide a durable interface for expressing data quality requirements or reusing them across teams and pipelines.

This is why modern validation frameworks treat data quality checks as first-class program objects. Instead of scattering checks across scripts and dashboards, they let users declare expected properties of data and run them systematically. The core idea is close to software testing: validation frameworks aim to support "tests for data," but the underlying execution problem is different because the object under test is a dataset, not a function.

The main challenge is that even simple checks are not free. A uniqueness check may require global aggregation. A type consistency check may require scanning an entire column. A richer validation workflow may also need historical comparisons, debugging output, or automated actions after failures. As a result, tabular data validation systems are not just rule libraries. They are execution systems that must balance expressiveness, efficiency, and usability.

## Core Abstractions Behind Validation Systems

Although different frameworks use different terminology, most tabular validation systems share the same basic pipeline. A user declares some expected properties of a dataset, the system maps those declarations to executable computations, and the system returns structured evidence about whether the expectations hold.

At the highest level, the semantic unit is a validation rule. In Great Expectations, this unit is an `Expectation`. In Deequ, users write `Checks` that are composed of `Constraints`. The naming differs, but the role is the same: define a condition that should hold on the data.

Validation rules are then grouped into a larger validation object. In Great Expectations this is an `Expectation Suite`, while in Deequ multiple constraints are grouped into checks that are submitted together for verification. This grouping matters because validation systems rarely execute rules fully independently. Once multiple rules are known together, the system can plan shared computation, return a combined result, and attach run-level metadata.

A second important abstraction is the binding between a rule set and actual data. Great Expectations makes this explicit through the notion of a `Batch` and a `Validation Definition`: an expectation suite does not run in isolation, but against a specific batch of data selected by batch parameters. Deequ exposes this binding less explicitly in the API, but the same idea is present: verification is always performed against a concrete dataset, typically represented as a Spark DataFrame.

A third abstraction is the execution substrate. Here the systems start to diverge. Deequ makes metrics central: constraints are translated into required metrics, and analyzers compute these metrics efficiently. Great Expectations presents expectations as the central abstraction to users, but its validator still needs an internal execution mechanism that determines which metrics or dependencies must be resolved before a final expectation result can be produced.

Finally, both systems need a result object. A validation system does not only answer whether the data passed. It also has to report enough evidence to make failures actionable. This evidence may include aggregate statistics, failing values, identifiers of unexpected rows, or metadata about the run. In practice, result representation is part of the system design rather than an afterthought, because debugging and operational response depend on it.

These abstractions give a useful lens for comparing systems. Instead of asking only what kinds of checks a framework supports, we can ask a more systematic set of questions: what is the user-facing rule abstraction, how is it bound to data, how is execution planned, what evidence is returned, and how does validation fit into a larger pipeline.

## Constraint Types and Coverage

Before comparing DSLs and execution models, it is useful to ask a simpler question: what kinds of constraints do these systems actually cover? This matters for two reasons. First, the range of supported constraint types tells us what each framework treats as part of data validation rather than as a separate profiling, cleaning, or monitoring problem. Second, the constraint taxonomy is likely to be useful later when thinking about how a graph validation system should be designed.

At a high level, both Deequ and Great Expectations cover a common core of tabular quality constraints. These include completeness constraints, uniqueness constraints, domain constraints, range constraints, type-oriented constraints, and row-level compliance conditions. In other words, both systems support the classical checks that most practitioners expect from a tabular validation framework: whether values are present, whether identifiers are unique, whether fields fall into allowed sets or intervals, and whether rows satisfy specified predicates.

Beyond this common core, Deequ makes some additional constraint classes especially explicit. In the paper, many summary statistics are first-class validation inputs, including minimum, maximum, mean, standard deviation, quantiles, entropy, correlation, and mutual information. Deequ also includes less conventional notions such as predictability, where one column should be inferable from others with sufficiently high accuracy, and anomaly detection over historical metric series. This gives Deequ a broader notion of validation, one that extends from integrity-style checks into profiling and longitudinal monitoring.

Great Expectations covers many of the same practical cases through its large collection of expectations, but its presentation is different. It foregrounds reusable expectations over columns, column pairs, multicolumn conditions, and table-level properties. In the user-facing model, the focus is less on naming underlying metric families and more on naming reusable assertions. This makes the taxonomy feel more expectation-centric than analyzer-centric, even when similar computations are required underneath.

For the rest of this discussion, a useful way to summarize the tabular constraint space is to divide it into at least six categories: value presence, value domain, value relationship, row predicate compliance, table-level statistics, and history-aware or drift-aware checks. This framing is helpful because it separates constraints by semantic role rather than by API spelling.

## DSL Design for Data Validation

One useful way to analyze tabular validation systems is through the design of their DSLs. A validation DSL is not merely a matter of syntax. It is the interface through which users express quality requirements, and it also determines how much structure the system can recover for planning and optimization. In practice, two styles appear repeatedly: assertion-oriented DSLs and metric-oriented DSLs.

In an assertion-oriented DSL, the user states the desired property of the data directly. Typical examples are that a column must be unique, a field must be complete, or a value must lie in a given range. In a metric-oriented DSL, the user instead writes predicates over statistics derived from the data, such as requiring a uniqueness ratio to equal one or a completeness score to exceed a threshold. These two styles are best viewed as different interfaces to nearly the same semantic space. Many assertion-oriented rules can be compiled into predicates over metrics, and many metric-based predicates correspond to familiar data quality assertions.

The real difference is therefore not raw expressivity, but where the interface is optimized. Assertion-oriented DSLs are usually better surface languages for humans because they are closer to the way data quality requirements are naturally stated. Metric-oriented DSLs are often better internal forms for execution engines because they normalize heterogeneous checks into a smaller set of reusable computations. This distinction is especially important for system design: a framework may expose an assertion-oriented user API while still reducing all checks to a metric-oriented intermediate representation internally.

Deequ is a good example of this split design. At the API level, it looks assertion-oriented: users write checks such as `isComplete`, `isUnique`, `isContainedIn`, or `satisfies`. However, the system is fundamentally organized around metrics and analyzers. Each constraint is translated into one or more required metrics, and execution is planned around those metrics rather than around the original assertions themselves. In this sense, Deequ's DSL is best understood as assertion-oriented syntax over a metric-oriented execution model.

Great Expectations is more consistently expectation-oriented in the way it presents validation to users. Its core semantic unit is the Expectation, and Expectation Suites organize multiple expectations into reusable validation contracts. This makes the DSL read like a specification language for dataset properties. Internally, Great Expectations still requires a dependency resolution and metric computation layer, but that machinery is largely hidden behind the validator and checkpoint workflow. As a result, its user-facing DSL feels closer to a contract language than to a metric query language.

Conditional validation provides a concrete way to compare the two DSL styles. Suppose we want to express the rule that `order_id` must be unique only for rows with `status = 'PAID'`. In Deequ, the natural form is to write the uniqueness constraint and attach a `.where(...)` clause to it. In Great Expectations, the analogous form is to write an expectation with a `row_condition`.

```scala
// Deequ (Scala): condition as a filter on the constraint
Check(CheckLevel.Error, "order uniqueness")
  .isUnique("order_id", where = Some("status = 'PAID'"))
```

```python
# Great Expectations (Python): condition as a parameter of the expectation
suite.add_expectation(
    gx.expectations.ExpectColumnValuesToBeUnique(
        column="order_id",
        row_condition="status == 'PAID'",
        condition_parser="pandas",
    )
)
```

Both formulations express the same validation intent and are therefore similarly expressive for this case. The difference is again one of interface: Deequ presents the condition as a filter on the rule, while Great Expectations presents it as a parameter of the expectation. This is a small syntactic distinction, but it reflects the larger design difference between a system centered on filtered metric computation and a system centered on reusable expectations.

For a systems-oriented discussion, the most useful conclusion is that assertion-oriented and metric-oriented DSLs should not be treated as mutually exclusive categories. A mature validation system often needs both: an assertion-oriented surface language for usability and a metric-oriented internal form for execution. The most interesting design question is not which style is universally better, but how well the system connects the two.

## Deequ: Validation as Metric Planning and Optimized Execution

Deequ is best understood as a data validation system whose core contribution lies in execution. Its user-facing API is concise and declarative, but the main systems idea is that validation rules are not executed one by one. Instead, Deequ inspects the requested constraints, determines which metrics are needed to evaluate them, and then plans the computation of those metrics in an optimized way. This shift from "run checks" to "plan metric computation" is what gives the system its identity.

The central pipeline in Deequ is straightforward but powerful. Users define `Checks`, checks contain `Constraints`, constraints depend on `Metrics`, and metrics are computed by `Analyzers`. The runtime layer then schedules analyzers rather than original assertions. This means that two apparently different user-facing constraints may share the same physical computation. For example, several checks on completeness, compliance, or size can be reduced to aggregations that are evaluated together rather than in separate scans of the dataset.

This design is closely tied to Spark. Deequ operates on DataFrames and compiles many metric computations into Spark aggregation queries. The paper emphasizes scan sharing as a primary optimization: if multiple metrics require compatible aggregation patterns, Deequ groups them into a single pass over the data. From a systems perspective, this is the key advantage of making metrics explicit. Once validation is normalized into a relatively small set of metric computations, the engine can optimize globally instead of evaluating each high-level rule in isolation.

The paper also makes incremental validation a first-class concern. Real-world datasets often grow through repeated ingestions, and re-scanning the full table for every validation run is wasteful. Deequ therefore reformulates several metrics so they can be updated from previously stored state plus the latest delta. Simple metrics such as size or completeness require only small sufficient statistics, while more complex metrics such as entropy, uniqueness, or mutual information may require persisted histograms or co-occurrence structures. This is an important reminder that not all validation rules are equally incremental: the benefit depends on how compactly the underlying state can be maintained.

Another notable feature is that Deequ extends validation beyond one-shot checks. The system stores metric histories, supports anomaly detection over metric time series, and includes machinery for suggesting constraints from lightweight profiling. These features reinforce the idea that Deequ is not just a library of assertions. It is a metric-centric validation platform in which execution, historical comparison, and suggestion are all organized around the same metric substrate.

This execution model also clarifies why Deequ reads like a systems paper. The novelty is not primarily that it offers null checks, uniqueness checks, or range checks. Many frameworks can do that. The interesting contribution is that it turns heterogeneous validation rules into a common analyzable form, optimizes them as a shared computation problem, and supports incremental maintenance and historical reasoning on top of that representation.

## Great Expectations: Validation as Expectation Workflow

Great Expectations approaches tabular validation from a different angle. While it also needs an execution engine internally, its user-facing design is centered less on metric planning and more on reusable validation artifacts and operational workflow. The core abstraction is the `Expectation`, and expectations are grouped into `Expectation Suites` that describe the intended state of a dataset. This gives the system a different emphasis from Deequ. Deequ also exposes reusable validation objects such as checks and constraints, but the system is explained primarily through how those objects are reduced to metrics and analyzers. Great Expectations, by contrast, foregrounds expectation suites, validation definitions, checkpoints, and actions as the main organizing abstractions.

This orientation becomes clearer once execution is considered. In Great Expectations, an expectation suite does not run by itself. It is bound to data through a `Validation Definition`, which links a suite to a specific batch definition, and production execution is typically orchestrated through a `Checkpoint`. A checkpoint runs one or more validation definitions, collects validation results, and then triggers follow-up actions such as notifications or Data Docs updates. This makes validation part of a broader workflow rather than only a library call that returns pass or fail.

Internally, Great Expectations still performs nontrivial planning. The validator processes expectation configurations, derives validation dependencies, builds expectation-level dependency subgraphs, merges them into a suite-level validation graph, resolves the required metrics, and only then evaluates expectations against the resolved results. So Great Expectations is not merely a thin wrapper over row-wise predicates. It has a genuine internal execution layer. However, unlike in Deequ, this layer is not the central concept exposed to users. The visible system identity remains expectation suites, validation definitions, checkpoints, and actions.

Result representation is also more prominent in Great Expectations than in Deequ. The system allows users to control the `result_format`, ranging from minimal boolean output to detailed reports with unexpected values, indices, queries, and in some cases full offending rows. This is not a minor implementation detail. It reflects an important design choice: validation output is treated as an operational artifact used for debugging, communication, and governance. In other words, Great Expectations invests heavily not only in deciding whether a dataset is valid, but also in packaging the evidence of that decision for downstream use.

From a systems perspective, Great Expectations can therefore be read as a validation workflow platform with an internal metric and dependency engine. Its strength lies in making expectations reusable, executions repeatable, and results actionable inside a larger data engineering process. Compared with Deequ, it places less visible emphasis on exposing the physical execution model and more emphasis on managing the lifecycle of validation itself.

## Common Structure Across Systems

Despite their different emphases, Deequ and Great Expectations share a common architectural pattern. In both systems, validation begins with declarative rules written by the user. These rules are grouped into larger validation units, bound to a concrete dataset or batch, translated into executable computations, and finally returned as structured validation results. At this level of abstraction, the systems are much closer than their APIs might initially suggest.

This common structure can be described as a recurring pipeline. First, the user specifies intended properties of the data. Second, the system determines what computations are necessary to evaluate those properties. Third, the engine executes those computations over the dataset. Fourth, the system packages the outcome as a result object that can be inspected by users or consumed by downstream workflow components. Both Deequ and Great Expectations follow this pattern, even though they present different parts of it more prominently.

Another shared feature is that both systems separate the surface language of validation from the lower-level execution problem. Neither framework literally executes high-level assertions as written. Deequ reduces checks and constraints to metrics and analyzers. Great Expectations reduces expectations to validation dependencies and metric resolution steps before producing expectation results. This means that both systems, in different ways, treat validation as a compilation problem: user-facing declarations must be translated into a more regular internal form before efficient execution becomes possible.

They also both recognize that validation is more than boolean acceptance. A practical validation system must support debugging, reporting, and repeated execution. This is why both frameworks return structured evidence, track metadata about validation runs, and provide machinery for integrating validation into data pipelines. Even where their implementation details differ, they share the underlying assumption that data validation is an operational systems problem rather than just a collection of predicates.

## Where the Systems Differ

The most important difference between Deequ and Great Expectations is not the surface list of checks they support, but what each system treats as the center of the validation problem. Deequ treats validation primarily as an execution problem. Its defining abstractions are metrics, analyzers, and optimized computation over large datasets. Great Expectations treats validation more as a specification and workflow problem. Its defining abstractions are expectations, suites, validation definitions, checkpoints, actions, and richly configurable result objects.

This difference affects how each system is best understood. In Deequ, the user-facing DSL is only the entry point. The deeper story is how heterogeneous constraints are normalized into a smaller family of metrics that can be shared, optimized, and incrementally maintained. In Great Expectations, the deeper story is how expectations become reusable validation artifacts that can be bound to data, executed repeatedly, and integrated with operational responses. Both systems compile declarative validation into executable form, but they foreground different parts of that pipeline.

The result models also reveal this distinction. Deequ certainly provides validation output and can be integrated into pipelines, but its paper emphasizes efficient computation, incremental maintenance, and metric histories. Great Expectations puts more explicit weight on the representation of validation results themselves, including configurable detail levels, unexpected values, row identifiers, and follow-up actions. This makes Great Expectations particularly strong as a system for operationalizing and communicating data quality outcomes, while Deequ stands out more clearly as a system for scalable validation execution.

Another way to put the distinction is that Deequ appears closer to a compiled validation engine, whereas Great Expectations appears closer to a validation platform with an embedded execution engine. This should not be overstated, because both systems contain elements of both views. Deequ also provides reusable checks and operational features, and Great Expectations also performs dependency and metric resolution internally. Still, the contrast in emphasis is real, and it explains why the two frameworks feel different even when they often occupy overlapping parts of the tabular validation space.

## What Current Systems Leave Open

Comparing Deequ and Great Expectations also reveals what both systems, by design, leave outside their scope. Three gaps in particular stand out as open problems for anyone thinking about what a next-generation validation framework might address.

### The single-table assumption

Both systems treat validation as an operation on a single table or DataFrame. In practice, data quality problems are rarely contained within one table. A foreign key may reference a row that no longer exists in a dimension table. An order total may not match the sum of its line items stored in a separate fact table. A user record may appear in a source system but be missing from a downstream aggregation. These are among the most common and costly data quality failures, yet neither Deequ nor Great Expectations treats cross-table constraints as first-class citizens. The workaround — joining tables into a single DataFrame before validation — shifts the burden to the user and loses the declarative quality that makes these frameworks useful in the first place.

A framework that takes relational validation seriously would need to represent the multi-table dependency structure explicitly. Constraints would be scoped not to a single dataset but to a data model, and the execution planner would be responsible for resolving joins and coordinating checks across tables. This is a harder problem than single-table validation, but it is also a more honest model of where real data quality requirements live.

### Structural validation without semantic understanding

Both systems validate the form of data: types, ranges, cardinality, completeness, and statistical distributions. What neither system validates is the meaning of data. Consider a constraint like "a shipment's departure date must be before its arrival date," or "the transaction amount must be negative for entries of type `DEBIT`." These are semantic constraints: they express domain knowledge about relationships between columns or between values and their business interpretation. In both Deequ and Great Expectations, the only way to express them is as custom row-level predicates written in the host language. There is no built-in semantic layer and no structured representation of what the constraint means, only the code that checks it.

This gap also limits automated rule suggestion. Deequ can observe that a column has historically been fully populated and suggest a completeness constraint. What it cannot do is reason about why that column must be populated, or detect that a new column is logically related to an existing one in a way that implies additional constraints. The link between business intent and technical validation rule is entirely manual. As datasets and teams grow, this becomes a significant bottleneck: the people who understand the data are not always the people writing the rules, and there is no formal representation that bridges the two.

### Pass/fail output without trend or proximity signal

Both systems ultimately produce a binary validation result per rule: pass or fail. This is the right granularity for pipeline gating, but it is too coarse for operational monitoring. A completeness check that passes at 97% today carries very different implications depending on whether the rate has been stable at 99% for months or has been declining by half a point per week. A uniqueness check that fails on 200 rows in a table of ten million is a different kind of problem than the same failure on a table of fifty thousand. The current result model treats all passes the same and all failures the same.

Deequ partially addresses this by storing metric histories and running anomaly detection over them, but this is an add-on layer rather than an integrated part of the result model. Great Expectations offers configurable result formats with detailed failure evidence, which helps with debugging individual failures, but does not add trend awareness. A more complete result model would integrate proximity-to-threshold, historical trend, and a sense of failure severity into the standard output of every validation run. This would let downstream consumers — alerting systems, data quality dashboards, pipeline orchestrators — make more informed decisions than a simple pass/fail bit allows.
