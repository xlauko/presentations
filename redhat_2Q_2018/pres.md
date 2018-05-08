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
lang: english
date: 10th May 2018
...

## Topic Recapitulation

- verification of programs with inputs

. . .

- transform the program to manipulate symbolic representation instead of
  concrete inputs


\bigskip

\resizebox{\textwidth}{!}{
\begin{tikzpicture}[>=stealth',shorten >=1pt,auto,node distance=4em,initial text=, <->]

\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{outer}=[draw, dotted, thick]
\tikzstyle{C}=[dashed]
\tikzstyle{textArrow}=[decorate, decoration={snake, post length=0.1 cm}]
\tikzset{>=latex}

\tikzstyle{symdivine}=[fill=paradisegreen!10]
\tikzstyle{prepocessing}=[fill=red!10]

    \node [component](clang) {clang + \divine{} libs};
    \node [component, right = 0.5 cm of clang](lart) {\lart};

    \node [component, right = 0.5 cm of lart, ](divine) {Magic};

    \begin{pgfonlayer}{background}[fill=blue!10]
        \node[prepocessing, outer, fit = (clang) (lart), label=Preprocessing] (preprocessing) {};
    \end{pgfonlayer}

    \begin{pgfonlayer}{background}
        \node[symdivine, outer, fit = (divine), label=\divine] (preprocessing) {};
    \end{pgfonlayer}

    \node [left = 1.5 cm of clang] (start) {input.c};
    \node [right = 2 cm of divine] (end) {};
    \node [below = 0.8 cm of start] (property) {property};

    \draw [->, C] (clang) -- (lart);

    \draw [->, C] (lart) -- (divine);

    \draw [->, C] (start) -- (clang);
    \draw [->, C] (property) -| (divine);
    \draw [->, textArrow] (divine) -- (end) node [midway, above = 3pt] {result};
\end{tikzpicture}
}

\bigskip

. . .

- __Diploma thesis:__ prototype that can abstract values on stack

## Current Status

1. __new concept of transformation:__

. . .

- enables abstraction of data on the heap

. . .

- added support of arrays with abstract values

. . .

- get rid of necessity to compute shapes of data structures
    - enables arbitrary structure with abstract data

. . .

2. __polishing of code:__
    - simplification of whole process (from 6000 loc. to 2500 loc.)

. . .

3. __finishing paper resubmition__
    - evaluation should now cover bigger portion of SV-COMP
    - TODO preliminary results

## Plans for the rest of 2018

__May__:

- evaluation + paper submission

. . .

__June -- September__

- string abstraction in cooperation with italian Ph.D. student

. . .

- further work on memory abstractions

. . .

- trip to Aachen to familiarize with local team before Erasmus

. . .

- summer school on automated reasoning (Manchester)

. . .

__October -- December__

- Erasmus at Aachen

. . .

- work on utilization of SMT solving in verification
