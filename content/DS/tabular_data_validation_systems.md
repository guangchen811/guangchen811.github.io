---
title: "Tabular Data Validation Systems"
date: 2026-03-18
draft: true
tags:
- Data Quality
- Data Validation
- Data Management
---

Data pipelines fail quietly. A column that was always populated starts arriving with nulls. An identifier that was supposed to be unique now has duplicates. A categorical field that encoded status codes now contains free-form text. These failures rarely crash anything immediately. They propagate downstream and surface later as confusing inconsistencies.

Tabular data validation systems exist to make such failures explicit before they spread. This post compares two widely used frameworks, Deequ and Great Expectations, through a systems lens rather than a feature checklist. The central contrast is simple: Deequ is more execution-centric, while Great Expectations is more workflow- and artifact-centric.

## What Is Tabular Data Validation?

Tabular data validation is the task of checking whether a dataset satisfies expected properties before downstream consumers rely on it. Some of these properties are structural, such as uniqueness, completeness, ranges, or value domains. Others are closer to business intent, such as whether certain rows should satisfy a predicate or whether values remain consistent with past behavior.

From a systems perspective, validation is not just about catching bad records. It is about making checks explicit, reusable, and executable inside a pipeline. Without a validation framework, teams usually fall back to ad hoc SQL, notebooks, dashboards, or manual inspection. Those approaches may work temporarily, but they do not provide a durable interface for expressing and reusing data quality requirements.

The complication is that even simple checks are not free. Uniqueness may require global aggregation, type checks may require full scans, and operational use often requires rich output, historical comparison, or automated follow-up actions. For that reason, validation frameworks are not just collections of predicates. They are systems that have to balance usability, execution cost, and operational fit.

## A Useful Comparison Lens

Most validation systems can be compared through four questions.

- What is the user-facing rule abstraction?
- How is a rule set bound to concrete data?
- How is execution planned internally?
- What result object is returned after validation?

That lens matters more than a raw feature list because many frameworks support similar checks but organize the problem differently. Great Expectations uses `Expectations` collected into `Expectation Suites`. Deequ uses `Checks` composed of `Constraints`. The names differ, but both systems start from declarative rules, bind them to actual data, compile them into executable work, and return structured evidence rather than a single boolean.

At this level, the systems are more similar than their APIs first suggest. The interesting differences appear in what each one makes central.

## Constraint Types and Coverage

At a high level, both systems cover the core tabular checks most practitioners expect: completeness, uniqueness, domains, ranges, type-oriented checks, and row-level predicates. A useful summary of the space is: value presence, value domain, value relationships, row compliance, table-level statistics, and history-aware checks.

The overlap is large, but the emphasis differs. Deequ makes statistical metrics especially explicit, including quantities such as entropy, correlation, and anomaly signals over metric histories. Great Expectations covers many of the same practical cases, but presents them as reusable named expectations rather than as predicates over a metric catalog. That difference in presentation foreshadows the larger systems difference.

## DSL Design for Data Validation

One of the clearest differences appears in the DSL. A validation DSL is not just syntax. It determines how users express requirements and how much structure the engine can recover for planning and optimization. Two styles appear repeatedly: assertion-oriented DSLs and metric-oriented DSLs.

In an assertion-oriented DSL, users state the desired property directly: a column must be unique, a field must be complete, or a value must lie in a range. In a metric-oriented DSL, users write predicates over derived statistics, such as a uniqueness ratio or completeness score. The distinction is less about expressivity than about where the interface is optimized. Assertion-oriented DSLs are better surface languages for humans; metric-oriented forms are often better internal representations for execution engines.

Deequ is a good example of the split. Its API looks assertion-oriented, with methods such as `isComplete`, `isUnique`, and `satisfies`, but the engine is organized around metrics and analyzers. Great Expectations presents a more consistently expectation-oriented interface. Its surface language feels closer to a contract language, even though it still needs metric and dependency resolution internally.

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

Both formulations express the same intent. The difference is one of interface: Deequ treats the condition as a filter on a rule, while Great Expectations treats it as a parameter of an expectation. That is a small syntactic difference, but it reflects the larger distinction between a system centered on filtered metric computation and one centered on reusable validation artifacts.

