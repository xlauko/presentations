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
...

## Symbolic Computation Motivation

- verify programs with inputs from the enviroment
- symbolic execution, concolic testing, test generation etc.

## Symbolic Computation { .t .fragile}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Interpretation-based}
\includegraphics[width=0.9\textwidth]{img/inter-approach.pdf}
\end{column}
\begin{column}{0.5\textwidth}
\end{column}
\end{columns}

## Symbolic Computation { .t .fragile }

\addtocounter{framenumber}{-1}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Interpretation-based}
\includegraphics[width=0.9\textwidth]{img/inter-approach.pdf}
\end{column}
\begin{column}{0.5\textwidth}
\bigskip

\begin{lstlisting}[numbers=left,xleftmargin=1cm]
a <- input()
if (a > 0)
  b <- a + 1
else
  b <- a - 1
\end{lstlisting}

\end{column}
\end{columns}

## Symbolic Computation { .t .fragile }

\addtocounter{framenumber}{-1}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Interpretation-based}
\includegraphics[width=0.9\textwidth]{img/inter-approach.pdf}
\end{column}
\begin{column}{0.5\textwidth}
\bigskip

\begin{lstlisting}[numbers=left,xleftmargin=1cm]
a <- input()  ^\textcolor{red}{$[true]$}^
if (a > 0)
  b <- a + 1
else
  b <- a - 1
\end{lstlisting}

\end{column}
\end{columns}

## Symbolic Computation { .t .fragile}

\addtocounter{framenumber}{-1}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Interpretation-based}
\includegraphics[width=0.9\textwidth]{img/inter-approach.pdf}
\end{column}
\begin{column}{0.5\textwidth}
\bigskip

\begin{lstlisting}[numbers=left,xleftmargin=1cm]
a <- input()  ^\textcolor{red}{$[true]$}^
if (a > 0)   ^\textcolor{red}{$[a > 0]$}^
  b <- a + 1
else
  b <- a - 1
\end{lstlisting}

\end{column}
\end{columns}

## Symbolic Computation { .t .fragile}

\addtocounter{framenumber}{-1}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Interpretation-based}
\includegraphics[width=0.9\textwidth]{img/inter-approach.pdf}
\end{column}
\begin{column}{0.5\textwidth}
\bigskip

\begin{lstlisting}[numbers=left,xleftmargin=1cm]
a <- input()  ^\textcolor{red}{$[true]$}^
if (a > 0)   ^\textcolor{red}{$[a > 0]$}^
  b <- a + 1 ^\textcolor{red}{$[a > 0 \wedge b = a + 1]$}^
else
  b <- a - 1
\end{lstlisting}

\end{column}
\end{columns}

## Symbolic Computation { .t .fragile}

\addtocounter{framenumber}{-1}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Interpretation-based}
\includegraphics[width=0.9\textwidth]{img/inter-approach.pdf}
\end{column}
\begin{column}{0.5\textwidth}
\bigskip

\begin{lstlisting}[numbers=left,xleftmargin=1cm]
a <- input()  ^\textcolor{red}{$[true]$}^
if (a > 0)   ^\textcolor{red}{$[a > 0]$}^
  b <- a + 1 ^\textcolor{red}{$[a > 0 \wedge b = a + 1]$}^
else
  b <- a - 1 ^\textcolor{red}{$[a \leq 0 \wedge b = a - 1]$}^
\end{lstlisting}

\end{column}
\end{columns}

## Symbolic Computation { .t .fragile}

\addtocounter{framenumber}{-1}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Interpretation-based}
\includegraphics[width=0.9\textwidth]{img/inter-approach.pdf}
\end{column}
\begin{column}{0.5\textwidth}
\bigskip

\begin{lstlisting}[numbers=left,xleftmargin=1cm]
a <- input()  ^\textcolor{red}{$[true]$}^
if (a > 0)   ^\textcolor{red}{$[a > 0]$}^
  b <- a + 1 ^\textcolor{red}{$[a > 0 \wedge b = a + 1]$}^
