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
\RequirePackage[margin=1in, tmargin=1.25in]{geometry}

% Better fonts
\RequirePackage{lmodern}

% Make sure we're inputting stuff correctly
\RequirePackage[utf8]{inputenc}

% And in english!
\RequirePackage[english]{babel}

% I've offloaded my math macros into a separate package (in this repo)
\RequirePackage{fkmath}

% For \includegraphics
\RequirePackage{graphicx}

% For multi-column environment
\RequirePackage{multicol}

% In case you want any diagrams, etc.
\RequirePackage{tikz}
\usetikzlibrary{arrows} % Better arrows
\usetikzlibrary{arrows.meta}
\usetikzlibrary{calc} % Add coordinates and stuff
\usetikzlibrary{patterns} % distinguishing shapes
\usetikzlibrary{decorations.pathreplacing} % For braces and such

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
\def\fkbook@subtitle{}
\def\fkbook@alttitle{}
\def\fkbook@affiliation{} % This is ridiculous but need it for eq check
\def\fkbook@supervisor{}
\def\fkbook@supervisoraffiliation{}
\def\fkbook@empty{} % Needed for affil check


% Commands to set header block info
\newcommand{\fkauthor}[1]{\def\fkbook@author{#1}}
\newcommand{\fktitle}[1]{\def\fkbook@title{#1}}
\newcommand{\fksubtitle}[1]{\def\fkbook@subtitle{#1}}
\newcommand{\fkalttitle}[1]{\def\fkbook@alttitle{#1}}
\newcommand{\fkaffiliation}[1]{\def\fkbook@affiliation{#1}}
\newcommand{\fksupervisor}[1]{\def\fkbook@supervisor{#1}}
\newcommand{\fksupervisoraffiliation}[1]{\def\fkbook@supervisoraffiliation{#1}}

\newcommand{\maketitlepage}{
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
  {\large (\normalfont Or: \itshape \fkbook@alttitle)}}

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
      By\\ }{\fkbook@supervisor\footnote{\fkbook@supervisoraffiliation} \vspace{4\baselineskip
        \includegraphics[width=1cm, keepaspectratio=true]{logo.png} \vspace{.3\baselineskip}}}}

  {\large \normalfont \today} % Publication year
  \vspace{1\baselineskip}
\end{titlepage}}


% ================================================================== %
%                                                                    %
%                          Misc. Formattings                         %
%                                                                    %
% ================================================================== %

% Let align environments overflow page breaks
\allowdisplaybreaks

% I don't like autoindentation for new paragraphs
\setlength\parindent{0pt}

% And shorten the vspace after section headers. How to read?
%
%                {12pt plus 4pt minus 2pt}
%
%  - 12pt is what we would like the spacing to be
%  - plus 4pt means that TeX can stretch it by at most 4pt
%  - minus 2pt means that TeX can shrink it by at most 2pt

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
  \sethead{Forest Kobayashi}{\scshape\chaptertitle}{Analysis II Notes}
  \headrule
  \setfoot{Last Updated \today}{}{\thepage\ of \pageref{LastPage}}
} % odd
% \pagestyle{main}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

% \makeheaders{}

\endinput
