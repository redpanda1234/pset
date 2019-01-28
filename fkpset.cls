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

% Add a color package for color manipulations.
\RequirePackage{xcolor}

% For more bearable referencing
\RequirePackage{fancyref}

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
\RequirePackage[alsoload=astro, alsoload=hep]{siunitx}

% Problem environment
\newenvironment{problem}[1][Problem \thesection.]
{\noindent\begin{center}\begin{boxedminipage}{.95\linewidth}\textbf{#1.}}
{\end{boxedminipage}\end{center}}

\newenvironment{solution}[1][Solution.]
{\noindent\begin{center}\begin{adjustwidth}{.05\linewidth}{.05\linewidth}\emph{#1}\ }
{\qed\end{adjustwidth}\end{center}}

% ================================================================== %
%                                                                    %
%                          Misc. Formattings                         %
%                                                                    %
% ================================================================== %

% We want to let align environments overflow page breaks
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

\titlespacing*{\section}{0pt}{\parskip}{0pt}
\titlespacing*{\subsection}{0pt}{\parskip}{-\parskip}
\titlespacing*{\subsubsection}{0pt}{\parskip}{-\parskip}

\newcommand{\trule}{\vspace{-.5\baselineskip}%
  \rule{\textwidth}{1pt}\vspace*{-\baselineskip}\vspace*{2pt}
  \rule{\textwidth}{0.4pt}}

\newcommand{\brule}{\vspace{.125\baselineskip}
  \rule{\textwidth}{0.4pt}\vspace*{-\baselineskip}\vspace*{2.4pt}
  \rule{\textwidth}{1pt}}

\renewcommand\headrule{
\begin{minipage}{1\textwidth}
  \trule
\end{minipage}}%

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


% Commands to set header block info
\newcommand{\name}[1]{\def\fkpset@name{#1}}
\newcommand{\class}[1]{\def\fkpset@class{#1}}
\newcommand{\duedate}[1]{\def\fkpset@duedate{#1}}
\newcommand{\assignment}[1]{\def\fkpset@assignment{#1}}
% \newcommand{\problems}[1]{\def\pset@problems{#1}
%   \forcsvlist{\saveitem}{#1}\forcsvlist{\listadd\mylist}{#1}}

% So that we can iterate through problems to fill the coversheet table
% \newcounter{problemCounter}

% This stores each problem as a new command sequence,
% `\problems<problem_name>`. This allows us to get each problem back
% out easily, e.g. typesetting problem `10.3.1` is as easy as
% `\problems10.3.1`. This is inelegant, but it works.
% \def\saveitem#1{%
%   \stepcounter{problemCounter}%
%   \expandafter\def\csname problems\theproblemCounter\endcsname{#1}%
% }

% \def\getProblem#1{\csname problems#1\endcsname}

% \newcommand{\blanklist}{}

% \newcommand*{\putintable}[1]{%
%   \appto\mylist{#1 &}%
%   \listadd{\blanklist}{c}%
% }

% %Define a wrapper
% \newcommand{\fakedolistloop}[1]{%
%   \forlistloop{\putintable}{#1}%
% }

% \newcommand{\fakerdolistloop}[1]{%
%   \forlistloop{&}{#1}
% }

% \newcommand{\fakestdolistloop}[1]{%
%   \forlistloop{\appto\blanklist{#1}}{#1}
% }

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

% \newcommand{\pointstable}{
  % Shift the table upwards
  % \vspace{-2.3cm}

  % Create the table object _here_
  % \begin{table}
    % \centering
    % \begin{tabular}{@{}lcr@{}} % booktabs points table
        % \toprule
        % Problem & \fakedolistloop{\mylist} Total \\ \midrule
        % Points  & \fakerdolistloop{\mylist}  \\ \bottomrule
    % \end{tabular}
  % \end{table}
  % \vspace{2.3cm}
% }

\AtBeginDocument{\rblock}
% \AtBeginDocument{\pointstable}

\endinput
