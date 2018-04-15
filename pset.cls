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

% For better commands
\RequirePackage{xifthen}

% For quasi-legitimate looking tables
\RequirePackage{booktabs}

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

% Is this even necessary?
\newcommand{\by}{\ensuremath{\times}}

% ----------------------- General Math stuff ----------------------- %

% Useful commands for paired delimiters that'll adjust to fit whatever
% argument you pass --> e.g. (<something>), [<something else>]

% I spent quite some time trying to get sizes to be optional arguments
% that I could pass to the commands below, before discovering (to my
% delight) that somebody had done almost this exact same thing before.
% I then gleefully copy-pasted the stuff below, which was much less
% hard-coded than what I had been doing.

% For the source, see https://tex.stackexchange.com/a/1744

% Auto-sized thingies
\let\size@autol\left  \let\size@autor\right \let\size@autom\middle

% Stop expansion if we have the base thingy
\let\size@basel\relax \let\size@baser\relax \let\size@basem\relax

% Sizes
\let\size@bigl\bigl   \let\size@bigr\bigr   \let\size@bigm\big
\let\size@Bigl\Bigl   \let\size@Bigr\Bigr   \let\size@Bigm\Big
\let\size@biggl\biggl \let\size@biggr\biggr \let\size@biggm\bigg
\let\size@Biggl\Biggl \let\size@Biggr\Biggr \let\size@Biggm\Bigg

% idk
\newcommand{\ldelim}{\relax}
\newcommand{\rdelim}{\relax}
\newcommand{\mdelim}{\relax}

% The thing that'll actually implement the command
% #1 size #2 ldelim #3 rdelim #4 content
\newcommand{\size@command}[4]{{%
  \def\ldelim{\csname size@#1l\endcsname}% tack on size to l delim
  \def\rdelim{\csname size@#1r\endcsname}% tack on size to r delim
  \def\mdelim{\csname size@#1m\endcsname}%
  \ldelim#2#4\rdelim#3% put the stuff in between the things
}}

% Define new delimiter commands with ease!
% #1 name #2 ldelim #3 rdelim
\newcommand{\newdelimcommand}[3]{%
  \expandafter\newcommand\csname size@#1@st\endcsname[1]{%
    \size@command{base}{#2}{#3}{##1}}% ##1 content
  \expandafter\newcommand\csname size@#1@ns\endcsname[2][auto]{%
    % ##1 size ##2 content
    \size@command{##1}{#2}{#3}{##2}}%
  \expandafter\DeclareRobustCommand\csname#1\endcsname{%
    \@ifstar{\csname size@#1@st\endcsname}{\csname size@#1@ns\endcsname}%
  }%
}

% syntactically named delimiters
\newdelimcommand{braces}{\lbrace}{\rbrace}
\newdelimcommand{angles}{\langle}{\rangle}
\newdelimcommand{verts}{\lvert}{\rvert}
\newdelimcommand{Verts}{\lVert}{\rVert}
\newdelimcommand{brackets}{[}{]}
\newdelimcommand{parens}{(}{)}

% semantically named delimiters
\newcommand{\set}{\braces}
\newcommand{\abs}{\verts}
\newcommand{\norm}{\Verts}
\newcommand{\pn}{\parens}
\newcommand{\ip}{\angles}
\newcommand{\bk}{\brackets}

% Automagic `such that' for set comprehension. Inside an automagic
% delimiter command, the vertical bar will resize appropriately
% Example:
%   \set{ x \in W \MID x > 0 }
\newcommand{\MID}{\;\mdelim\vert\;}

% Useful shortcuts for when typing is just too hard
\newcommand{\mrm}[1]{\ensuremath{\mathrm{#1}}}
\newcommand{\mc}[1]{\ensuremath{\mathcal{#1}}}
\newcommand{\mb}[1]{\ensuremath{\mathbf{#1}}}

% Commands to avoid exiting math mode
\newcommand{\st}{\mrm{\ st\ }}
\newcommand{\contra}{\ensuremath{(\Rightarrow\Leftarrow)}}
\DeclareMathOperator{\lub}{lub}
\DeclareMathOperator{\glb}{glb}
\DeclareMathOperator{\lcm}{lcm}

% Useful shortcut commands for common fields
\newcommand{\FF}{\mathbb{F}}
\newcommand{\CC}{\mathbb{C}}
\newcommand{\RR}{\mathbb{R}}
\newcommand{\QQ}{\mathbb{Q}}
\newcommand{\ZZ}{\mathbb{Z}}
\newcommand{\NN}{\mathbb{N}}

% Partial differential
\newcommand{\pdd}{\mathop{}\!\partial}

% Total differential
\newcommand{\dd}{\mathop{}\!\mathrm{d}}

% Define partial derivative and ordinary derivative things
\newcommand{\pd}[3][]{\frac{\pdd^{#1} {#2}}{\pdd {#3}^{#1}}}
\newcommand{\od}[3][]{\frac{\dd^{#1} {#2}}{\dd {#3}^{#1}}}

% Make an infinite sum
\newcommand{\series}[1][0]{
  \sum_{n=#1}^{\infty}
}

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
\setenumerate[0]{label=$($\alph*$)$}

% And shorten the vspace after section headers. How to read?
%
%                {12pt plus 4pt minus 2pt}
%
%  - 12pt is what we would like the spacing to be
%  - plus 4pt means that TeX can stretch it by at most 4pt
%  - minus 2pt means that TeX can shrink it by at most 2pt

\titlespacing{\section}{0pt}{\parskip}{-\parskip}
\titlespacing{\subsection}{0pt}{\parskip}{-\parskip}
\titlespacing{\subsubsection}{0pt}{\parskip}{-\parskip}


\newcommand{\makeheaders}{
  \pagestyle{fancy}
  \fancyhf{}
  \lhead{\pset@name}
  \chead{Homework \#\pset@assignment}
  \rhead{\pset@class\ - \pset@season\ \the\year}
  \rfoot{\thepage\ of \pageref{LastPage}}
  \setlength{\headheight}{15.2pt}
  \setlength{\headsep}{10pt}
}

% For classes where profs want names on the back
\DeclareOption{anon}{%
  \renewcommand{\makecover}{%
    \AtEndDocument{\coverblock}%
  }%
}

\newboolean{agstract}
\newboolean{cover}

\DeclareOption{agstract}{
  \setboolean{agstract}{true}}

\DeclareOption{cover}{
  \setboolean{cover}{true}}

\ExecuteOptions{cover}
\ProcessOptions\relax

\ifthenelse{\boolean{cover}}{
  \RequirePackage{cover}}{}

\ifthenelse{\boolean{agstract}}{
  \RequirePackage{agstract}}{}



\makecover{}
\makeheaders{}
