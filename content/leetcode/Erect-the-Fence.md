---
title: "Erect the Fence"
date: 2022-04-23T23:53:26+08:00
draft: true
summary: No.587
tags:
- Convex Hull
- 
categories:
- Leetcode Notes
---

## Description
You are given an array trees where trees `[i] = [xi, yi]` represents the location of a tree in the garden.

You are asked to fence the entire garden using the minimum length of rope as it is expensive. The garden is well fenced only if all the trees are enclosed.

Return the coordinates of trees that are exactly located on the fence perimeter.

For example:
![](https://assets.leetcode.com/uploads/2021/04/24/erect2-plane.jpg)
```markdown
Input: points = [[1,1],[2,2],[2,0],[2,4],[3,3],[4,2]]
Output: [[1,1],[2,0],[3,3],[2,4],[4,2]]
```


## Intuition
This problem is a typical [Convex Hull](https://en.wikipedia.org/wiki/Convex_hull) Algorithm. There are many common Algorithm to solve this kind of problem. Let's describe Jarvis Algorithm, Graham Algorithm, Andrew Algorithm at here.

## Algorithm

### Jarvis Algorithm
The idea of Jarvis Algorithm is simple. We begin as the node which must on the contex hull, for example, the leftmost point $A_1$. Then we choose $A_2$ to ensure all nodes are on the left(right) side of the link $\vec{AB}$. Repat the process to find $A_3, A_4, A_5,\cdots$.


#### Code
```cpp
class Solution {
public:
    int cross(vector<int> & p, vector<int> & q, vector<int> & r) {
        return (q[0] - p[0]) * (r[1] - q[1]) - (q[1] - p[1]) * (r[0] - q[0]);
    }

    vector<vector<int>> outerTrees(vector<vector<int>>& trees) {
        int n = trees.size();
        if (n < 4) {
            return trees;
        }
        int leftMost = 0;
        for (int i = 0; i < n; i++) {
            if (trees[i][0] < trees[leftMost][0]) {
                leftMost = i;
            }
        }

        vector<vector<int>> res;
        vector<bool> visit(n, false);
        int p = leftMost;
        do {
            int q = (p + 1) % n;
            for (int r = 0; r < n; r++) {
                /* If r is on the right of pq，q = r */ 
                if (cross(trees[p], trees[q], trees[r]) < 0) {
                    q = r;
                }
            }
            /* Is there a node i, to make p 、q 、i on a line. */
            for (int i = 0; i < n; i++) {
                if (visit[i] || i == p || i == q) {
                    continue;
                }
                if (cross(trees[p], trees[q], trees[i]) == 0) {
                    res.emplace_back(trees[i]);
                    visit[i] = true;
                }
            }
            if  (!visit[q]) {
                res.emplace_back(trees[q]);
                visit[q] = true;
            }
            p = q;
        } while (p != leftMost);
        return res;
    }
};
```

#### Complexity Analysis
- Time Complexity: $O(n^2)$
- Space Complexity: $O(n)$