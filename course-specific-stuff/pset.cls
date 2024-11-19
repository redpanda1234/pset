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
% \RequirePackage[alsoload=astro, alsoload=hep]{siunitx}
\RequirePackage{siunitx}

% TODO: Come back and make more robust environments, perhaps with
% framed boxes and things (tbt)
\newenvironment{problem}[1][Problem \thesection.]
{\stepcounter{section}\section*{#1}}
{

  \hrulefill}

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

% \titleformat{\section}
%   {\Large\scshape}{\thesection}{1em}{}


\newcommand{\makeheaders}{}
\newcommand{\makecover}{}

\newboolean{cover}
\newboolean{newcover}

\DeclareOption{cover}{
  \setboolean{cover}{true}
}

\DeclareOption{nocover}{
  \setboolean{cover}{false}
}

% For testing a newer, less-stupid cover
\DeclareOption{newcover}{
  \setboolean{newcover}{true}
  \setboolean{cover}{false}
}

% For classes where profs want names on the back
\DeclareOption{anon}{%
  \renewcommand{\makecover}{%
    \AtEndDocument{\coverblock}%
  }%
}

\ExecuteOptions{cover}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\ifthenelse{\boolean{cover}}{
  \RequirePackage{cover}}{}

\ifthenelse{\boolean{newcover}}{
  \RequirePackage{newcover}}{}

\makecover{}
\makeheaders{}

\endinput
