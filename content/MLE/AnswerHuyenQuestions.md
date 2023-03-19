---
title: "Answering Machine Learning Interview Questions"
date: 2022-07-22
draft: true
summary: Answers to questions from the "Machine Learning Interviews" book by Chip Huyen
ismath: true
tags:
- MLE
categories:
- MLE
---
## Introduction

I recently came across a great [MLE interview guide book](https://huyenchip.com/ml-interviews-book/) written by [Chip Huyen](https://github.com/chiphuyen). In this book, Chip shares her experience about different types of machine learning jobs, companies, interview pipelines, and more. What interests me most, however, is that the book contains [over 200 questions about machine learning](https://huyenchip.com/ml-interviews-book/contents/part-ii.-questions.html). In this blog post, I will organize the answers to these questions as best as I can.

# 5 Math
## 5.1 Algebra and (a little) calculus
### 5.1.1 Vectors
#### 1. Dot product

1.  **Q: \[E\] What's the geometric interpretation of the dot product of two vectors?**

    **A:** In Euclidean geometry, a vector can be pictured as an arrow. The dot product of two Euclidean vectors $\vec{a}$ and $\vec{b}$ is defined by:
    
    $$\vec{a} \cdot \vec{b} = \|\|\vec{a}\|\|\ \|\|\vec{b}\|\|\cos{\theta}$$
    
    where $\theta$ is the angle between $\vec{a}$ and $\vec{b}$.

2.  **Q: \[E\] Given a vector $\vec{u}$, find vector $\vec{v}$ of unit length such that the dot product of $\vec{u}$ and $\vec{v}$ is maximum.**

    **A:** $$\vec{v} = \frac{\vec{u}}{\|\|\vec{u}\|\|}$$

#### 2. Outer product

1.  **Q: \[E\] Given two vectors $\vec{a}=[3,2,1]$ and $\vec{b}=[-1,0,1]$, calculate the outer product $\vec{a}^{T}\vec{b}$.**

    **A:**
    
    $$\vec{a}^T\vec{b}=
    \begin{bmatrix}
        a_1b_1 & a_1b_2 & a_1b_3 \\
        a_2b_1 & a_2b_2 & a_2b_3 \\
        a_3b_1 & a_3b_2 & a_3b_3
    \end{bmatrix}=
    \begin{bmatrix}
        -3 & 0 & 3 \\
        -2 & 0 & 2 \\
        -1 & 0 & 1
    \end{bmatrix}
    $$
    
2.  **Q: \[M\] Give an example of how the outer product can be useful in machine learning.**

    **A:**
