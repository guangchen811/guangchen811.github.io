---
title: "Increasing Order Search Tree"
date: 2022-04-17T15:15:57+08:00
draft: true
summary: No.897
tags:
- BST
- Tree
categories:
- Leetcode Notes
---

## Description
Given the `root` of a binary search tree, rearrange the tree in **in-order** so that the left most node in the tree is now the root of the tree, and every node has no left child and only one right child.

## Intuition
If root.left is not None, make root.left as root and root.left.right as root.left recursively.

## Algorithm

### Code
```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        if root == None:
            return None
        if root.left == None:
            root.right = self.increasingBST(root.right)
            return root
        node = root.left
        root.left = node.right
        node.right = root
        
        return self.increasingBST(node)
```

### Complexity Analysis
- Time Complexity: $O(n)$
- Space Complexity: $O(1)$