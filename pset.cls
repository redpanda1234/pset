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

% Problem and reading set lists, for top of document
\RequirePackage{etoolbox}

% For most of the math symbols, and nice things like align
% environment
\RequirePackage{amsmath, amssymb, amsthm}

% For `\shortintertext{}` and other things.
\RequirePackage{mathtools}

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

% For bold math things
\RequirePackage{bm}

% For leftbar environment (useful in proving lemmas, etc)
\RequirePackage{mdframed}

% For margin modification in subsections
\RequirePackage{changepage}

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
\let\oldqed\qed
\renewcommand{\qed}{\hfill $\blacksquare$}

% Finally, enumerate formatting
\setenumerate[0]{label=$($\alph*$)$}

% Is this even necessary?
\newcommand{\by}{\ensuremath{\times}}

% Check if command exists
\newcommand{\checkfor}[1]{%
  \ifcsname#1\endcsname%
    Command \texttt{\textbackslash#1} is defined already. Choose
    another macro!
  \else%
    Command \texttt{\textbackslash#1} is not defined yet. Go ahead!
  \fi%
}

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
\newdelimcommand{bras}{\langle}{\rvert}
\newdelimcommand{kets}{\lvert}{\rangle}
\newdelimcommand{floors}{\lfloor}{\rfloor}
\newdelimcommand{ceils}{\lceil}{\rceil}

% semantically named delimiters
\newcommand{\set}{\braces}
\newcommand{\abs}{\verts}
\newcommand{\norm}{\Verts}
\newcommand{\pn}{\parens}
\newcommand{\ip}{\angles}
\newcommand{\bk}{\brackets}
\newcommand{\bra}{\bras}
\newcommand{\ket}{\kets}
\newcommand{\floor}{\floors}
\newcommand{\ceil}{\ceils}


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

% Span
\newcommand{\vspan}[1]{
  \ensuremath{\mathrm{span}\pn{#1}}
}

% Expected value
\newcommand{\EE}{\mathbb{E}}

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

% For augmented matrices
\newenvironment{amatrix}[1]{%
  \left[\begin{array}{@{}*{#1}{c}|c@{}}
}{%
  \end{array}\right]
}


% Upper and lower sums, under various schemes of integration.
\def\upint{\mathchoice%
    {\mkern13mu\overline{\vphantom{\intop}\mkern7mu}\mkern-20mu}%
    {\mkern7mu\overline{\vphantom{\intop}\mkern7mu}\mkern-14mu}%
    {\mkern7mu\overline{\vphantom{\intop}\mkern7mu}\mkern-14mu}%
    {\mkern7mu\overline{\vphantom{\intop}\mkern7mu}\mkern-14mu}%
  \int}
\def\lowint{\mkern3mu\underline{\vphantom{\intop}\mkern7mu}\mkern-10mu\int}

% Category theory stuff?
\newcommand{\dom}{\mrm{dom}}
\newcommand{\cod}{\mrm{cod}}
\newcommand{\ob}{\mrm{ob}}
\newcommand{\homm}{\mrm{hom}}
\newcommand{\id}{\mrm{\id}}

% Overline, more tersely
\newcommand{\ol}[1]{\overline{#1}}

% \newtheorem{theorem}{Theorem}[section]
% \newtheorem{corollary}{Corollary}[theorem] % Reset counter w new thm
% \newtheorem{lemma}[theorem]{Lemma} % Same counter as thm
% \theoremstyle{definition}
% \newtheorem{definition}{Definition}[section]
% \newtheorem{example}{Example}[definition]

% leftbar --> useful environment for proving lemmas and the like
\newmdenv[
  skipabove=5,
  skipbelow=5,
  innerleftmargin = 1em,
  innertopmargin = .5em,
  innerbottommargin = .5em,
  innerrightmargin = 0pt,
  rightmargin = 0pt,
  leftmargin = 1em,
  linewidth = 2pt,
  topline = false,
  rightline = false,
  bottomline = false
  ]{leftbar}

\newmdtheoremenv[
  leftline=false,
  rightline=false,
  skipabove=10,
  linewidth=.8pt,
  linecolor=gray!50,
  backgroundcolor=gray!10,
  innertopmargin=\topskip,
  splittopskip=\topskip,
  ntheorem=true,
  ]{theorem}{\scshape Theorem}[section]

\mdfdefinestyle{theoremstyle}{%
  leftmargin=2em,
  rightmargin=2em,
  skipabove=10,
  skipbelow=10,
  linecolor=black!90,
  linewidth=1pt,
  frametitlerule=true,
  frametitlebackgroundcolor=gray!20,
  innertopmargin=.75\topskip,
  innerbottommargin=.75\topskip,
}

\mdtheorem[style=theoremstyle]{definition}{Definition}

% \titleformat{\chapter}[display]
%   {\normalfont\sffamily\huge\bfseries\color{blue}}
%   {\chaptertitlename\ \thechapter}{20pt}{\Huge}
% \titleformat{\section}
%   {\normalfont\sffamily\Large\bfseries\color{cyan}}
%   {\thesection}{1em}{}

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

% And shorten the vspace after section headers. How to read?
%
%                {12pt plus 4pt minus 2pt}
%
%  - 12pt is what we would like the spacing to be
%  - plus 4pt means that TeX can stretch it by at most 4pt
%  - minus 2pt means that TeX can shrink it by at most 2pt

\titlespacing*{\section}{0pt}{\parskip}{-\parskip}
\titlespacing*{\subsection}{0pt}{\parskip}{-\parskip}
\titlespacing*{\subsubsection}{0pt}{\parskip}{-\parskip}

\newcommand{\makeheaders}{}
\newcommand{\makecover}{}

\newboolean{agstract}
\newboolean{load189}
\newboolean{cover}
\newboolean{scipaper}


\DeclareOption{agstract}{
  \setboolean{agstract}{true}
}

\DeclareOption{189}{
  \setboolean{load189}{true}
}

\DeclareOption{cover}{
  \setboolean{cover}{true}
}

\DeclareOption{nocover}{
  \setboolean{cover}{false}
}

\DeclareOption{scipaper}{
  \setboolean{scipaper}{true}
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

\ifthenelse{\boolean{load189}}{
  \RequirePackage{189}}{}

\ifthenelse{\boolean{agstract}}{
  \RequirePackage{agstract}}{}

\ifthenelse{\boolean{scipaper}}{
  \RequirePackage{paper}}{}

\makecover{}
\makeheaders{}

\endinput