else
  b <- a - 1 ^\textcolor{red}{$[a \leq 0 \wedge b = a - 1]$}^
\end{lstlisting}

\begin{itemize}
    \item multiple possible paths
    \item maintained in interpreter
    \item program does not know about symbolic values
\end{itemize}

\end{column}
\end{columns}

## Proposed Symbolic Computation { .t .fragile}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Interpretation-based}
\includegraphics[width=0.9\textwidth]{img/inter-approach.pdf}
\end{column}
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Compilation-based}
\includegraphics[width=0.9\textwidth]{img/compiler-approach.pdf}
\end{column}
\end{columns}

\only<2->{
\bigskip

\textbf{Motivation:} minimize complexity of the verification tool
}

## Proposed Symbolic Computation { .t .fragile}

\addtocounter{framenumber}{-1}

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\bigskip

\centering
\begin{lstlisting}[numbers=left,xleftmargin=1cm]
a <- input()
if (a > 0)
  b <- a + 1
else
  b <- a - 1
\end{lstlisting}

\begin{lstlisting}[numbers=left,xleftmargin=1cm]
a <- sym_input()
if (sym_gt(a, 0))
  b <- sym_add(a, 1)
else
  b <- sym_sub(a, 1)
\end{lstlisting}

\end{column}
\begin{column}{0.5\textwidth}
\bigskip

\centering
\textbf{Compilation-based}
\includegraphics[width=0.9\textwidth]{img/compiler-approach.pdf}
\end{column}
\end{columns}

\bigskip

\textbf{Motivation:} minimize complexity of the verification tool

## Goals

\begin{enumerate}
    \item<1-> mixing of explicit and symbolic computation
    \item<2-> expose a small interface to the rest of the system
    \item<3-> impose minimal run-time overhead
\end{enumerate}

# Transformation

## Transformation of Program {.t .fragile}

1. __syntactically abstract the input program__

\begin{columns}
\begin{column}{0.42\textwidth}
\begin{lstlisting}
   x:int  <- input()
   y:int  <- factorial(7)
   z:int  <- x + y
   b:bool <- z < 0
\end{lstlisting}
\end{column}
\begin{column}{0.58\textwidth}
\begin{lstlisting}
  x: a_int  <- lift(*)
  y: int    <- factorial(7)
  z: a_int  <- a_add(x, lift(y))
  b: a_bool <- a_lt(z, lift(0))
\end{lstlisting}
\end{column}
\end{columns}

\pause

- transform instructions, types, functions
- preserve concrete computation
- lift concrete values

\pause

2. __concretely realize abstraction__

\begin{columns}
\begin{column}{0.7\textwidth}
\begin{lstlisting}
   x: sym_int  <- lift(*)
   y: int      <- factorial(7)
   z: sym_int  <- sym_add(x, lift(y))
   b: sym_bool <- sym_lt(z, lift(0))
\end{lstlisting}
\end{column}
\begin{column}{0.3\textwidth}
\end{column}
\end{columns}

- replace abstract calls with provided implementation

## Control Flow of Symbolic Program { .t .fragile }

__Problem:__ constrained values by control flow

\begin{columns}[t]
\begin{column}{0.5\textwidth}
\begin{lstlisting}
  x: int <- input()
  cond: bool <- x < 0
  if (cond)
    y: int <- x + 1
  else
    ...
\end{lstlisting}
\end{column}
\begin{column}{0.5\textwidth}
\begin{itemize}
    \item both paths can happen
    \item x is not constrained
\end{itemize}
\end{column}
\end{columns}

\pause

\bigskip

__Solution:__ instrument constraint propagation

