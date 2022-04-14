---
title: "Search in a Binary Seaerch Tree"
date: 2022-04-09T19:26:27+08:00
draft: true
summary: No.700
ismath: true
tags:
- Tree
- BST
categories:
- Leetcode Notes
---

## Problem

You are given the `root` of a binary search tree (BST) and an integer `val`.

Find the node in the BST that the node's value equals `val` and return the subtree rooted with that node. If such a node does not exist, return `null`.

## Intuition
There are only two possibilities when we searching a node:
1. node is equal to the value
2. node is not equal to the value

## Algorithm

When the node is equal to the value, we just need to return it. Otherwise, we just need to visit its left or right child recursively.

### Pseudocode
> visit root node.
>
>> If root is null or root's value is equal to target value, return the root.
>>
>> Otherwises, if root's value is bigger than target value.
>>
>>> visit root's left child.
>>
>> Otherwises
>>
>>> visit root's right child.

### Code

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def searchBST(self, root: Optional[TreeNode], val: int) -> Optional[TreeNode]:
        if (root == None or root.val == val):
            return root
        elif root.val < val:
            return self.searchBST(root.right, val)
        else:
            return self.searchBST(root.left, val)
```

### Complexity Analysis
- Time complexity: $O(\log{n})$
- Space complexity: $O(1)$