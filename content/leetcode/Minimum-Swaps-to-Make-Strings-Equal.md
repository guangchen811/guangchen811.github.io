---
title: "Minimum Swaps to Make Strings Equal"
date: 2022-04-15T23:10:09+08:00
draft: false
summary: No.1247
tags:
- Medium
categories:
- Leetcode Notes
---
## Description

You are given two strings `s1` and `s2` of equal length consisting of letters `"x"` and `"y"` **only**. Your task is to make these two strings equal to each other. You can swap any two characters that belong to **different** strings, which means: swap `s1[i]` and `s2[j]`.

Return the minimum number of swaps required to make `s1` and `s2` equal, or return `-1` if it is impossible to do so.

## Intuition

Given a index `i`, there are totally 4 possiblilities of `s1[i]` and `s2[i]`: `x-x`,`y-y`,`x-y`and`y-x`. `x-x` and `y-y` have been matched, we just need to process two other situations.

## Algorithm

Assum there are `a` pairs of `x-y` and `b` pairs of `y-x`. For 2 pairs of `x-y` or `y-x`, we can swap 1 steps to make them matching: `"xx"|"yy"`$\rightarrow$`"xy"|"xy"`. For one `x-y` and one `y-x`, we need 2 steps: `"xy"|"yx"`$\rightarrow$`"xx"|"yy"`$\rightarrow$`"xy"|"xy"`.

So, if `a` and `b` are both even. We just need $\frac{a+b}{2}$ steps without other process.

If one of `a` and `b` is even and the other is odd, we can't make it match any way.

If their are both odd, we need $\frac{a+b-2}{2}+2=\frac{a+b}{2}+1$ steps.

### Pseudocode

> Read `s1` and `s2` to get `a` and `b`.
>
> If only one of `a` and `b` is even, return -1.
>
> Else if both `a` and `b` are even, return $\frac{a+b}{2}$.
>
> Else return $\frac{a+b}{2}+1$

### Code

```python
class Solution:
    def minimumSwap(self, s1: str, s2: str) -> int:
        a = 0
        b = 0
        for i in range(len(s1)):
            if s1[i] == 'x' and s2[i] == 'y':
                a += 1
            elif s1[i] == 'y' and s2[i] == 'x':
                b += 1
        if a%2==0 and b%2==0:
            return int((a+b)/2)
        elif a%2==1 and b%2==1:
            return int((a+b)/2+1)
        else:
            return -1
```

### Complexity Analysis

- Time Complexity: $O(n)$.
- Space Complexity: $O(1)$.