---
title: "Count Number of Nice Subarrays"
date: 2022-04-16T12:00:38+08:00
draft: true
summary: No.1248
ismath: true
tags:
- sliding window
- hash map
categories:
- Leetcode Notes
---

## Description
Given an array of integers `nums` and an integer `k`. A continuous subarray is called **nice** if there are `k` odd numbers on it.

Return *the number of **nice** sub-arrays.*

## Intuition
We can replace odds with 1 and evens with o, and then generate a list `cur_odd`. `cur_odd[i]` is equal to the number of odds until `i`. Now, we just need to  count the number of pairs in `cur_odd` which difference is equal to `k`.

## Algorithm
In fact, it's not necessary to build `cur_odd` explicitly. A hash map can make things easier.

### Pseudocode
> Initial a map as `{0:1}`.
>
> Initial current odd numbers as 0.
>
> Initial answer as 0.
>
> for each number in numbers
>
>> If the number is a odd
>>
>>> Let cur_odd add one.
>>
>> Else, if current odd numbers - k in the map
>>
>>> Let the answer add `map[current odd numbers - k]`
>> Else, if current odd numbers not in the map.
>>
>>> Set map[current odd numbers] as 0.
>>
>> Let map[current odd numbers] add one.
>
> return the answer.

### Code
```python
class Solution:
    def numberOfSubarrays(self, nums: List[int], k: int) -> int:
        mp = {0:1}
        cur_odd = 0
        ans = 0
        for num in nums:
            if num % 2 == 1:
                cur_odd += 1
            if cur_odd-k in mp:
                ans += mp[cur_odd-k]
            if not cur_odd in mp:
                mp[cur_odd] = 0
            mp[cur_odd] += 1
        return ans
```

### Complexity Analysis
- Time Complexity: $O(n)$
- Space Complexity: $O(n)$