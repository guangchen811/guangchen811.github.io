---
title: "KL Divergence"
date: 2023-04-02
draft: true
summary: Explain KL Divergence and show some example of its application in ML.
ismath: true
tags:
- MLE
- Math
categories:
- Math
---

Kullback-Leibler (KL) Divergence is a fundamental concept that arises in various fields, including information theory, machine learning, and statistics. It is a measure of how different two probability distributions are from one another, and it plays a crucial role in many algorithms and applications. In this blog, we will delve into the basics of KL Divergence, it properties, and its real-world applications, espically in machine learning field.

## Understanding KL Divergence

KL DIvergence, named after its inventors, Solomon Kullback and Richard Leibler, measures the difference between two probability distributions, $P$ and $Q$, over the same set of events. The KL Divergence of $Q$ from $P$, denoted as $D_{KL}(P||Q)$, is defined as the sum of the product of the probability of each event in $P$ and the logarithem of the ratio of the probabilities of the same event in $P$ and $Q$.

Mathematically, it is espressed as:

$$D_{KL}(P||Q)=\sum_{x}{P(x)\cdot\log{\frac{P(x)}{Q(x)}}}$$

where $x$ represents an event in the set of events.

When considering information loss, it is helpful to break down the equation for KL Divergence into two components:

1. The expected number of bits to encode events from $P$ using the "ideal" encoding (i.e., using $P$ itself): $-\sum{P(x)\cdot\log{P(x)}}$.
2. The expected number of bits to encode events from P using the "wrong" encoding (i.e., using Q): $-\sum{P(x)\cdot\log{Q(x)}}$

With these two components in mind, we can express KL Divergence as the difference between the expected number of bits required to encode events from $P$ using the "wrong" encoding ($Q$) and the "ideal" encoding ($P$):

$$D_{KL}(P||Q)=-\sum_{x}{P(x)\cdot\log{{Q(x)}}}-(-\sum_{x}{P(x)\cdot\log{{P(x)}}})$$

This difference highlights the notion of information loss when using $Q$ to approximate $P$. When the KL Divergence is small, it means that $Q$ is a good approximation of $P$, and there is little information loss. Conversely, when the KL Divergence is large, it implies that $Q$ is a poor approximation of $P$, and there is significant information loss.