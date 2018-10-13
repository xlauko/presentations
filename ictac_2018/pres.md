---
vim: spell spelllang=en tw=80 fo+=t
title: "Symbolic Computation via Program Transformation"
author:
    - __Henrich Lauko__, Petr Ročkai and Jiří Barnat
header-includes:
    - \input{defs}
    - \usepackage{units}
    - \usepackage{tikz}
    - \usepackage{xspace}
    - \usetikzlibrary{shapes, arrows, shadows, positioning, calc, fit, backgrounds, decorations.pathmorphing}
    - \usepackage{xcolor}
    - \newcommand\todo[1]{\textcolor{red}{#1}}
<!-- classoption: t -->
lang: english
date: 18th October 2018
...

## Agenda

1. Context of symbolic computation
2. Transformation-based approach
3. Integration to tool with explicit computation

## Symbolic Computation {.t .fragile}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
__Explicit computation__
\begin{itemize}
    \item variables represent concrete values
    \item compiled or interpreted programs
\end{itemize}
\end{column}
\begin{column}{0.5\textwidth}
__Symbolic computation__
\begin{itemize}
    \item variables represent sets of possible values
    \item mostly interpreted
\end{itemize}
\end{column}
\end{columns}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\begin{lstlisting}
  x <- input() // x = 7
  if (x > 0)
    ...
  else
    ...
\end{lstlisting}
\end{column}
\begin{column}{0.5\textwidth}
\begin{lstlisting}
  x <- input() // x = {...}
  if (x > 0)
    ... // x = {v|v > 0}
  else
    ... // x = {v|v <= 0}
\end{lstlisting}
\begin{itemize}
\item verification, test generation,
      concolic testing
\end{itemize}
\end{column}
\end{columns}

## Symbolic Execution {.t .fragile}
- interpretation-based approach

\begin{lstlisting}
  a <- input()   // pc: true
  b <- input()   // pc: true
  if (a > 0)    // pc: $a > 0$
    if (b < 0)  // pc: $a > 0 \wedge b < 0$
      b <- a + 1 // pc: $a > 0 \wedge b < 0$, data: $b = a + 1$
    else
      b <- a - 1 // pc: $a > 0 \wedge b \geq 0$, data: $b = a - 1$
\end{lstlisting}

- interpreter builds __formula__ in some theory of SMT logic:
    1. data representation: _b = a + 1_
    2. path condition:      _a > 0_

- program does not know anything about symbolic values

- TODO show apparoach img. here

## Compilation-based Approach

- let the program build _data representation_ and _path condition_

\begin{columns}
\begin{column}{0.5\textwidth}
    \centering
    __Interpretation-based__
    \includegraphics[width=0.9\textwidth]{img/inter-approach.pdf}
\end{column}

\begin{column}{0.5\textwidth}
    \centering
    __Compilation-based__
    \includegraphics[width=0.9\textwidth]{img/compiler-approach.pdf}
\end{column}
\end{columns}

\bigskip

- minimizes complexity of the verification algorithm

## Goals

1. mixing of explicit and symbolic computation
2. expose a small interface to the rest of the system
3. impose minimal run-time overhead

## Transformation of Bitcode {.t .fragile}

\begin{columns}
\begin{column}{0.4\textwidth}
\begin{lstlisting}
  x:int  <- input()
  y:int  <- factorial(7)
  z:int  <- x + y
  b:bool <- y < z
\end{lstlisting}
\end{column}
\begin{column}{0.6\textwidth}
\begin{lstlisting}
  x: sym_int  <- lift(*)
  y: int      <- factorial(7)
  z: sym_int  <- sym_add(x, lift(y))
  b: sym_bool <- sym_lt(x, z)
\end{lstlisting}
\end{column}
\end{columns}

\bigskip

- transform instructions, types, functions
- preserve concrete computation
- lift concrete values

- provide library with implementation of symbolic operations:
    - `lift`, `lower`, `sym_add`, ...

## Generalization of the Transformation

1. syntactically abstract the input program:
    - values: `int → abstract_int`
    - instructions: `add → abstract_add`

2. concretely realize abstraction:
    - values: `abstract_int → sym_int`
    - instructions: `abstract_add → sym_add`

- realization inserts an arbitrary domain that is provided

## Closer look on the Transformation 1. {.t .fragile}

1. Branching

\begin{columns}[t]
\begin{column}{0.4\textwidth}
\begin{lstlisting}
  cond: bool <- x < 0
  if (cond)
    ...
  else
    ...
\end{lstlisting}
\end{column}

\begin{column}{0.6\textwidth}
\begin{lstlisting}
  cond: sym_bool <- sym_lt(x, 0)
  if (*)
    x': sym_int <- assume(cond)
    ...
  else
    x': sym_int <- assume(!cond)
    ...
\end{lstlisting}
\begin{itemize}
    \item \texttt{assume} constrains values of \texttt{x}
    \item extend \emph{path condition}
\end{itemize}
\end{column}
\end{columns}

## Closer look on the Transformation 2. {.t .fragile}

2. Aggregate types

\begin{lstlisting}
    arr: int[]  <- [1, 2, 3]
    arr[1]: int <- input()
\end{lstlisting}

- we want to minimize the number of symbolic values

__Solution:__ use discriminated union type

- realize abstract value as union of \emph{concrete} and \emph{symbolic} value

\begin{lstlisting}
    arr: union[]  <- [1, 2, 3] // either int or sym_int
    arr[1]: int <- lift(*)
\end{lstlisting}

- similarly deal with recursive structures

## Closer look on the Transformation 3. {.t .fragile}

3. Function Calls

- how to transform functions with symbolic arguments?

\vspace{-1em}
\begin{lstlisting}
    int foo(a: int, b: int, c: int)
\end{lstlisting}

- may produce exponentially many duplicates:

\vspace{-1em}
\begin{lstlisting}
    int foo(a: sym_int, b: int, c: int)
    int foo(a: int, b: sym_int, c: int)
    int foo(a: int, b: int, c: sym_int)
    int foo(a: sym_int, b: sym_int, c: int)
    ...
\end{lstlisting}
- resolve return type

__Solution__: static analysis + use discriminated union

\begin{lstlisting}
    union foo(a: union, b: union, c: int)
\end{lstlisting}

## Data Representation {.t .fragile}


__Symbolic execution:__
\begin{columns}
\begin{column}{0.55\textwidth}
\vspace{-1em}
\begin{lstlisting}
  a: pointer <- malloc()
  w: sym_int <- lift(*)
  x: sym_int <- lift(*)
  y: sym_int <- sym_add(w, x)
  z: sym_int <- sym_mul(y, 7)
  store z -> a
\end{lstlisting}
\end{column}

\begin{column}{0.45\textwidth}
\includegraphics[]{img/execution.pdf}
\end{column}

\end{columns}

\bigskip
\bigskip

__Branching example:__
\begin{columns}
\begin{column}{0.55\textwidth}
\vspace{-1em}
\begin{lstlisting}
  x : sym_int <- lift(*)
  if (*) // nondeterministic
    x': sym_int <- assume(x < 10)
    y : sym_int <- sym_add(x, 1)
  else
    x': sym_int <- assume(x < 10)
    y : sym_int <- sym_sub(x, 1)
\end{lstlisting}
\end{column}
\begin{column}{0.45\textwidth}
\includegraphics[]{img/branching.pdf}
\end{column}
\end{columns}

## Symbolic Verification Algorithm {.t}

\bigskip

\begin{columns}[t]
\begin{column}{0.6\textwidth}
    \centering
    \includegraphics[width=0.9\textwidth]{img/compiler-approach.pdf}
\end{column}

\begin{column}{0.4\textwidth}
__Required support in a tool:__
\begin{itemize}
    \item nondeterminism
    \item feasibility check
    \item equality check
    \item values metadata
\end{itemize}

\bigskip

Simpler domains do not even need _SMT_ support (sign domain).
\end{column}
\end{columns}

## Results {.t}

__Component sizes:__ (lines of code)

\begin{table}
\begin{tabular}{l | r  r  r  r }
 & DIVINE & KLEE & SymDIVINE & CBMC \\
\hline \hline
symbolic support & 5.4 	 & 24.2 & 7   & 39.8 \\
shared code 	 & 136.5 & 125  & 423 & 27.5 \\
\end{tabular}
\end{table}

- reduced complexity of verification tool

\bigskip

__SV-COMP Benchmarks:__

TODO

## Conclusion

__Goals__

1. mixing of explicit and symbolic computation
   \textcolor{paradisegreen}{\LARGE\checkmark}
2. expose a small interface to the rest of the system
   \textcolor{paradisegreen}{\LARGE\checkmark}
3. impose minimal run-time overhead
   \textcolor{paradisegreen}{\LARGE\checkmark}

\bigskip

__Summary__

- introduced compilation-based symbolic verification
- generalized approach to the abstraction of programs

