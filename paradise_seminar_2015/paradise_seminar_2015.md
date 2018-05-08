---
title: $\nicefrac{1}{2} \text{\divine} + \text{\divine} = 1 \text{ and } \nicefrac{1}{4} \text{\divine}$
author: Henrich Lauko
header-includes:
    - \usepackage{divine}
    - \usepackage{units}
    - \usepackage{tikz}
    - \usepackage{xspace}
    - \usetikzlibrary{shapes, arrows, shadows, positioning, calc, fit, backgrounds, decorations.pathmorphing}
    - \usepackage{xcolor}
    - \newcommand\todo[1]{\textcolor{red}{#1}}
lang: english
...

## Recapitulation \symdivine

\resizebox{\textwidth}{!}{
\begin{tikzpicture}[>=stealth',shorten >=1pt,auto,node distance=4em,initial text=, <->]

\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{outer}=[draw, dotted, thick]
\tikzstyle{C}=[dashed]
\tikzstyle{textArrow}=[decorate, decoration={snake, post length=0.1 cm}]
\tikzset{>=latex}

\tikzstyle{symdivine}=[fill=paradisegreen!10]
\tikzstyle{prepocessing}=[fill=red!10]
\tikzstyle{smt}=[fill=blue!10]

    \node [component](clang) {clang -emit-llvm};
    \node [component, below = 0.5 cm of clang](lart) {\lart};

    \node [component, right = 0.5 cm of lart, ](interpreter) {\llvm interpreter};
    \node [component, right = 0.5 cm of interpreter, minimum width=1 cm](generator) {State space generator};

    \node [smt, component, right = 0.5 cm of generator, minimum width=1 cm, text width=1 cm](smt){\smt};
    \node [component, above = 0.5 cm of generator, minimum width=1 cm](exploration) {Exploration algorithm};

    \begin{pgfonlayer}{background}[fill=blue!10]
        \node[prepocessing, outer, fit = (clang) (lart), label=Preprocessing] (preprocessing) {};
    \end{pgfonlayer}

    \begin{pgfonlayer}{background}
        \node[symdivine, outer, fit = (interpreter) (generator) (exploration), label=\symdivine] (preprocessing) {};
    \end{pgfonlayer}

    \node [left = 1.5 cm of clang] (start) {input.c};
    \node [right = 2 cm of exploration] (end) {};
    \node [below = 2.3 cm of start] (property) {property};

    \draw [->, C] (clang) -- (lart);

    \draw [->, C] (lart) -- (interpreter);

    \draw [<->] (interpreter) -- (generator);

    \draw [<->] (smt) -- (generator);

    \draw [->] (generator) -- (exploration);

    \draw [->, C] (start) -- (clang);
    \draw [->, C] (property) -| (generator);
    \draw [->, textArrow] (exploration) -- (end) node [midway, above = 3pt] {result};
\end{tikzpicture}
}

## State space generation example \symdivine

## Recapitulation \divine

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

## Mornfall

![Mornfall](data/morfal.jpg)

## Big idea

\resizebox{\textwidth}{!}{
\begin{tikzpicture}[>=stealth',shorten >=1pt,auto,node distance=4em,initial text=, <->]
\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{textArrow}=[decorate, decoration={snake, post length=0.1 cm}]
\tikzset{>=latex}

    \node<1> [component](test) {test};
    \node [component, below = 2 cm of test](divine) {\divine};

    \node [component, right = 3.4 cm of test](verifikace) {verification};
    \node [component, below = 2 cm of verifikace](symdivine) {\symdivine};

    \node [below = 0.8 cm of divine] (res1) {result};
    \node<1> [below = 0.8 cm of symdivine] (res2) {result};

    \node<2-> [component,below right= 0.5cm and 0.5cm of test] (test2) {test};

    \draw<1> [->] (test) -- (divine);
    \draw<1> [->] (verifikace) -- (symdivine);

    \draw [->,textArrow] (divine) -- (res1);
    \draw<1> [->,textArrow] (symdivine) -- (res2);

    \draw<3-> [->, onslide={<3-4> line width = 1.5pt, red}] (verifikace) |- (test2) node [near end, above = 1pt] {\tiny\llvm to \llvm};

    \draw<4-> [->, onslide={<4> line width = 1.5pt, red}] (symdivine) |- (test2);
    \draw<5-> [->, onslide={<5> line width = 1.5pt, red}] (symdivine) -- (divine);
    \draw<6-> [->,onslide={<6> line width = 1.5pt, red}] (test2) -| (divine);

\end{tikzpicture}
}

## Integration

\resizebox{\textwidth}{!}{
\begin{tikzpicture}[>=stealth',shorten >=1pt,auto,node distance=4em,initial text=, <->]

\tikzstyle{component_s}=[rectangle split, rectangle split horizontal,rectangle split parts=2,draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{outer}=[draw, dotted, thick]
\tikzstyle{C}=[dashed]
\tikzstyle{textArrow}=[decorate, decoration={snake, post length=0.1 cm}]
\tikzset{>=latex}

\tikzstyle{symdivine}=[fill=paradisegreen!10]
\tikzstyle{prepocessing}=[fill=red!10]
\tikzstyle{smt}=[fill=blue!10]

    \node [component_s, right = 1 cm of start](lart) {\lart \nodepart{second} \textcolor{red}{$\textsf{Sym}_1$}};

    \node [component_s, right = 0.5 cm of lart, ](divine) {Magic \nodepart{second} \textcolor{red}{$\textsf{Sym}_2$}};

    \node [smt, component, below = 0.5 cm of divine, anchor = north west](smt){\smt};

    \begin{pgfonlayer}{background}[fill=blue!10]
        \node[prepocessing, outer, fit = (lart), label=Preprocessing] (preprocessing) {};
    \end{pgfonlayer}

    \begin{pgfonlayer}{background}
        \node[symdivine, outer, fit = (divine), label=\divine] (preprocessing) {};
    \end{pgfonlayer}

    \node [left = 1 cm of clang] (start) {input.ll};
    \node [right = 2 cm of divine] (end) {};
    \node [below = 0.8 cm of start] (property) {property};

    \draw [->] (lart) -- (divine);

    \draw [->] (start) -- (lart);
    \draw [->] (property) -| (divine.one south);
    \draw [->, textArrow] (divine) -- (end) node [midway, above = 3pt]{result};

    \draw [<->] (divine.two south) -- (smt.north);
\end{tikzpicture}
}

## Data representation ($\textsf{Sym}_1$)

\centering
\resizebox{\textwidth}{!}{
\begin{tikzpicture}[>=stealth',shorten >=1pt,auto,node distance=4em,initial text=, <->]

\tikzstyle{component_s}=[rectangle split, rectangle split parts=3,draw, text centered, rounded corners=0pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{outer}=[draw, dotted, thick]
\tikzset{>=latex}
\tikzstyle{symdivine}=[fill=paradisegreen!10]

    \node [component](sym_data) {Symbolic data};
    \node [component, below = 0.5 cm of sym_data, onslide={<4->color=paradisegreen}] (exp_data) {Explicit data};
    \node [component, below = 0.5 cm of exp_data, onslide={<5->color=paradisegreen}] (cont_data) {Control flow data};

    \begin{pgfonlayer}{background}
        \node[symdivine, outer, fit = (sym_data) (exp_data) (cont_data), label=State in \symdivine] (state) {};
    \end{pgfonlayer}

    \node [right = 5.5 cm of sym_data, anchor = south] (tmp) {};
    \node <2->[right = 4 cm of sym_data.east, anchor = south] (definitions) {data definitions};
    \node <3->[below = 0.2 cm of definitions] (pc) {path condition};

    \draw <2->[->, dashed] (sym_data) -- (definitions.west);
    \draw <3->[->, dashed] (sym_data) -- (pc);
\end{tikzpicture}
}

## Data representation ($\textsf{Sym}_1$)

\centering
\resizebox{\textwidth}{!}{
\begin{tikzpicture}[>=stealth',shorten >=1pt,auto,node distance=4em,initial text=, <->]

\tikzstyle{component_h}=[rectangle split, rectangle split horizontal, rectangle split parts=3,draw, text centered, rounded corners=0pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{component_v}=[rectangle split, rectangle split parts=2,draw, text centered, rounded corners=0pt, minimum height=2.8 cm, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{outer}=[draw, dotted, thick]
\tikzset{>=latex}
\tikzstyle{symdivine}=[fill=paradisegreen!10]
\tikzstyle{lart}=[fill=red!10]

\tikzstyle{textArrow}=[decorate, decoration={snake, post length=0.1 cm}]

     \node [component_h] (data) {segment \nodepart{second} offset \nodepart{third} generation};

      \node [component_v, right = 2 cm of data, ] (lart_data) {generation \nodepart{second} bit width};

    \begin{pgfonlayer}{background}
        \node[symdivine, outer, fit = (data), label=Symbolic data in \symdivine] (state) {};
    \end{pgfonlayer}

    \begin{pgfonlayer}{background}
        \node[lart, outer, fit = (lart_data), label=Structure in \llvm] (state) {};
    \end{pgfonlayer}

    \draw [->, textArrow] (data) -- (lart_data);
\end{tikzpicture}
}

- segment and offset represented as address of structure
- using bit width in \smt{} solver
- propagation in AST

## Data representation example ($\textsf{Sym}_1$)

```c
int useless_function(int x, int y) {
    int z = x + 1;
    if (x < y) {
        return y - z;
    } else {
        return y;
    }
}
```

\dots

```c
int x = __VERIFIER_nondet_int();
int y = 1;
int res = useless_function(x, y);
```

## Data representation example ($\textsf{Sym}_1$)

```c
declarations = {z = x + 1, nd_y = 1};
path_condition = {true};
```

```c
<@\textcolor{red}{nondet\_int}@> useless_function(<@\textcolor{red}{nondet\_int x}@>, int y) {
    <@\textcolor{red}{nondet\_int z = x + 1;}@>
    <@\textcolor{red}{nondet\_int nd\_y = y;}@> //exlicit value
    if ( <@\textcolor{red}{x < nd\_y}@>) {
        return <@\textcolor{red}{nd\_y - z}@> ;
    } else {
        return <@\textcolor{red}{nd\_y}@>;
    }
}
```

```c
<@\textcolor{red}{nondet\_int x;}@>
int y = 1;
<@\textcolor{red}{nondet\_int res}@> = useless_function(<@\textcolor{red}{x}@>, y);
```

- data replacement and propagation in AST

## Data representation example ($\textsf{Sym}_1$)

```c
declarations = {z = x + 1, nd_y = 1};
path_condition = {true};
```

```c
<@\textcolor{red}{nondet\_int}@> useless_function(<@\textcolor{red}{nondet\_int x}@>, int y) {
    <@\textcolor{red}{nondet\_int z}@> = <@\textcolor{paradisegreen}{plus(x, 1)}@>;
    <@\textcolor{red}{nondet\_int nd\_y = y;}@> //exlicit value
    if (<@\textcolor{paradisegreen}{less(x,nd\_y)}@>) {
        return <@\textcolor{paradisegreen}{minus(nd\_y,z)}@>;
    } else {
        return <@\textcolor{red}{nd\_y}@>;
    }
}
```

```c
<@\textcolor{red}{nondet\_int x;}@>
int y = 1;
<@\textcolor{red}{nondet\_int res}@> = useless_function(<@\textcolor{red}{x}@>, y);
```

- operations on nondeterministic data and function duplication

## Control representation example ($\textsf{Sym}_1$)

```c
declarations = {z = x + 1, nd_y = 1};
path_condition = {x < nd_y};
```

```c
<@\textcolor{red}{nondet\_int}@> useless_function(<@\textcolor{red}{nondet\_int x}@>, int y) {
    <@\textcolor{red}{nondet\_int z}@> = <@\textcolor{paradisegreen}{plus(x, 1)}@>;
    <@\textcolor{red}{nondet\_int nd\_y = y;}@> //exlicit value
    <@\textcolor{blue}{bool choice = \_\_divine\_choice(2);}@>
    if (<@\textcolor{blue}{choice}@>) {
        <@\textcolor{blue}{change\_pc(less(x, nd\_y));}@>
        <@\textcolor{red}{nondet\_int ret = minus(nd\_y,z);}@>
        <@\textcolor{blue}{cleanup(ret);}@>
        return <@\textcolor{red}{ret}@>;
    } else {
        <@\textcolor{blue}{change\_pc(not less(x, nd\_y));}@>
        <@\textcolor{red}{nondet\_int ret = nd\_y;}@>
        <@\textcolor{blue}{cleanup(ret);}@>
        return <@\textcolor{red}{ret}@>;
```

## Function duplication example ($\textsf{Sym}_1$)

```c
int function(int x, int y) { <@\dots@> }
```

```c
nondet_int function(nondet_int x, int y) { <@\dots@> }
```

```c
int function(nondet_int x, nondet_int y) { <@\dots@> }
```

```c
int x = __VERIFIER_nondet_int();
int y = 1, z = 0;

int res1 = function(x, y);
int res2 = function(y, z);
```

## \divine{} state space generation $\textsf{Sym}_2$

\centering
\resizebox{\textwidth}{!}{
\begin{tikzpicture}[>=stealth',shorten >=1pt,auto,node distance=4em,initial text=, <->]

\tikzstyle{component_h}=[rectangle split, rectangle split horizontal, rectangle split parts=3,draw, text centered, rounded corners=0pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{component_v}=[rectangle split, rectangle split parts=2,draw, text centered, rounded corners=0pt, minimum height=2.8 cm, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{outer}=[draw, dotted, thick]
\tikzset{>=latex}
\tikzstyle{symdivine}=[fill=paradisegreen!10]
\tikzstyle{lart}=[fill=red!10]
\tikzstyle{smt}=[fill=blue!10]

\tikzstyle{textArrow}=[decorate, decoration={snake, post length=0.1 cm}]

    \node [component] (data) {state};
    \node [smt, component, right = 1cm of data] (smt) {\smt};
    \node [component, right = 2cm of smt] (gen_state) {generated states};

    \node [smt, component, below = 0.6 cm of gen_state] (smt_sym) {\smt};
    \node [component, right = 2cm of smt_sym] (new_state) {new state};

    \draw [->] (data) -- (smt);
    \draw [->, textArrow] (smt) -- (gen_state) node [midway, above = 3pt] {generate};
    \draw [->] (gen_state) -- (smt_sym);
    \draw [->, textArrow] (smt_sym) -- (new_state) node [midway, above = 3pt] {reduction};

\end{tikzpicture}
}

- Before generating -- checking path condition.

## \divine{} state space generation $\textsf{Sym}_2$

\centering
\resizebox{\textwidth}{!}{
\begin{tikzpicture}[>=stealth',shorten >=1pt,auto,node distance=4em,initial text=, <->]

\tikzstyle{component_h}=[rectangle split, rectangle split horizontal, rectangle split parts=3,draw, text centered, rounded corners=0pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{component_v}=[rectangle split, rectangle split parts=2,draw, text centered, rounded corners=0pt, minimum height=2.8 cm, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{outer}=[draw, dotted, thick]
\tikzset{>=latex}
\tikzstyle{symdivine}=[fill=paradisegreen!10]
\tikzstyle{lart}=[fill=red!10]
\tikzstyle{smt}=[fill=blue!10]

\tikzstyle{textArrow}=[decorate, decoration={snake, post length=0.1 cm}]

    \node [component] (data) {state};
    \node [smt, component, right = 1cm of data] (smt) {\smt};
    \node [component, right = 2cm of smt] (gen_state) {generated states};

    \node [smt, component, below = 0.6 cm of gen_state] (smt_sym) {\smt};
    \node [component, right = 2cm of smt_sym] (new_state) {new state};

    \draw [->] (data) -- (smt);
    \draw [->, textArrow] (smt) -- (gen_state) node [midway, above = 3pt] {generate};
    \draw [->] (gen_state) -- (smt_sym);
    \draw [->, textArrow] (smt_sym) -- (new_state) node [midway, above = 3pt] {reduction};

\end{tikzpicture}
}

- Checking equality of symbolic part.

## \divine{} keeping states $\textsf{Sym}_2$

- hashing explicit part
- linearly chaining symbolic parts to hash table position

## Summary

\resizebox{\textwidth}{!}{
\begin{tikzpicture}[>=stealth',shorten >=1pt,auto,node distance=4em,initial text=, <->]

\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{textArrow}=[decorate, decoration={snake, post length=0.1 cm}]
\tikzstyle{component_s}=[rectangle split, rectangle split horizontal,rectangle split parts=2,draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{component}=[draw, text centered, rounded corners=1pt, minimum height=2.8 em, minimum width=2.2 cm, text width=2 cm]
\tikzstyle{outer}=[draw, dotted, thick]
\tikzstyle{C}=[dashed]
\tikzstyle{textArrow}=[decorate, decoration={snake, post length=0.1 cm}]
\tikzset{>=latex}

\tikzstyle{symdivine}=[fill=paradisegreen!10]
\tikzstyle{prepocessing}=[fill=red!10]
\tikzstyle{smt}=[fill=blue!10]

    \node [component_s, right = 1 cm of start](lart) {\lart \nodepart{second} \textcolor{red}{$\textsf{Sym}_1$}};

    \node [component_s, right = 0.5 cm of lart, ](divine) {Magic \nodepart{second} \textcolor{red}{$\textsf{Sym}_2$}};

    \node [smt, component, below = 0.5 cm of divine, anchor = north west](smt){\smt};

    \begin{pgfonlayer}{background}[fill=blue!10]
        \node[prepocessing, outer, fit = (lart), label=Preprocessing] (preprocessing) {};
    \end{pgfonlayer}

    \begin{pgfonlayer}{background}
        \node[symdivine, outer, fit = (divine), label=\divine] (preprocessing) {};
    \end{pgfonlayer}

    \node [left = 1 cm of clang] (start) {input.ll};
    \node [right = 2 cm of divine] (end) {};
    \node [below = 0.8 cm of start] (property) {property};

    \draw [->] (lart) -- (divine);

    \draw [->] (start) -- (lart);
    \draw [->] (property) -| (divine.one south);
    \draw [->, textArrow] (divine) -- (end) node [midway, above = 3pt]{result};

    \draw [<->] (divine.two south) -- (smt.north);
\end{tikzpicture}
}

##

\centering
Questions and \Huge Lunch!



