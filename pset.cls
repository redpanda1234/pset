% ================================================================== %
%                                                                    %
%                         Requirement Things                         %
%                                                                    %
% ================================================================== %

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{pset}[2018/3/21 v0.01 pset class]

% This class based on the standard article class
\LoadClass{article}



% ================================================================== %
%                                                                    %
%                              Packages                              %
%                                                                    %
% ================================================================== %

% Use decent margins
\RequirePackage[margin=1in, tmargin=1.25in]{geometry}

% Make sure we're inputting stuff correctly
\RequirePackage[utf8]{inputenc}

% And in english!
\RequirePackage[english]{babel}

% Problem and reading set lists, for top of document
\RequirePackage{etoolbox}

% For most of the math symbols, and nice things like align
% environment
\RequirePackage{amsmath, amssymb}

% For `\shortintertext{}` and other things.
\RequirePackage{mathtools}

% For \includegraphics
\RequirePackage{graphicx}

% Fancy page header
\RequirePackage{fancyhdr}

% For customizing the enumerate environment
\RequirePackage{enumitem}

% For multi-column environment
\RequirePackage{multicol}

% In case you want any diagrams, etc.
\RequirePackage{tikz}
\usetikzlibrary{arrows} % Better arrows
\usetikzlibrary{arrows.meta}
\usetikzlibrary{calc} % Add coordinates and stuff
\usetikzlibrary{patterns} % distinguishing shapes

% ...Which you would probably place in figure environments
\RequirePackage{float}

% For referencing page count
\RequirePackage{lastpage}

% Because I've learned my lesson about manual line breaks
\RequirePackage{parskip}

% For checkmark and xmark when confirming / denying claims
\RequirePackage{pifont}

% For cancelling stuff, duh
\RequirePackage{cancel}

% So that the whitespace around section headers can be made less
% obnoxiously large
\RequirePackage{titlesec}

%% COVERSHEET PACKAGES
\RequirePackage{ifthen}
\RequirePackage{array}
\RequirePackage{stackengine}



% ================================================================== %
%                                                                    %
%                          Control Sequences                         %
%                                                                    %
% ================================================================== %

% ------------------------ Creature Comforts ----------------------- %