## Deequ: Validation as Metric Planning and Optimized Execution

Deequ is best understood through execution. Users write declarative checks, but the engine does not simply run them one by one. It maps constraints to required metrics, computes those metrics through analyzers, and plans execution around shared computation rather than around the original assertions.

That design matters because many high-level rules reduce to compatible aggregations. On Spark, Deequ can group them into fewer scans over the data. It also extends naturally to metric histories, anomaly detection, and incremental validation, where previously stored state can be reused instead of recomputing everything from scratch. This is why Deequ feels like a compiled validation engine: its identity comes from normalizing heterogeneous rules into a smaller optimization-friendly metric layer.

## Great Expectations: Validation as Expectation Workflow

Great Expectations approaches the same problem from a different direction. Its user-facing model is centered on reusable artifacts and operational workflow: `Expectations`, `Expectation Suites`, `Validation Definitions`, `Checkpoints`, and actions. A suite does not run by itself; it is bound to data and then executed as part of a larger validation process.

Great Expectations still has a real execution engine under the hood. It resolves dependencies, computes metrics, and only then evaluates expectations. But that machinery is largely hidden behind workflow objects and result artifacts. The platform puts more visible weight on repeatable runs, human-readable results, and follow-up actions such as notifications or documentation updates. This is why Great Expectations feels more like a validation platform with an embedded execution engine.

## Where the Systems Differ

The most important difference is not which checks the systems support, but what they treat as the center of the problem. Deequ makes execution central. Great Expectations makes reusable artifacts and workflow central.

The table below captures the contrast.

| Dimension | Deequ | Great Expectations |
| --- | --- | --- |
| User-facing unit | `Check` / `Constraint` | `Expectation` |
| Internal center of gravity | Metrics and analyzers | Suites, validations, checkpoints, actions |
| Main optimization target | Shared computation and efficient execution | Repeatable workflow and actionable outputs |
| Typical strength | Large-scale validation on Spark | Operationalizing validation in data workflows |
| Overall feel | Compiled validation engine | Validation platform with embedded engine |

## What Current Systems Leave Open

Comparing Deequ and Great Expectations also makes their shared limits easier to see. Three gaps stand out.

### The single-table assumption

Both systems largely assume validation happens over one table or DataFrame at a time. Real data quality failures often do not respect that boundary. Foreign keys, reconciliation checks, and consistency conditions across fact and dimension tables are common, yet neither system treats them as first-class constraints. A stronger framework would need to model multi-table dependencies explicitly instead of forcing users to handcraft joins and hide the relational structure inside one validation job.

### Structural validation without semantic understanding

Both systems are strongest on structural and statistical properties. They are much weaker on semantic constraints such as "departure date must precede arrival date" or "amount must be negative for `DEBIT` rows." Those rules can usually be encoded as custom predicates, but the system does not understand their meaning. That limits not only expressiveness, but also rule suggestion and reuse: business intent remains trapped in handwritten checks rather than represented explicitly.

### Pass/fail output without trend or proximity signal

Both systems ultimately reduce each rule to pass or fail. That is appropriate for pipeline gating, but weak for monitoring. A check that barely passes may deserve attention, and a failure affecting 200 rows in a table of ten million is not the same as a failure affecting 200 rows in a table of fifty thousand. Deequ partially helps through metric histories; Great Expectations helps through richer result payloads. But neither fully integrates trend, proximity to threshold, and failure severity into the default result model.

## Conclusion

The most useful way to compare Deequ and Great Expectations is not by counting checks. Both cover much of the same tabular validation surface. The more revealing question is what each system optimizes for. Deequ is strongest when validation needs to be planned and executed efficiently over large datasets. Great Expectations is strongest when validation needs to live as a reusable operational artifact inside a broader workflow.

That claim should still be stated carefully. Deequ does not only optimize execution, and Great Expectations does not only optimize workflow. Both contain elements of both. But as organizing ideas, execution is the center of gravity for Deequ, while workflow and validation artifacts are the center of gravity for Great Expectations. That distinction makes the systems feel different in practice, and it helps explain what current tabular validation systems still leave open.
