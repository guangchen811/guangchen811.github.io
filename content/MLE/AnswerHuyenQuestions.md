---
title: "AnswerHuyenQuestions"
date: 2022-07-22T13:25:18+08:00
draft: true
summary: Answers of questionis in Machine Learning Interviews Book written by Chip Huyen
ismath: true
tags:
- MLE
categories:
- MLE
---

Recently, I found a brilliant [MLE interview guiding book](https://huyenchip.com/ml-interviews-book/) written by [Chip Huyen](https://github.com/chiphuyen). In this book, Chip share her experience about types of Machine Learning Jobs, types of companies, Interview pipeline and some other things. Besides, what interests me most is that this book contains [over 200 questions about ML](https://huyenchip.com/ml-interviews-book/contents/part-ii.-questions.html). In this blog, I hope to organize the results of these questions as much as possible.

# 5 Math
## 5.1 Algebra and (little) calculus
### 5.1.1 Vectors
#### 1. Dot product
1.  Q: \[E\]what's the geometric interpretation of the dot product of two vectors?

    A: In Euclidean geometry, A vector can be pictured as an arrow. The dot product of two Euclidean vectors $\vec{a}$ and $\vec{b}$ is defined by 
    $$
    \vec{a}\cdot\vec{b} = \|\|\vec{a}\|\|\ \|\|\vec{b}\|\|\cos{\theta}
    $$
    where $\theta$ is the angle between $\vec{a}$ and $\vec{b}$.
2.  Q: \[E\] Given a vector $\vec{u}$, find vector $\vec{v}$ of unit length such that the dot product of $\vec{u}$ and $\vec{v}$ is maximum.
    
    A: $$\vec{v} = \frac{\vec{u}}{\|\|\vec{u}\|\|}$$
#### 2. outer product
1.  Q: \[E\] Given two vectors $\vec{a}=[3,2,1]$ and $\vec{b}=[-1,0,1]$. Calculate the outer product $\vec{a}^{T}\vec{b}$?
    A:
    $$\vec{a}^T\vec{b}=
    \begin{bmatrix}
        a_1b_1 & a_1b_2 & a_1b_3 \\\\
        a_2b_1 & a_2b_2 & a_2b_3 \\\\
        a_3b_1 & a_3b_2 & a_3b_3
    \end{bmatrix}=
    \begin{bmatrix}
        -3 & 0 & 3 \\\\
        -2 & 0 & 2 \\\\
        -1 & 0 & 1
    \end{bmatrix}
    $$
2.  Q: \[M\] Give an example of how the outer product can be useful in ML.
    
    A: 