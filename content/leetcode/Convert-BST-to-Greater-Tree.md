---
title: "Convert BST to Greater Tree"
date: 2022-04-16T14:43:45+08:00
draft: false
summary: No.538
ismath: true
tags:
- BST
- recursion
- Medium
- dfs
categories:
- Leetcode Notes
---

## Description
Given the `root` of a Binary Search Tree (BST), convert it to a Greater Tree such that every key of the original BST is changed to the original key plus the sum of all keys greater than the original key in BST.

## Intuition
Visit nodes according to the value from largest to smallest. Maintain a global variable `SUM`.

## Algorithm

### Pseudocode
> Initial a global variable `SUM`.
>
> Visit root node using the follow function:

> If root is Null, return.
>
> visit root.right.
>
> SUM += root.val.
>
> root.val = SUM.
>
> visit root.left.


### Code
```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def convertBST(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        self.SUM = 0
        self.visit(root)
        return root
    def visit(self, root):
        if root == None:
            return
        self.visit(root.right)
        self.SUM += root.val
        root.val = self.SUM
        self.visit(root.left)
```

### Complexity Analysis
- Time Complexity: $O(n)$
- Space Complexity: $O(1)$