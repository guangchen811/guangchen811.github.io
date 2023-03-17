---
title: "Namespace and scope"
date: 2022-09-04T16:04:22+08:00
draft: true
tags:
    - python
    - namespace
    - scope
categories:
    - python
---

[This](https://docs.python.org/3/tutorial/classes.html#python-scopes-and-namespaces) is python offical document that explain the difference between Scope and Namespace.

My summary after reading the document is as follows.

### What is namespace and scope？

A namespace is a mapping from names to objects. Examples of namespaces are: the set of built-in names(containing functions usch as `abs()`, and built-in exception names); the global names in a module; and the localnames in a function invocation. In a sense the set of attributes of an object aloso form a namespace.

The important thhing to know about namespaces is that there is absolutely norelation between names in dfferent namespaces; for instance, two different modules may both define a function `maximize` without confusion - users of the modules must prefix it with the module name.

Namespaces are created at different moments and have different lifetimes. The namespace containing the built-in names is created when the Python interpreter starts up, and is never deleted. The global namespace for a module is created when the module definition is read in; normally, module namespaces also last until the interpreter quits. 

A scope is a textual region of a Python program where a namespace is directly accessible. "Directly accessible" here means that an unqualified reference to a name attempts to find the name in the namespace.

Although scopes are determined statically, they are used dynamically. At any time during eecution, there are 3 or 4 nested scopes whose namespaces are directly accessible:

- the innermost scope, which is searched first, contains the local names
- the scopes of any enclosing functions, which are searched starting with the nearest enclosing scope, contains non-local, but also non-global names
- the next-to-last scope contains the current module's global names
- the outermost scope (searched last) is the namespace containing built-in names

This blog is great: [Mastering python namespaces and scopes](https://medium.com/swlh/mastering-python-namespaces-and-scopes-7eba67aa3094)