---
title: "Minimum Size Subarray Sum"
date: 2022-04-17T19:39:20+08:00
draft: false
summary: No.209
tags:
- 2 pointers
categories:
- Leetcode Notes
---

## Description
Given an array of positive integers `nums` and a positive integer `target` return the minimal legth of a **contiguous subarray**  of which the sum is greater than or equal to `target`. If there is no such subarray, return `0` instead.

## Intuition
We could keep 2 pointer, one for the start and the other for the end of current subarray, and make optimal moves so as to keep the sum greater than `s` as well as maintain the lowest size possible.

## Algorithm

### Code
```cpp
class Solution {
public:
    int minSubArrayLen(int target, vector<int>& nums) {
        int n = nums.size();
        int ans = INT_MAX;
        int left = 0;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            sum += nums[i];
            while (sum >= target) {
                ans = min(ans, i + 1 -left);
                sum -= nums[left++];
            }
        }
        return (ans != INT_MAX) ? ans : 0;
    }
};
```

### Complexity Analysis
- Time Complexity: $O(n)$
- Space Complexity: $O(1)$