---
title: "Add two Numbers"
date: 2022-04-09T19:26:27+08:00
draft: false
summary: Leetcode No.2
ismath: true
tags:
- LinkList
categories:
- Leetcode Notes
---
```python
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