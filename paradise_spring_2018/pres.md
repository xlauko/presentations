---
vim: spell spelllang=en tw=80 fo+=t
title: "Symbolic Verification via Program Transformation"
author:
    - Henrich Lauko
header-includes:
    - \input{defs}
    - \usepackage{units}
    - \usepackage{tikz}
    - \usepackage{xspace}
    - \usetikzlibrary{shapes, arrows, shadows, positioning, calc, fit, backgrounds, decorations.pathmorphing}
    - \usepackage{xcolor}
    - \newcommand\todo[1]{\textcolor{red}{#1}}
classoption: t
lang: english
date: 14th May 2018
...

## Outline of the Talk

\topskip0pt
\vspace*{\fill}

1. Introspection to my diploma thesis

2. Designing a better approach

\vspace*{\fill}

## Problem Introduction

__Problem:__ how to deal with inputs of a program in the verification?

. . .

\bigskip
__Solution:__ symbolic representation of data and computation

. . .

\begin{columns}[t]

\begin{column}{0.5\textwidth}
__Interpretation approach:__
\includegraphics[width=\textwidth]{interpreter.pdf}
\end{column}

. . .

\begin{column}{0.5\textwidth}
__Compilation approach:__
\includegraphics[width=\textwidth]{compiler.pdf}
\end{column}

\end{columns}

. . .

- compilation approach does not complicate an interpreter

## Transformation of a Program

Let __\texttt{x}__ be marked as symbolic:
\begin{columns}
\begin{column}{0.4\textwidth}
\small
```{.cpp}
bool foo(int x) {
  int n  = factorial(7);
  bool y = x + n;
  return y;
}
```
\end{column}
\begin{column}{0.5\textwidth}
\small
```{.cpp}
SymInt foo(SymInt x) {
  int n = factorial(7);
  SymInt y = sym_add(x, lift(n));
  return y;
}
```
\end{column}
\end{columns}

- transform instructions, types, functions
- preserve concrete computation
- lift concrete values

. . .

\bigskip
__State After My Diploma Thesis:__

- functional prototype
- each value needs to know whether it is concrete or symbolic


# Analyzing Drawbacks and Designing a Better Approach

## Aggregate Types and Arrays

__Problem:__ types needs to be either concrete or symbolic


```{.cpp}
    int arr[ 3 ] = { 1, 2, 3 };
    arr[ 1 ] = input();
```

- similar problem with aggregates, recursive structures
- aggregates requires shape analysis

. . .

\bigskip
__Solution:__  use discriminated union type

```{.cpp}
    UnionInt arr[ 3 ] = { 1, 2, 3 }; //either int or SymInt
    arr[ 1 ] = input();
```

. . .

- use taints to determine in what state is the union (thanks to Adam)

. . .

__Improve:__

- use bits of concrete value, do not change anything!

## Size of Symbolic Values

__Problem:__ symbolic value may not fit into the memory of concrete value

. . .

\bigskip
__Solution:__ use metadata to store the symbolic value (thanks to Adam)

- if the value is tainted pick symbolic value from the metadata

\begin{center}
\includegraphics[height=0.6\textheight]{metadata.jpg}
\end{center}

## Computation with Unions

__Problem:__ instruction needs to decide whether to do concrete or symbolic
operation

. . .

\bigskip
__Solution:__ based on taints decide what operation to do

\bigskip
__Before transformation:__
```{.cpp}
    int y = x + 10;
```
. . .

__After transformation:__
```{.cpp}
    int y = lifter_add(x, 10);
```

- \texttt{y} gets taint if \texttt{x} is tainted

## Values Lifter

- lifter decides to do either concrete or symbolic operation

```{.cpp}
    int lifter_add(int a, int b) {
        if (!is_tainted(a) && !is_tainted(b))
            return a + b;
        else if (!is_tainted(a))
            a = lift(a);
        else if (!is_tainted(b))
            b = lift(b);
        return sym_add(a, b); // tainted value
    }
```



## Calling of Functions

__Problem:__ we need to create a clone of function for each possible combination
of concrete and symbolic arguments

```{.cpp}
    int foo(int a, int b, int c);
```

. . .

- may produce exponentially many symbolic duplicates:

```{.cpp}
    int foo(SymInt a, int b, int c);
    int foo(int a, SymInt b, int c);
    int foo(int a, int b, SymInt c);
    int foo(SymInt a, SymInt b, int c);
    ...
```
- resolve return type

. . .

\bigskip
__Solution:__ solved by union types

## Future Work

. . .

__Problem:__ pointers to symbolic values

__Solution:__ requires alias analysis, insertion of lifters accordingly

. . .

\bigskip
__Problem:__ symbolic pointers

__Solution:__ ???

. . .

\bigskip
__Problem:__ memory of symbolic size

__Solution:__ ???

. . .

\bigskip
\bigskip
\bigskip

\centering

__Thanks for attention__
