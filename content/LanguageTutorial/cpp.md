---
title: "C++ Tutorial"
type: post
date: 2022-04-18T22:26:46+08:00
draft: true
summary: 
tags:
- cpp
categories:
- Tutorial
---

Source: [tutorials point](https://www.tutorialspoint.com/cplusplus/index.htm)

Useful Links: [www.cplusplus.com](https://www.cplusplus.com/)

**C++** is a middle-level programming language developed by Bjarne Stroustrup starting in 1979 at Bell Labs. **C++** runs on a variety of platforms, such as Windows, Mac OS, and the various versions of UNIX. This **C++** tutorial adopts a simple and practical approach to describe the concepts of **C++** for beginners to advanded software engineers.

# Why to Learn C++
**C++** is a MUST for students and working professionals to become a great Software Engineer. I will list down some of the key advantages of learning C++:
- C++ is very close to hardware, so you get a chance to work at a low level which gives you lot of control interms of memory management, better performance and finally a robust software development.
- C++ programming gives you a clear understanding about Object Oriented Programming. You will understand low level implementation of polymorphism when you will implement virtual tables and virtual table pointers, or dynamic type identification.
- C++ is one of the every green programming languages and loved by millions of software developers. If you are a great C++ programmer then you will never sit without work and more importantly you will get highly paid for your work.
- C++ is the most widely used programming languages in application and system programming. So you can choose your area of interest of software development.
- C++ really teaches you the difference between compiler, linker and loader, different data types, storage classes, variable types their scopes etc.

# Hello world using C++
Just to give you a little excitement about C++ programming, I'm going to give you a small conventional C++ Hello World program.

C++ is a super set of C programming with additional implementation of object-oriented concepts.

```cpp
#include <iostream>
using namespace std;

// main() is where program execution begis.
int main() {
    cout << "Hello World"; // prints Hello World
    return 0;
}
```

# Overview
C++ is a statically typed, compiled, general-purpose, case-sensitive, free-form programming language that supports procedural, object-oriented, and generic programming.

C++ is regraded as a **middle-level** language, as it comprises a combination of both high-level and low-level language features.

C++ was developed by Bjarne Stroustrup starting in 1979 at Bell Labs in Murray Hill, New Jersey, as an enhancement to the C language and originally named C with Classes but later it was renamed C++ in 1983.

C++ is a superset of C, and that virtually any legal C program is a legal C++ program.

**Note**: A programming language is said to use static typing when type checking is performed during compile-time as opposed to run-time.

## Object-Oriented Programming

C++ fully supports object-oriented programming, including the four pillars of object-oriented development:
- Encapsulation
- Data hiding
- Inheritance
- Polymorphism

## standard Libraries

standard C++ consists of three important parts:
- The core language giving all the building blocks including variables, data types and literals, etc.
- The C++ **Standard Library** giving a rich set of functions manipulating files, stings, etc.
- The Standard Template Library (**STL**) giving a rich set of methods manipulating data structures, etc.

## The ANSI Standard

The ANSI standard is an attempt to ensure that C++ is portable; that code you write for Microsoft's compiler will compile without errors, using a compiler on a Mac, UNIX, a Windows box, or an Alpha.

The ANSI standard has been stable for a while, and all the major C++ compiler manufacturers support the ANSI standard.

## Learning C++

The most important thing while learning C++ is to focus on concepts.

The purpose of learning a programming language is to become a better programmer; that is, to become more effective at designing and implementing new systems and at maintaining old ones.

C++ supports a variety of programming styles. You can write in the style of Fortran, C, Smalltalk, etc., in any language. Each style can achieve its aims effectively while maintaining runtime and space efficiency.

# Environment Setup

## Installing GNU C/C++ Compiler

# UNIX/Linux Installation

If you are using **Linux or UNIX** then check whether GCC is installed on your system by entering the following command from the command line
```bash
$ g++ -v
```
If you have installed GCC, then it should print a message such as the following
```bash
Apple clang version 13.1.6 (clang-1316.0.21.2)
Target: arm64-apple-darwin21.4.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin
```


if GCC is not installed, then you will have to install it yourself using the detailed instructions available at [https://gcc.gnu.org/install/](https://gcc.gnu.org/install/).

## Windows Installation

To install GCC at Windows you need to install MinGW. To install MinGW, goto the MinGW homepage, [http://www.mingw.org/](http://www.mingw.org/), and follow the link to the MinGW download page. Download the latest version of the MinGW installation program which should be named `MinGW-<version>.exe`.

While installing MinGW, at a minimum, you must install gcc-core, gcc-g++, binutils, and the MinGW runtime, but you may wish to install more.

Add the bin subdirectory of your MinGW installation to your **PATH** environment variable so that you can specify these tools on the command line by their simple names.

When the installation is complete, you will be able to run gcc, g++, ar, ranlib, dlltool, and several other GNU tools from the Windows command line.

# Basic Syntax

When we consider a C++ program, it can be defined as a collection of object that communicate via invoking each other's methods. Let us now briefly look into what a class, object, methods, and instant variables mean.

- **Class**: A class can be defined as a template/blueprint that describes the behaviors/states that object of its type support.

- **Object**: Objects have states and behaviors. Example: A dog has states - color, name, breed as well as behaviors - wagging, barking, eating. An object is an instance of a class.

- **Methods** - A method is basically a behavior. A calss can contain many methods. It is in methods where the logics are written, data is manipulated and all the actions are executed.

- **Instance Variables**: Each object has its unique set of instance variables. An object's state is created by the values assigned to these instance variable.

## C++ Program Structure

Let us look at a simple code that would print the words *Hello World*.

```cpp
#include <iostream>
using namespace std;

// main() is where program execution begins.
int main() {
    cout << "Hello World"; // prints Hello World
    return 0;
}
```

Let us look at the various parts of the above program
- The C++ language defines several headers, which contain information that is either necessary or useful to your program. For this program, the header **<iostream>** is needed.

- The line **using namespace std;** tells the compiler to use the std namespace. Namespaces are a relatively recent addition to C++.

- The next line `'// main() is where program execution begins.` is a single-line comment available in C++. Single-line comments begin with `//` and stop at the end of the line.

- The line **int main()** is the main function where program execution begins.

- The next line **cout << "Hello World";** causes the message "Hello World" to be displayed on the screen.

- The next line **return 0;** terminates main() function and causes it to return the value 0 to the calling process.

## Compile and Execute C++ Program

We can save, compile and run the program by the steps given below.

- Open a text editor and add the code as above.

- Save the file as: hello.cpp

- Open a command prompt and got o the directory where you saved the file.

- Type 'g++ hello.cpp' and press enter to compile your code. If there are no errors in your code, the command prompt will take you to the next line and would generate a.out executable file.

- Now, type './a.out' to run your program.

- You will be able to see 'Hello World' printed on the window.

```sh
$ g++ hello.cpp
$ ./a.out
Hello World
```

## Semicolons and Blocks in C++

In C++, the semicolon is a statement terminator. That is, each individual statement must be ended with a semicolon. It indicates the end of one logical entity.

For example, following are three different staements

```cpp
x = y;
y = y + 1;
add(x, y);
```

A block is a set of logically connected statements that are surrounded by opening and closing braces. For example

```cpp
{
    cout << "Hello World"; // prints Hello World
    return 0;
}
```

C++ does not recognize the end of the lines as a terminator. For this reason, it does not matter where you put a statement in a line. For example

```cpp
x = y;
y = y + 1;
add(x, y);
```

is the same as 

```cpp
x = y; y = y + 1; add(x, y);
```

## C++ Identifiers

A C++ identifier is a name used to identify a variable, function, class, module, or any other user-defined item. An identifier starts with a letter A to Z or a to z or an undersocre (_) followed by zero or more letters, underscores, and digits(0 to 9).

C++ does not allow punctuation characters such as @, $, and % within identifiers. C++ is a case-sensitive programming language. Thus, **Manpower** and **manpower** are two different Identifiers in C++.

Here are some examples of acceptable identifiers

```sh
mohd        zara        abc     move_name       a_123
myname50    _temp       j       a23b9           retVal
```

## C++ Keywords

The following list shows the reserved words in C++. THese reserved words may not be used as constant or variable or any other identifier names.


| | |
| - | - | - | - |
| asm | eles | new | this |
| auto | enum | operator | throw |
| bool | explicit | private | true |
| break | export | protected | try |
| case | extern | public | typedef |
| catch | false | register | typeid |
| char | float | reinterpret_cast | typename|
| class | for | return | union |
| const | friend | short | unsigned |
| const_cast | goto | signed | using |
| continue | if | sizeof | virtual |
| default | inlline | static | void |
| delete | int | static_cast | volatile |
| do | long | struct | wchar_t |
| double | mutable | switch | while |
| dynamic_cast | namespace | template | |

# C++ Data Types

While writing program in any language, you need to use various variables to store various information. Variables are nothing but reserved memory locations to store values. This means that when you create a variable you reserver some space in memory.

You may like to store information of various data types like character, wide character, ineger, floating point, double floating point, boolean etc. Based on the data type of a variable, the operating system allocates memory and decides what can be stored in the reserved memory.

## Primitive Built-in Types

C++ offers the programmer a rich assortment of built-in as well as user defined data types. Following table lists down seven basic C++ data types

| Type | Keyword |
| -- | -- |
| Boolean | bool |
| Character | char |
| Integer | int |
| Floating point | float |
|Double floating point | double |
| Valueless | void |
| Wide character | wchar_t |

Serveral of the basic types can be modified using one of more of these type modifiers

- signed
- unsigned
- short
- long

The following table shows the variable type, how much memory it takes to store the value in memory, and what is maximum and minimum value which can be stored in such type of variables.

| Type | Typical Bit Width | Typical Range |
| - | - | - |
| char | 1 byte | -127 to 127 or 0 to 255 |
| unsigned char | 1 byte | 0 to 255 |
| signed char | 1 byte | -127 to 127 |
| int | 4 bytes | -2147483648 to 2147483647 |
| unsigned int | 4 bytes | 0 to 4294967295 |
| signed int | 4 bytes | -2147483648 to 2147483647 |
| short int | 2 bytes | -32768 to 32767 |
