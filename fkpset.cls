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

% Sensible margins
\RequirePackage[margin=1in, tmargin=1.25in]{geometry}

% Better fonts
\RequirePackage{lmodern}

% Make sure we're inputting stuff correctly
\RequirePackage[utf8]{inputenc}

% And in english!
\RequirePackage[english]{babel}

% Add a color package for color manipulations.
\RequirePackage[dvipsnames]{xcolor}

% I've offloaded my math macros into a separate package (in this repo)
\RequirePackage{fkmath}

% For \includegraphics
\RequirePackage{graphicx}

% Fancy page header
\RequirePackage{fancyhdr}

% For multi-column environment
\RequirePackage{multicol}

% In case you want any diagrams, etc.
\RequirePackage{tikz}
\usetikzlibrary{arrows} % Better arrows
\usetikzlibrary{arrows.meta}
\usetikzlibrary{calc} % Add coordinates and stuff
\usetikzlibrary{patterns} % distinguishing shapes
\usetikzlibrary{decorations.pathreplacing} % For braces and such
\usetikzlibrary{decorations.markings} % For arrows on lines
\RequirePackage{pgfplots}

% ...Which you would probably place in figure environments
\RequirePackage{float}
\RequirePackage{subcaption}

% For referencing page count
\RequirePackage{lastpage}

% Because I've learned my lesson about manual line breaks
\RequirePackage{parskip}

% For customizing the enumerate environment
\RequirePackage{enumitem}

% So that the whitespace around section headers can be made less
% obnoxiously large
\RequirePackage{titlesec}

% For better commands
\RequirePackage{xifthen}

% For quasi-legitimate looking tables
\RequirePackage{booktabs}

% For margin modification in subsections
\RequirePackage{changepage}

% Problem and reading set lists, for top of document
\RequirePackage{etoolbox}

% For more bearable referencing
\RequirePackage{fancyref}

% Use smarter referencing and stuff
\RequirePackage[capitalise]{cleveref}

% Boxed problem statements
\RequirePackage{boxedminipage}

% ================================================================== %
%                                                                    %
%                          Control Sequences                         %
%                                                                    %
% ================================================================== %


% ------------------------ Creature Comforts ----------------------- %

% Default to letters for enumerate formatting
\setenumerate[0]{label=$($\alph*$)$}

