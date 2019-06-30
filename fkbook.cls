% ================================================================== %
%                                                                    %
%                         Requirement Things                         %
%                                                                    %
% ================================================================== %

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{fkbook}[2018/3/21 v0.01 pset class]

% This class based on the standard article class
\LoadClass{book}



% ================================================================== %
%                                                                    %
%                              Packages                              %
%                                                                    %
% ================================================================== %

% Sensible margins
\RequirePackage[margin=1.25in, tmargin=1.5in]{geometry}

% Better fonts
\RequirePackage{lmodern}

% Make sure we're inputting stuff correctly
\RequirePackage[utf8]{inputenc}

% And in english!
\RequirePackage[english]{babel}

% I've offloaded my math macros into a separate package (in this repo)
\RequirePackage{fkmath}

% As well as theorems
\RequirePackage{fkthm}

% For \includegraphics
\RequirePackage{graphicx}

% For multi-column environment
\RequirePackage{multicol}

% In case you want any diagrams, etc.
\RequirePackage{pgfplots}
\RequirePackage{tikz}
\usetikzlibrary{arrows} % Better arrows
\usetikzlibrary{arrows.meta}
\usetikzlibrary{calc} % Add coordinates and stuff
\usetikzlibrary{patterns} % distinguishing shapes
\usetikzlibrary{decorations.markings} % For midway arrows
\usetikzlibrary{decorations.pathreplacing} % For braces and such
% \usetikzlibrary{external} % Compile diagrams separately
% \tikzexternalize[prefix=figures/] % In a special directory

% ...Which you would probably place in figure environments
\RequirePackage{float}

% For referencing page count
\RequirePackage{lastpage}

% Because I've learned my lesson about manual line breaks
\RequirePackage{parskip}

% For customizing the enumerate environment
\RequirePackage{enumitem}

% So that the whitespace around section headers can be made less
% obnoxiously large
\RequirePackage[pagestyles]{titlesec}

% So that we can make table of contents with redefined chapter play
% nice with hyperref
\RequirePackage{titletoc}

% For better commands
\RequirePackage{xifthen}

% For quasi-legitimate looking tables
\RequirePackage{booktabs}

% For margin modification in subsections
\RequirePackage{changepage}

% Logic for title page
\RequirePackage{ifthen}

% Add some extra stuff for colors and ipa
\RequirePackage{fkmisc}

% For boxed problem statements and stuff
\RequirePackage{boxedminipage}

% For multi-page floats and stuff
\RequirePackage{subcaption}

% For cross-referencing
% \RequirePackage{hyperref}

% For better referencing behavior
\RequirePackage{cleveref}

% \RequirePackage{nameref}

% ================================================================== %
%                                                                    %
%                          Control Sequences                         %
%                                                                    %
% ================================================================== %


% ------------------------ Creature Comforts ----------------------- %

