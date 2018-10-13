% paper-tikz-picture.sty
% (c) 2018 Henrich Lauko template standalone tikz pictures

\ProvidesClass{tikzfig}[2018/05/11 v 0.1]
\LoadClass[a4paper,8pt]{article}
\RequirePackage[a4paper]{geometry}

\NeedsTeXFormat{LaTeX2e}
\RequirePackage{iftex}

\ifPDFTeX
    \RequirePackage{etex}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage{lmodern}
\else
    \RequirePackage{fontspec}
    \setmainfont{Latin Modern Roman}
\fi

\RequirePackage{ifthen}
\RequirePackage{tikz}
\RequirePackage[outline]{contour}
\contourlength{2pt}


\RequirePackage{listings}

\lstset{
    language=Python,
    showstringspaces=false,
    formfeed=\newpage,
    tabsize=4,
    commentstyle=\itshape,
    basicstyle=\footnotesize\ttfamily,
    mathescape=true,
    literate=
       {<-}{$\leftarrow{}$}{1}
       {->}{$\rightarrow{}$}{1},
}

\usetikzlibrary{
    positioning,
    backgrounds,
    patterns,
    shapes,
    arrows,
    calc,
    fit
}

\tikzset{
    common/.style = {
        inner sep = 1pt,
        outer sep = 0pt,
        minimum height = 1.5em,
        minimum width = 1.5em,
        align=center,
        text centered
    },
    val/.style = {
        draw,
        rectangle,
        text width=1em,
        common
    },
    op/.style = {
        draw,
        circle,
        text width=1em,
        common
    },
    constraint/.style = {
        rectangle,
        fill=gray!30,
        rounded corners,
        common,
        minimum width = 3.5em
    },
    component/.style = {
        draw,
        rectangle,
        common,
        minimum width = 7em
    },
    hatching/.style = {
        pattern = north west lines,
        pattern color = red
    },
    added/.style = {
        color = red,
        pattern=north west lines,
        pattern color=red
    },
    controlflow/.style = {
        dotted
    },
    ptr/.style = {
        dotted, ->, >=stealth
    }
}

\pagestyle{empty}

\pagestyle{empty}