% Check if command exists
\newcommand{\checkfor}[1]{%
  \ifcsname#1\endcsname%
    Command \texttt{\textbackslash#1} is defined already. Choose
    another macro!
  \else%
    Command \texttt{\textbackslash#1} is not defined yet. Go ahead!
  \fi%
}

% For units
% FIXME: Is this really something I use often still?
\RequirePackage[alsoload=astro, alsoload=hep]{siunitx}

% Problem environment
\newenvironment{problem}[1][Problem \thesection]
{\noindent\begin{center}\begin{boxedminipage}{.95\linewidth}\textbf{#1}\setlength{\parindent}{1.5em}}
{\end{boxedminipage}\end{center}}

\renewcommand{\qed}{\hfill $\blacksquare$}
% \newenvironment{solution}[1][Solution.]
% {\noindent\begin{center}\begin{adjustwidth}{.05\linewidth}{.05\linewidth}\emph{#1}\ \pushQED }
% {\popQED\end{adjustwidth}\end{center}}
\newenvironment{solution}[1][Solution.]
{\noindent\begin{center}\begin{adjustwidth}{.05\linewidth}{.05\linewidth}\emph{#1}\ }
{\qed\end{adjustwidth}\end{center}}


\theoremstyle{plain}% default
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{conjecture}[theorem]{Conjecture}

\theoremstyle{definition}
\newtheorem{definition}{Definition}
\newtheorem{example}{Example}
\newtheorem{axiom}{Axiom}
\newtheorem*{remark}{Remark}
\newtheorem*{note}{Note}


% ================================================================== %
%                                                                    %
%                          Misc. Formattings                         %
%                                                                    %
% ================================================================== %

% We want to let align environments overflow page breaks
\allowdisplaybreaks

% I don't like autoindentation for new paragraphs
\setlength\parindent{0pt}

% Thicker top rule for header and footer
\newcommand{\trule}{\vspace{-.5\baselineskip}%
  \rule{\textwidth}{1pt}\vspace*{-\baselineskip}\vspace*{2pt}
  \rule{\textwidth}{0.4pt}}

% Flanked by a thinner bottomrule
\newcommand{\brule}{\vspace{.125\baselineskip}
  \rule{\textwidth}{0.4pt}\vspace*{-\baselineskip}\vspace*{2.4pt}
  \rule{\textwidth}{1pt}}

% Points table rule (if so desired). Thinner!
\newcommand{\prule}{\rule{\linewidth}{.75pt}}

% Draw the header line
\renewcommand\headrule{
\begin{minipage}{1\textwidth}
  \trule
\end{minipage}}%

% And footer
\renewcommand\footrule{
  \begin{minipage}{1\linewidth}
    \brule
  \end{minipage}
}

% internal state for coverblock
\def\fkpset@name{}
\def\fkpset@class{}
\def\fkpset@duedate{}
\def\fkpset@assignment{}
\def\fkpset@problems{}

% Commands to set header block info
\newcommand{\name}[1]{\def\fkpset@name{#1}}
\newcommand{\class}[1]{\def\fkpset@class{#1}}
\newcommand{\duedate}[1]{\def\fkpset@duedate{#1}}
\newcommand{\assignment}[1]{\def\fkpset@assignment{#1}}
\newcommand{\problems}[1]{\def\fkpset@problems{#1}
  \forcsvlist{\saveitem}{#1}\forcsvlist{\listadd\problist}{#1}}

% So that we can iterate through problems to fill the coversheet table
\newcounter{problemCounter}

% This stores each problem as a new command sequence,
% `\problems<problem_name>`. This allows us to get each problem back
% out easily, e.g. typesetting problem `10.3.1` is as easy as
% `\problems10.3.1`. This is inelegant, but it works.
\def\saveitem#1{%
  \stepcounter{problemCounter}%
  \expandafter\def\csname problems\theproblemCounter\endcsname{#1}%
}

\def\getProblem#1{\expandafter{\csname problems#1\endcsname}}

\newcounter{prob}
\newcommand{\dothis}[1]{\stepcounter{prob}
  \getProblem{\number\value{prob}} & }

\newcommand{\pointstable}[2][centering]{
  \begin{table}[h]
    \vspace{-2.85cm}
    \csname#1\endcsname
    #2
    % *{\theproblemCounter} gets us that many c's. Since indexing starts at 0,
    % we have to add one on at the end manually.
    \begin{tabular}{l *{\theproblemCounter} c r}
      \toprule
      Problem & \forlistloop{\dothis}{\problist} Total \\ \midrule
      Points & \\
      \bottomrule
    \end{tabular}
    \vspace{.75cm}
  \end{table}

  % \prule

  % \vspace{.5cm}
}

\pagestyle{fancy}
\fancyhf{}
\lhead{\fkpset@name}
\rfoot{\thepage\ of \pageref{LastPage}}
\setlength{\headheight}{15.2pt}
\setlength{\headsep}{10pt}

\newcommand{\rblock}{
  \begin{flushright}%
    \mbox{\fkpset@name}\protect\\
    \mbox{\fkpset@class}\protect\\
    \mbox{\fkpset@assignment}\protect\\
    \fkpset@duedate%
  \end{flushright}%
  \brule}%

%
\DeclareOption{norblock}{
  \renewcommand{\rbloc}{\@gobble}
}

% Verbose error messages
\DeclareOption{verbose}{
  \setcounter{errorcontextlines}{999}
}

\DeclareOption{algs}{
  \geometry{paperwidth=10.5in, paperheight=11in, lmargin=2in, rmargin=2in}


  \fancyhfoffset[E,O]{0pt}

  \renewcommand{\rblock}{}%

  \renewenvironment{problem}[1][Problem \thesection]
  {\section*{#1}}
  {

    \hrulefill

  }
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Typeset the name block
\AtBeginDocument{\rblock}

\endinput