% For referencing labeled equations w/ number in parens
\let\oldref\ref
\renewcommand{\ref}[1]{(\oldref{#1})}

% For confirming or denying various statements
\newcommand{\cmark}{\text{\ding{51}}}%
\newcommand{\xmark}{\text{\ding{55}}}%

% For properly aligning things w/ neg numbers in matrix environments
\newcommand{\ph}{\phantom{-}}

% Put the qed box all the way to the right
\newcommand{\qed}{\hfill $\blacksquare$}

% ----------------------- General Math stuff ----------------------- %

% Useful commands for paired delimiters that'll adjust to fit whatever
% argument you pass --> e.g. (<something>), [<something else>]
\newcommand{\set}[1]{\ensuremath{ \left\{ #1 \right\} }}
\newcommand{\pn}[1]{\left( #1 \right)}
\newcommand{\abs}[1]{\left| #1 \right|}
\newcommand{\bk}[1]{\left[ #1 \right]}
\newcommand{\ip}[1]{\langle #1 \rangle} % inner product
\newcommand{\lip}[1]{\left\langle #1 \right\rangle} % large ip

% Useful shortcuts for when typing is just too hard
\newcommand{\mrm}[1]{\mathrm{#1}}
\newcommand{\mc}[1]{\mathcal{#1}}
\newcommand{\mb}[1]{\mathbf{#1}}

% Commands to avoid exiting math mode
\newcommand{\st}{\mrm{\ st\ }}
\DeclareMathOperator{\lub}{lub}
\DeclareMathOperator{\glb}{glb}
\DeclareMathOperator{\lcm}{lcm}

% Useful shortcut commands for common fields
\newcommand{\CC}{\mathbb{C}}
\newcommand{\RR}{\mathbb{R}}
\newcommand{\QQ}{\mathbb{Q}}
\newcommand{\ZZ}{\mathbb{Z}}
\newcommand{\NN}{\mathbb{N}}

% Partial differential
\newcommand{\pdd}{\mathop{}\!\partial}

% Total differential
\newcommand{\dd}{\mathop{}\!\mathrm{d}}

% redefine partial derivative and ordinary derivative things
\newcommand{\pd}[3][]{\frac{\pdd^{#1} {#2}}{\pdd {#3}^{#1}}}
\newcommand{\od}[3][]{\frac{\dd^{#1} {#2}}{\dd {#3}^{#1}}}

% Found at https://tex.stackexchange.com/a/350287
\newcommand{\multichoose}[2]{
\left.\mathchoice
  {\left(\kern-0.48em\ch{#1}{#2}\kern-0.48em\right)}
  {\big(\kern-0.30em\ch{\smash{#1}}{\smash{#2}}\kern-0.30em\big)}
  {\left(\kern-0.30em\ch{\smash{#1}}{\smash{#2}}\kern-0.30em\right)}
  {\left(\kern-0.30em\ch{\smash{#1}}{\smash{#2}}\kern-0.30em\right)}
\right.}

\newtheorem{theorem}{Theorem}[section]
\newtheorem{corollary}{Corollary}[theorem] % Reset counter w new thm
\newtheorem{lemma}[theorem]{Lemma} % Same counter as thm

% ------------------------ Physics and such ------------------------ %

% For units
\RequirePackage[alsoload=astro, alsoload=hep]{siunitx}



% ================================================================== %
%                                                                    %
%                          Misc. Formattings                         %
%                                                                    %
% ================================================================== %

% Let align environments overflow page breaks
\allowdisplaybreaks

% I don't like autoindentation for new paragraphs in proofs
\setlength\parindent{0pt}

% Finally, enumerate formatting
\setenumerate[0]{label=(\alph*)}

% And shorten the vspace after section headers. How to read?
%
%                {12pt plus 4pt minus 2pt}
%
%  - 12pt is what we would like the spacing to be
%  - plus 4pt means that TeX can stretch it by at most 4pt
%  - minus 2pt means that TeX can shrink it by at most 2pt

\titlespacing\section{0pt}{
  0pt plus 1pt minus 1pt}{
  0pt plus 1pt minus 1pt}



% ================================================================== %
%                                                                    %
%                          BEGIN COVERSHEET!                         %
%                                                                    %
% ================================================================== %

%% header block command rewritten to create Shahriar Shahriari's cover
%% sheet %% written by Aaron Bagheri %% revised by Forest Kobayashi


% internal state for headerblock
\def\pset@name{}
\def\pset@class{}
\def\pset@prof{}
\def\pset@assignment{}
\def\pset@duedate{}
\def\pset@dueday{}
% \def\pset@reading{}
% \def\pset@problems{}
\def\pset@acknowledgements{}
\def\pset@onTime{}

% Commands to set header block info
\newcommand{\name}[1]{\def\pset@name{#1}}
\newcommand{\class}[1]{\def\pset@class{#1}}
\newcommand{\prof}[1]{\def\pset@prof{#1}}
\newcommand{\assignment}[1]{\def\pset@assignment{#1}}
\newcommand{\duedate}[1]{\def\pset@duedate{#1}}
\newcommand{\dueday}[1]{\def\pset@dueday{#1}}
% \newcommand{\reading}[1]{\def\pset@reading{#1}}
\newcommand{\problems}[1]{\forcsvlist{\listadd\pset@problems}{#1}}
\newcommand{\acknowledgements}[1]{\def\pset@acknowledgements{#1}
  \forcsvlist{\othersaveitem}{#1}}
\newcommand{\onTime}[1]{\def\pset@onTime{#1}}

% So that we can iterate through problems to fill the coversheet table
\newcounter{problemCounter}

\def\saveitem#1{%
  \stepcounter{problemCounter}%
  \expandafter\def\csname problems\theproblemCounter\endcsname{#1}%
}

\def\getProblem#1{\csname problems#1\endcsname}


% Acknowledgments counter
\newcounter{ackCounter}

\def\othersaveitem#1{%
  \stepcounter{ackCounter}%
  \expandafter\def\csname acks\theackCounter\endcsname{#1}%
}

\def\getAck#1{\csname acks#1\endcsname}


% \newcommand{\readinglist}{\noindent\large\rmfamily{Read Sections
%     \pset@reading}}
\newcommand{\problemlist}{\large\rmfamily{Homework
    \pset@assignment\ - \pset@problems}\\[0.1em]}

\def\circleMonday{
  \begin{tikzpicture}[remember picture,overlay]
    \draw[very thick] (7.1,11.6) ellipse (1cm and 0.5cm);
  \end{tikzpicture}
}

\def\circleTuesday{
  \begin{tikzpicture}[remember picture,overlay]
    \draw[very thick] (7.1,11.6) ellipse (1cm and 0.5cm);
  \end{tikzpicture}
}
\def\circleWednesday{
  \begin{tikzpicture}[remember picture,overlay]
    \draw[very thick] (9.25,11.6) ellipse (1.04cm and 0.52cm);
  \end{tikzpicture}
}
\def\circleThursday{
  \begin{tikzpicture}[remember picture,overlay]
    \draw[very thick] (9.25,11.6) ellipse (1.04cm and 0.52cm);
  \end{tikzpicture}
}
\def\circleFriday{
  \begin{tikzpicture}[remember picture,overlay]
    \draw[very thick] (11.2,11.6) ellipse (1.04cm and 0.52cm);
  \end{tikzpicture}
}

\def\drawX{
  \begin{tikzpicture}
    \draw[very thick] (-.25,.25) -- (.25,-.25);
    \draw[very thick] (-.25,-.25) -- (.25,.25);
  \end{tikzpicture}
}


\newcommand{\headerblock}{%
  \thispagestyle{empty}
  \newgeometry{left=1.5in,right=1.5in,top=1.5in}

  \begin{flushright}
    \textbf{\pset@class} \hspace{2.8cm} \mbox{} \\
    \textbf{\pset@prof} \hspace{2.8cm} \mbox{}
  \end{flushright}

  \vspace{1.4cm}

  \begin{center}
    \begin{tabular}{m{4cm} b{8cm}}
      \textbf{Name:}
      & \textbf{\underline{\large\makebox[8cm]{\pset@name}}} \\[1.5em]
      \textbf{HW \#\,:}
      & \textbf{\underline{\makebox[8cm]{\raisebox{.5em}{\large
        \pset@assignment}}}} \\[1.5em]
      \textbf{Day:}
      & \textbf{Mon.} \hspace{2em} \textbf{Tue.} \hspace{2em}
        \textbf{Wed.} \hspace{2em} \textbf{Thu.} \hspace{2em}
        \textbf{Fri.} \\[1.5em]
      \textbf{Date:}
      & \textbf{\underline{\large\makebox[8cm]{\pset@duedate}}}
    \end{tabular}
  \end{center}

  \vspace{1.1cm}

  \newcounter{prob}
  \begin{center}
    \begin{tabular}{| >{\centering\arraybackslash}m{1cm} |
      >{\centering}m{1.2cm} | >{\centering\arraybackslash}m{9cm} |}
      \hline
      \textbf{No.} & \textbf{Points} & \textbf{Acknowledgments} \\
      \hline
    \end{tabular}
    \begin{tabular}{| >{\centering\arraybackslash}b{1cm} |
      >{\centering\arraybackslash}m{1.2cm} |
      >{\centering\arraybackslash}m{9cm} |}
      \hline
      \renewcommand*{\do}[1]{
        \expandafter #1\csname \stepcounter{prob} && \raisebox{-.5em}{\getAck{\number\value{prob}}} \\[1em] \hline\endcsname
      }
      \docsvlist{1, 2, 3, 4}
      \textbf{Total} & & \\[1em]
      \hline
    \end{tabular}
  \end{center}

  \bigskip

  \noindent This Homework is (check one): \\
  \begin{tabular}{lll}
    \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{0}}{\drawX}{}}
    On Time
    & \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{1}}{\drawX}{}}
      2 day extension \#1
    & \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{2}}{\drawX}{}}
      2 day extension \# 2 \\
    \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{3}}{\drawX}{}}
    2 day extension \#3
    & \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{4}}{\drawX}{}}
      2 day extension \#4
    & \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{5}}{\drawX}{}}
      Brownie Point Extension \\
    \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{6}}{\drawX}{}}
    Late & &
  \end{tabular}

  % Circle the correct day on the cover sheet!
  \ifthenelse{\equal{\pset@dueday}{Monday}}{\circleMonday}{}
  \ifthenelse{\equal{\pset@dueday}{monday}}{\circleMonday}{}
  \ifthenelse{\equal{\pset@dueday}{Tuesday}}{\circleTuesday}{}
  \ifthenelse{\equal{\pset@dueday}{tuesday}}{\circleTuesday}{}
  \ifthenelse{\equal{\pset@dueday}{Wednesday}}{\circleWednesday}{}
  \ifthenelse{\equal{\pset@dueday}{wednesday}}{\circleWednesday}{}
  \ifthenelse{\equal{\pset@dueday}{Thursday}}{\circleThursday}{}
  \ifthenelse{\equal{\pset@dueday}{thursday}}{\circleThursday}{}
  \ifthenelse{\equal{\pset@dueday}{Friday}}{\circleFriday}{}
  \ifthenelse{\equal{\pset@dueday}{friday}}{\circleFriday}{}
  \restoregeometry
}

% \DeclareOption{anon}{\AtEndDocument{\headerblock}}

% put id header block at start of document
\AtBeginDocument{\headerblock}
\AtBeginDocument{% insert empty page
  \null
  \thispagestyle{empty}
  \addtocounter{page}{-2}
  \newpage
}

\pagestyle{fancy}
\fancyhf{}
\lhead{\pset@name}
\chead{Homework \#\pset@assignment}
\rhead{Math 171 - Spring \the\year}
\rfoot{\thepage\ of \pageref{LastPage}}
