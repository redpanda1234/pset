% ================================================================== %
%                                                                    %
%                         Requirement Things                         %
%                                                                    %
% ================================================================== %

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{paper}[2018/3/21 v0.01 pset class]

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
\RequirePackage{titlesec}

% For better commands
\RequirePackage{xifthen}

% For quasi-legitimate looking tables
\RequirePackage{booktabs}

% For margin modification in subsections
\RequirePackage{changepage}

% Problem and reading set lists, for top of document
\RequirePackage{etoolbox}

%% COVERSHEET PACKAGES
\RequirePackage{ifthen}
\RequirePackage{array}
\RequirePackage{stackengine}

\NeedsTeXFormat{LaTeX2e}

% ================================================================== %
%                                                                    %
%                  Formatting for Scientific Papers!                 %
%                                                                    %
% ================================================================== %

% Use tighter margins
\newgeometry{margin=.75in, tmargin=1in}

% them appropriately sized, and what have you.
\titleformat{\section}
  {\normalfont\large\scshape\filcenter}{\scshape\thesection.}{.5em}{}
\titleformat{\subsection}
  {\normalfont\scshape\filcenter}{\scshape\thesubsection.}{.5em}{}
\titleformat{\subsubsection}
  {\normalfont\scshape\filcenter}{\scshape\thesubsubsection.}{.5em}{}

% Ha-ha-ha-ha, harrrr-a-ha-ha-ha-hA, ha-HA, ha-HA...
\titlespacing{\section}{0pt}{10pt plus 4pt minus 2pt}{-5pt plus 2pt
  minus 2pt}
\titlespacing{\subsection}{0pt}{10pt plus 4pt minus 2pt}{-3pt plus 0pt
  minus 0pt}
\titlespacing{\subsubsection}{0pt}{10pt plus 4pt minus 2pt}{0pt plus
  2pt minus 2pt}

% Make the double column format more appealing by spacing things out a
% little more
\setlength\columnsep{25pt}

% Put text lines a little closer together
\renewcommand{\baselinestretch}{.9}

% And a mild indentation
\setlength\parindent{8pt}


% Change enumerate item spacing, and declare default enumerate label.
\setlist[enumerate]{itemsep=4pt, parsep=0pt, label=$($\alph*$)$}

% block quote environment
\AtBeginEnvironment{quote}{\small}

% Make headers
\newcommand{\makeheaders}{
  \pagestyle{fancy}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhf{}
  \lhead{\thepage}
  \chead{\scshape Forest Kobayashi, Evan Liang}
  \rhead{}
  \setlength{\headheight}{15.2pt}
  \setlength{\headsep}{10pt}
}


\def\paper@title{}
\def\paper@author{}
\def\paper@author@affiliation{}
% \def\paper@author@altaffiliation{}

\renewcommand{\title}[1]{\def\paper@title{#1}}
\renewcommand{\author}[1]{\def\paper@author{#1}}
\newcommand{\affiliation}[1]{\def\paper@author@affiliation{#1}}


\newcommand{\makepapertitle}{
  \thispagestyle{empty}
  \begin{center}
    \uppercase{\paper@title}

    {\scshape \small \paper@author}

    \vspace{-.3cm}
    {\footnotesize \paper@author@affiliation}
  \end{center}
}

\newcommand{\makecover}{
  \AtBeginDocument{\makepapertitle}
}



% ================================================================== %
%                                                                    %
%                          Control Sequences                         %
%                                                                    %
% ================================================================== %


% ------------------------ Creature Comforts ----------------------- %

% For referencing labeled equations w/ number in parens
\let\oldref\ref
\renewcommand{\ref}[1]{\textup{(\oldref{#1})}}

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
%                          Misc. Formattings                         %
%                                                                    %
% ================================================================== %

% Let align environments overflow page breaks
\allowdisplaybreaks

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\makecover{}
\makeheaders{}

\endinput