\begin{columns}[t]
\begin{column}{0.6\textwidth}
\begin{lstlisting}
  x: sym_int <- lift(*)
  cond: sym_bool <- sym_lt(x, 0)
  if (*) // nondeterministic
    x': sym_int <- assume(cond)
    y : sym_int <- sym_add(x', 1)
  else
    x': sym_int <- assume(!cond)
    ...
\end{lstlisting}
\end{column}
\begin{column}{0.4\textwidth}
\begin{itemize}
    \item assumes extend a path condition
\end{itemize}
\end{column}
\end{columns}

## Types in the Symbolic Program {.t .fragile}

__Problem:__ how to deal with aggregate types?

\begin{lstlisting}
    arr: int[]  <- [1, 2, 3]
    arr[1]: int <- input()
\end{lstlisting}

- we want to minimize the number of symbolic values

\pause

__Solution:__ use discriminated union type

- realize abstract value as union of \emph{concrete} and \emph{symbolic} value

\begin{lstlisting}
    arr: union[]  <- [1, 2, 3] // either int or sym_int
    arr[1]: union <- lift(*)
\end{lstlisting}

- similarly deal with recursive structures

## Function Calls {.t .fragile}

__Problem:__ how to transform functions with symbolic arguments?

\vspace{-1em}
\begin{lstlisting}
    int foo(a: int, b: int, c: int)
\end{lstlisting}

\pause

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

\pause

__Solution__: static analysis + use discriminated union

\begin{lstlisting}
    union foo(a: union, b: union, c: int)
\end{lstlisting}

# Symbolic Runtime

## Data Representation {.t .fragile}


__Symbolic execution:__
\begin{columns}
\begin{column}{0.57\textwidth}
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

\begin{column}{0.43\textwidth}
\includegraphics[]{img/execution.pdf}
\end{column}

\end{columns}

\pause

\bigskip
\bigskip

__Branching example:__
\begin{columns}
\begin{column}{0.57\textwidth}
\vspace{-1em}
\begin{lstlisting}
  x : sym_int <- lift(*)
  if (*) // nondeterministic
    x': sym_int <- assume(x < 10)
    y : sym_int <- sym_add(x', 1)
  else
    x': sym_int <- assume(x >= 10)
    y : sym_int <- sym_sub(x', 1)
\end{lstlisting}
\end{column}
\begin{column}{0.43\textwidth}
\includegraphics[]{img/branching.pdf}
\end{column}
\end{columns}

## Data Representation II. {.fragile}

__Cycle example:__
\begin{columns}
\begin{column}{0.55\textwidth}
\vspace{-1em}
\begin{lstlisting}
  x : sym_int <- lift(*)
  for i: int <- 1 .. 2
    x: sym_int <- sym_add(x, 1)
\end{lstlisting}
\end{column}
\begin{column}{0.45\textwidth}
\includegraphics[]{img/cycle.pdf}
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

Integrated with DIVINE model checker:

- LLVM-to-LLVM transformation
- STP SMT solver

\pause

__Component sizes:__ (lines of code)

\begin{table}
\begin{tabular}{l | r  r  r  r }
 & DIVINE* & KLEE & SymDIVINE & CBMC \\
\hline \hline
symbolic support & 5.4 	 & 24.2 & 7   & 39.8 \\
shared code 	 & 136.5 & 125  & 423 & 27.5 \\
\end{tabular}
\end{table}

- reduced complexity of verification tool

## Results

__SV-COMP Benchmarks:__

| tag           | total | DIVINE* | SymDIVINE | CBMC |
|---------------|------:|--------:|----------:|-----:|
| array         |   190 | **96**  |        68 |   93 |
| bitvector     |    32 | **17**  |         9 |    2 |
| loops         |   178 | **72**  |        67 |    9 |
| product-lines |   575 | 336     |   **411** |  234 |
| pthread       |    45 | **9**   |         0 |    1 |
| recursion     |    81 | **47**  |        43 |   22 |
| systemc       |    59 | 14      |    **27** |    0 |
| **total**     |  1160 | 591     |   **625** |  361 |

## Conclusion

__Goals__

1. mixing of explicit and symbolic computation
   \textcolor{paradisegreen}{\LARGE\checkmark}
2. expose a small interface to the rest of the system
   \textcolor{paradisegreen}{\LARGE\checkmark}
3. impose minimal run-time overhead
   \textcolor{paradisegreen}{\LARGE\checkmark}

\pause

\bigskip

__Summary__

- introduced compilation-based symbolic verification
- generalized approach to the abstraction of programs

