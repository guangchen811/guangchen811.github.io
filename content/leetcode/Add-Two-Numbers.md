---
title: "Add Two Numbers"
date: 2022-04-09T19:26:27+08:00
draft: false
summary: No.2
ismath: true
tags:
- Linked List
- Easy
categories:
- Leetcode Notes
---
## Description

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

## Intuition
Keep track of the carry using a variable and simulate digits-by-digits sum starting from the head of list, which contains the least-significant digit.

## Algorithm
Just like how we would sum two numbers on a piece of paper, we begin by summing the least-significant digits, which is the head of $l1$ and $l2$. Since each digit is in the range of 0...9, summing two digits may "overflow". For example $5+7=12$. In this case, we set the current digit to 2 and bring over the $carry=1$ to the next iteration. $carry$ must be either $0$ or $1$ because the largest possible sum of two digits (including the carry) is $9+9+1=19$.

### Pseudocode
> Initialize current node to dummy head of the returning list.
>
> Initialize $carry$ to 0.
>
> Initialize $p$ and $q$ to head of $l1$ and $l2$ respectively.
> Loop through lists $l1$ and $l2$ until you reach both ends.
>
>> Set $x$ to node $p$'s value. If $p$ has reached the end of $l1$, set to 0.
>>
>> Set $y$ to node $q$'s value. If $q$ has reached the end of $l2$, set to 0.
>> 
>> Set $sum=x+y+carry$.
>>
>> Update $carry = sum/10$
>>
>> Create a new node with teh digit value of ($sum\mod{10}$) and set it to current node's next, then advance current node to next.
>>
>> Advance both $p$ and $q$.
>
> Check if $carry=1$, if so append a new node with digit 1 to the returning list.
> 
> Return dummy head's next node.


### Code
```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        dummyHead = ListNode(val=0)
        p = l1
        q = l2
        curr = dummyHead
        carry = 0
        while(p != None or q != None):
            if p != None:
                x = p.val
            else:
                x = 0
            if q != None:
                y = q.val
            else:
                y = 0
            sum = carry + x + y
            carry = sum // 10
            curr.next = ListNode(val=sum % 10)
            curr = curr.next
            if(p != None):
                p = p.next
            if(q != None):
                q = q.next
        if (carry > 0):
            curr.next = ListNode(carry)
        return dummyHead.next
```

### Complexity Analysis
- Time Complexity: $O(\max{(m,n)})$. Assume that $m$ and $n$ represents the length of $l1$ and $l2$ respectively, the algorithm above iterates at most $\max{(m,n)}$ times.

- Space Complexity: $O(\max{(m,n)})$. The length of the new list is at most $\max{(m,n)}+1$.