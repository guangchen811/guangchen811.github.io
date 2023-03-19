---
title: "Namespace and Scope in Python"
date: 2022-09-04
draft: true
tags:
- Python
- Namespace
- Scope
categories:
- Python
---
## Introduction

In Python, a namespace is a mapping from names to objects. Examples of namespaces include the set of built-in names (such as `abs()` and built-in exception names), the global names in a module, and the local names in a function invocation. In a sense, the set of attributes of an object also forms a namespace.

The important thing to know about namespaces is that there is no relation between names in different namespaces. For instance, two different modules may both define a function called `maximize` without confusion - users of the modules must prefix it with the module name.

Namespaces are created at different moments and have different lifetimes. The namespace containing the built-in names is created when the Python interpreter starts up and is never deleted. The global namespace for a module is created when the module definition is read in; normally, module namespaces also last until the interpreter quits.

A scope, on the other hand, is a textual region of a Python program where a namespace is directly accessible. "Directly accessible" here means that an unqualified reference to a name attempts to find the name in the namespace.

Although scopes are determined statically, they are used dynamically. At any time during execution, there are three or four nested scopes whose namespaces are directly accessible:

- The innermost scope, which is searched first, contains the local names.
- The scopes of any enclosing functions, which are searched starting with the nearest enclosing scope, contains non-local, but also non-global names.
- The next-to-last scope contains the current module's global names.
- The outermost scope (searched last) is the namespace containing built-in names.

## Conclusion

In conclusion, understanding namespaces and scopes in Python is important for writing maintainable and readable code. It helps you avoid naming conflicts and ensures that your code behaves as expected. If you want to learn more about Python namespaces and scopes, check out this [great blog post](https://medium.com/swlh/mastering-python-namespaces-and-scopes-7eba67aa3094).