% For referencing labeled equations w/ number in parens
\let\oldref\ref
\renewcommand{\ref}[1]{\textup{(\oldref{#1})}}

% Finally, enumerate formatting
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


% ================================================================== %
%                                                                    %
%                             Cover Page                             %
%                                                                    %
% ================================================================== %

% internal state for coverblock
\def\fkbook@author{}
\def\fkbook@title{}
\def\fkbook@shorttitle{}
\def\fkbook@subtitle{}
\def\fkbook@alttitle{}
\def\fkbook@affiliation{} % This is ridiculous but need it for eq check
\def\fkbook@supervisor{}
\def\fkbook@supervisoraffiliation{}
\def\fkbook@empty{} % Needed for affil check


% Commands to set header block info
\newcommand{\fkauthor}[1]{\def\fkbook@author{#1}}
\newcommand{\fktitle}[2][]{%
  \def\fkbook@title{#2} % define main title
  \def\fkbook@shorttitle{#1}%
}
\newcommand{\fksubtitle}[1]{\def\fkbook@subtitle{#1}}
\newcommand{\fkalttitle}[1]{\def\fkbook@alttitle{#1}}
\newcommand{\fkaffiliation}[1]{\def\fkbook@affiliation{#1}}
\newcommand{\fksupervisor}[1]{\def\fkbook@supervisor{#1}}
\newcommand{\fksupervisoraffiliation}[1]{\def\fkbook@supervisoraffiliation{#1}}

\newcommand{\maketitlepage}{
  \ifx \fkbook@shorttitle\fkbook@empty%
  \def\fkbook@shorttitle{\fkbook@title}%
  \else% do nothing
  \fi
  \begin{titlepage} % Suppresses headers and footers on the title page

    \centering\scshape

    \rule{\textwidth}{1pt}\vspace*{-\baselineskip}\vspace*{2pt}
    \rule{\textwidth}{0.4pt}

    \vspace{0.75\baselineskip} % Whitespace above the title

    {\LARGE \fkbook@title\\}
    \ifthenelse{\equal{\fkbook@subtitle}{}}{}{{\Large \fkbook@subtitle \\}}

    \vspace{0.75\baselineskip} % Whitespace below the title

    \rule{\textwidth}{0.4pt}\vspace*{-\baselineskip}\vspace*{2.4pt}
    \rule{\textwidth}{1pt}

    \vspace{\baselineskip} % Whitespace after the title block

    % ------------------------------------------------
    %	Subtitle
    % ------------------------------------------------

    \ifthenelse{\equal{\fkbook@alttitle}{}}{}{
      {\large \fkbook@alttitle}}

    \vspace*{8\baselineskip}

    % ------------------------------------------------
    %	Authors
    % ------------------------------------------------

    % {Written By\\}
    {\Large \fkbook@author\\ } % Author list
    \vspace{1\baselineskip}
    % Check if affiliation is empty, insert it if not
    \ifx\fkbook@affiliation\fkbook@empty \else \fkbook@affiliation\fi

    \ifthenelse{\equal{\fkbook@supervisor}{}}{\vfill\includegraphics[width=3cm,
      keepaspectratio=true]{logo.png}\vspace{\baselineskip}}{\vfill {\small Supervised
        By\\ }{\fkbook@supervisor\footnote{\fkbook@supervisoraffiliation} \vspace{6\baselineskip
          \includegraphics[width=2cm, keepaspectratio=true]{logo.png} \vspace{.3\baselineskip}}}}

    {\large \normalfont Last Updated: \today} % Publication year
    \vspace{1\baselineskip}
  \end{titlepage}}


% Oops refactor this additional math stuff later

\newenvironment{problem}[1][Problem]
{\noindent\begin{center}\begin{boxedminipage}{.95\linewidth}\textbf{#1.} }
    {\end{boxedminipage}\end{center}}

\newenvironment{solution}[1][Solution.]
{\noindent\begin{center}\begin{adjustwidth}{.05\linewidth}{.05\linewidth}\emph{#1}\ }
    {\qed\end{adjustwidth}\end{center}}

\newenvironment{recall}
{\noindent\begin{center}\begin{boxedminipage}{.95\linewidth}\textbf{Recall:}}
    {\end{boxedminipage}\end{center}}

\newenvironment{ex}
{\noindent \textbf{Ex:}}
{\\}


% ================================================================== %
%                                                                    %
%                          Misc. Formattings                         %
%                                                                    %
% ================================================================== %

% Let align environments overflow page breaks
\allowdisplaybreaks

% Set appropriate paragraph indentation
\setlength{\parindent}{1.5em}

% And shorten the vspace after section headers. How to read?
%
% {12pt plus 4pt minus 2pt}
%
% - 12pt is what we would like the spacing to be
% - plus 4pt means that TeX can stretch it by at most 4pt
% - minus 2pt means that TeX can shrink it by at most 2pt

\newcommand{\chapterrule}{\rule{\textwidth}{.8pt}}

\titleformat{\chapter}[block]
{\chapterrule\vspace*{.5cm}\\\bfseries\Large\centering}%
{\thechapter.}%
{.5em}%
{\Large}%
[\chapterrule]

\titlespacing*{\chapter}{0pt}{-6em}{2.5em}
\titlespacing*{\section}{0pt}{\parskip}{0pt}
\titlespacing*{\subsection}{0pt}{\parskip}{0pt}
\titlespacing*{\subsubsection}{0pt}{\parskip}{0pt}

\newpagestyle{main}{
  \sethead{\fkbook@author}{\scshape\chaptertitle}{\fkbook@shorttitle}
  \headrule
  \setfoot{Last Updated \today}{}{\thepage\ of \pageref{LastPage}}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\endinput
