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
\newcommand{\by}{\times}

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
\newcommand{\mrm}[1]{\mathrm{#1}}
\newcommand{\mc}[1]{\mathcal{#1}}
\newcommand{\mb}[1]{\mathbf{#1}}

% Commands to avoid exiting math mode
\newcommand{\st}{\mrm{\ st\ }}
\newcommand{\contra}{\Rightarrow\Leftarrow}
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
  \ensuremath\sum_{n=#1}^{\infty}
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

% ================================================================== %
%                                                                    %
%                          BEGIN COVERSHEET!                         %
%                                                                    %
% ================================================================== %

%% coverblock command thing used to create a cover sheet for psets.
%% Based on a class file written by Aaron Bagheri to replicate
%% Shahriari Shahriar's homework cover sheet. Modified by Forest
%% Kobayashi to make `agstract.cls`, on which `pset.cls` was based.


% internal state for coverblock
\def\pset@name{}
\def\pset@class{}
\def\pset@prof{}
\def\pset@assignment{}
\def\pset@duedate{}
\def\pset@dueday{}
\def\pset@acknowledgements{}
\def\pset@onTime{}
\def\pset@season{}
\def\pset@comments{}

% Commands to set header block info
\newcommand{\name}[1]{\def\pset@name{#1}}
\newcommand{\class}[1]{\def\pset@class{#1}}
\newcommand{\prof}[1]{\def\pset@prof{#1}}
\newcommand{\assignment}[1]{\def\pset@assignment{#1}}
\newcommand{\duedate}[1]{\def\pset@duedate{#1}}
\newcommand{\dueday}[1]{\def\pset@dueday{#1}}
\newcommand{\problems}[1]{\def\pset@problems{#1}
  \forcsvlist{\saveitem}{#1}\forcsvlist{\listadd\mylist}{#1}}
\newcommand{\acknowledgements}[1]{\def\pset@acknowledgements{#1}
  \forcsvlist{\othersaveitem}{#1}}
\newcommand{\onTime}[1]{\def\pset@onTime{#1}}
\newcommand{\season}[1]{\def\pset@season{#1}}
\newcommand{\comments}[1]{\def\pset@comments{#1}}

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
    \draw[very thick] (4.6,2.6) ellipse (1cm and 0.5cm);
  \end{tikzpicture}
}

\def\circleTuesday{
  \begin{tikzpicture}[remember picture,overlay]
    \draw[very thick] (6.4,2.6) ellipse (1cm and 0.5cm);
  \end{tikzpicture}
}
\def\circleWednesday{
  \begin{tikzpicture}[remember picture,overlay]
    \draw[very thick] (8.25,2.6) ellipse (1.04cm and 0.52cm);
  \end{tikzpicture}
}
\def\circleThursday{
  \begin{tikzpicture}[remember picture,overlay]
    \draw[very thick] (10.15,2.6) ellipse (1.04cm and 0.52cm);
  \end{tikzpicture}
}
\def\circleFriday{
  \begin{tikzpicture}[remember picture,overlay]
    \draw[very thick] (11.8,2.6) ellipse (1.04cm and 0.52cm);
  \end{tikzpicture}
}

\def\drawX{
  \begin{tikzpicture}
    \draw[very thick] (-.25,.25) -- (.25,-.25);
    \draw[very thick] (-.25,-.25) -- (.25,.25);
  \end{tikzpicture}
}

% Define a counter to iterate through the lists passed by the user,
% and redefine \do to put each entry of the list into the row
% properly.
\newcounter{prob}
\renewcommand*{\do}[1]{\stepcounter{prob}
  \getProblem{\number\value{prob}} &&
  \raisebox{-.5em}{\getAck{\number\value{prob}}} \\[1em] \hline}

\newcommand{\coverblock}{%
  \thispagestyle{empty}
  \newgeometry{left=1.5in,right=1.5in,top=1.5in}

  \begin{center}
    \Huge \textbf{\pset@class, \pset@season\ \the\year}


    \LARGE \textbf{Prof: \pset@prof}
  \end{center}

  \vspace{1.4cm}

  \begin{center}
    \begin{tabular}{m{2cm} b{8cm}}
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
      \dolistloop{\mylist}
      \textbf{Total} & & \\[1em]
      \hline
    \end{tabular}
  \end{center}

  \bigskip

  \noindent This Assignment is (check one): \\
  \begin{tabular}{lll}
    \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{0}}{\drawX}{}}
    On Time
    & \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{1}}{\drawX}{}}
      Late, without deduction
    & \framebox(25,20){\ifthenelse{\equal{\pset@onTime}{2}}{\drawX}{}}
      Late, with deduction
  \end{tabular}

  \vspace{.5cm}

  \pset@comments
  \normalsize
  \restoregeometry
}

\newcommand{\makeheaders}{
  \pagestyle{fancy}
  \fancyhf{}
  \lhead{\pset@name}
  \chead{Homework \#\pset@assignment}
  \rhead{\pset@class\ - \pset@season\ \the\year}
  \rfoot{\thepage\ of \pageref{LastPage}}
}

\DeclareOption{agstract}{

  % ------------------ Agstract-specific commands ------------------ %

  % Also for some other common fields
  \newcommand{\zmod}[1]{\ZZ/ #1 \ZZ}
  \newcommand{\zpmod}[1]{(\zmod{#1}, +)}
  \newcommand{\uzmod}[1]{\pn{\ZZ/#1 \ZZ}^\times}
  \newcommand{\zmmod}[1]{(\uzmod{#1}, \cdot)}

  % The default mod command is trash for some reason
  \renewcommand{\mod}[1]{\ \mrm{mod}\ #1}

  % Agstract letters
  \newcommand{\oo}{\mc{O}}
  \newcommand{\cc}{\mb{C}}
  \newcommand{\zz}{\mb{Z}}
  \newcommand{\nn}{\mb{N}}

  % More tangibly function-flavored agstract objects
  \newcommand{\conj}[2]{#1#2#1^{-1}}
  \newcommand{\fix}{\mrm{fix}}

  % Agstract sets / subgroups
  \newcommand{\orb}{\oo_}
  \newcommand{\orbo}{\oo_\Omega}
  \newcommand{\stab}{\mrm{Stab}}
  \newcommand{\stabg}{\mrm{Stab}}
  \newcommand{\syl}{\mrm{Syl}}
  \newcommand{\sylp}{\mrm{Syl}_p}
  \newcommand{\perm}{\mrm{Perm}}


  % Commutative-flavored things
  \newcommand{\cl}{\mrm{cl}}
  \newcommand{\ctr}[1]{\zz\pn{#1}}
  \newcommand{\ctrg}{\zz(G)}
  \newcommand{\cent}{\cc}
  \newcommand{\cliz}{\cc}
  \newcommand{\centg}{\cc_G}
  \newcommand{\nliz}{\mb{N}}
  \newcommand{\nlizg}{\mb{N}_G}
  \newcommand{\nrm}{\triangleleft}

  % Homomoprhic things
  % N.B. \Im gives a hebrew (?) letter
  \newcommand{\im}{\text{Im}}

  % RINGS!
  \newcommand{\ring}[2][]{\pn[#1]{#2, +, \cdot}}
  \newcommand{\uring}[2][]{\pn[#1]{\pn[#1]{#2}^{\times}, +, \cdot}}
  \newcommand{\zjoin}[2][]{\ZZ\bk[#1]{#2}} % optional size parameter
  \newcommand{\qjoin}[2][]{\QQ\bk[#1]{#2}}
  \newcommand{\matring}[2]{M_{#1}\pn{#2}}
  \newcommand{\cring}[4][]{\pn[#1]{#2, #3, #4}}

  \newcommand{\units}[2][]{\pn[#1]{#2^\times}}

  % GROUPS!
  \newcommand{\pgroup}[2][]{\pn[#1]{#2, +}}
  \newcommand{\mgroup}[2][]{\pn[#1]{#2, \cdot}}
  \newcommand{\cgroup}[3][]{\pn[#1]{#2, #3}}

  \newcommand{\PSL}{\mrm{PSL}}
  \newcommand{\SL}{\mrm{SL}}
  \newcommand{\GL}{\mrm{GL}}

  \newcommand{\z}[1]{\ZZ_{(#1)}}

  % ================================================================ %
  %                                                                  %
  %                         BEGIN COVERSHEET!                        %
  %                                                                  %
  % ================================================================ %

  %% header block command rewritten to create Shahriar Shahriari's cover
  %% sheet %% written by Aaron Bagheri %% revised by Forest Kobayashi


  % internal state for coverblock
  \def\agstract@name{}
  \def\agstract@number{}
  \def\agstract@assignment{}
  \def\agstract@duedate{} % Actual date that it's due
  \def\agstract@dueday{} % Which day to circle
  \def\agstract@problems{}
  \def\agstract@acknowledgements{}
  \def\agstract@onTime{}

  % Commands to set header block info
  \renewcommand{\name}[1]{\def\agstract@name{#1}}
  \newcommand{\orderedNumber}[1]{\def\agstract@number{#1}}
  \renewcommand{\assignment}[1]{\def\agstract@assignment{#1}}
  \renewcommand{\duedate}[1]{\def\agstract@duedate{#1}}
  \renewcommand{\dueday}[1]{\def\agstract@dueday{#1}}
  \renewcommand{\problems}[1]{\def\agstract@problems{#1}
    \forcsvlist{\saveitem}{#1}\forcsvlist{\listadd\mylist}{#1}}
  \renewcommand{\acknowledgements}[1]{\def\agstract@acknowledgements{#1}
    \forcsvlist{\othersaveitem}{#1}}
  \renewcommand{\onTime}[1]{\def\agstract@onTime{#1}}

  % So that we can iterate through problems to fill the coversheet table
  \setcounter{problemCounter}{0}

  \def\saveitem#1{%
    \stepcounter{problemCounter}%
    \expandafter\def\csname problems\theproblemCounter\endcsname{#1}%
  }

  \def\getProblem#1{\csname problems#1\endcsname}


  % Acknowledgments counter
  \setcounter{ackCounter}{0}

  \def\othersaveitem#1{%
    \stepcounter{ackCounter}%
    \expandafter\def\csname acks\theackCounter\endcsname{#1}%
  }

  \def\getAck#1{\csname acks#1\endcsname}


  % \renewcommand{\readinglist}{\noindent\large\rmfamily{Read Sections
  %     \agstract@reading}}
  \renewcommand{\problemlist}{\large\rmfamily{Homework
      \agstract@assignment\ - \agstract@problems}\\[0.1em]}

  \def\circleMonday{
    \begin{tikzpicture}[remember picture,overlay]
      \draw[very thick] (7.1,1.5) ellipse (1cm and 0.5cm);
    \end{tikzpicture}
  }
  \def\circleWednesday{
    \begin{tikzpicture}[remember picture,overlay]
      \draw[very thick] (9.25,1.5) ellipse (1.04cm and 0.52cm);
    \end{tikzpicture}
  }
  \def\circleFriday{
    \begin{tikzpicture}[remember picture,overlay]
      \draw[very thick] (11.2,1.5) ellipse (1.04cm and 0.52cm);
    \end{tikzpicture}
  }
  \def\drawX{
    \begin{tikzpicture}
      \draw[very thick] (-.25,.25) -- (.25,-.25);
      \draw[very thick] (-.25,-.25) -- (.25,.25);
    \end{tikzpicture}
  }

  \setcounter{prob}{0}
  \renewcommand*{\do}[1]{\stepcounter{prob}
    \getProblem{\number\value{prob}} &&
    \raisebox{-.5em}{\getAck{\number\value{prob}}} \\[1em] \hline}


  \renewcommand{\coverblock}{%
    \thispagestyle{empty}
    \newgeometry{left=1.5in,right=1.5in,top=1.5in}

    \begin{flushright}
      \textbf{Math 171} \hspace{2.8cm} \mbox{} \\
      \textbf{Shahriari} \hspace{2.8cm} \mbox{}
    \end{flushright}

    \vspace{1.4cm}

    \begin{center}
      \begin{tabular}{m{4cm} b{5cm}}
        \textbf{Name:}
        & \textbf{\underline{\large\makebox[5cm]{\agstract@name}}}
        \\[1.5em]
        \vspace*{-2em} \textbf{Ordered Number:}
        & \framebox(35,28){\bf \agstract@number} \\[1em]
        \textbf{HW \#\,:}
        & \textbf{\underline{\makebox[5cm]{\raisebox{.5em}{\large
          \agstract@assignment}}}} \\[1.5em]
        \textbf{Day:}
        & \textbf{Mon.} \hspace{2.5em} \textbf{Wed.} \hspace{2.5em}
          \textbf{Fri.} \\[1.5em]
        \textbf{Date:}
        & \textbf{\underline{\large\makebox[5cm]{\agstract@duedate}}}
      \end{tabular}
    \end{center}


    % Circle the correct day on the cover sheet!
    \ifthenelse{\equal{\agstract@dueday}{Monday}}{\circleMonday}{}
    \ifthenelse{\equal{\agstract@dueday}{monday}}{\circleMonday}{}
    \ifthenelse{\equal{\agstract@dueday}{Wednesday}}{\circleWednesday}{}
    \ifthenelse{\equal{\agstract@dueday}{wednesday}}{\circleWednesday}{}
    \ifthenelse{\equal{\agstract@dueday}{Friday}}{\circleFriday}{}
    \ifthenelse{\equal{\agstract@dueday}{friday}}{\circleFriday}{}

    \vspace{1.1cm}
    \begin{center}
      \begin{tabular}{| >{\centering\arraybackslash}m{1.3cm} |
        >{\centering}m{1.2cm} | >{\centering\arraybackslash}m{9cm} |}
        \hline
        \textbf{No.} & \textbf{Points} & \textbf{Acknowledgments} \\
        \hline
      \end{tabular}
      \begin{tabular}{| >{\centering\arraybackslash}b{1.3cm} |
        >{\centering\arraybackslash}m{1.2cm} |
        >{\centering\arraybackslash}m{9cm} |}
        \hline
        \dolistloop{\mylist}
        \textbf{Total} & & \\[1em]
        \hline
      \end{tabular}
    \end{center}

    \bigskip

    \noindent This Homework is (check one): \\
    \begin{tabular}{lll}
      \framebox(25,20){\ifthenelse{\equal{\agstract@onTime}{0}}{\drawX}{}}
      On Time
      & \framebox(25,20){\ifthenelse{\equal{\agstract@onTime}{1}}{\drawX}{}}
        2 day extension \#1
      & \framebox(25,20){\ifthenelse{\equal{\agstract@onTime}{2}}{\drawX}{}}
        2 day extension \# 2 \\
      \framebox(25,20){\ifthenelse{\equal{\agstract@onTime}{3}}{\drawX}{}}
      2 day extension \#3
      & \framebox(25,20){\ifthenelse{\equal{\agstract@onTime}{4}}{\drawX}{}}
        2 day extension \#4
      & \framebox(25,20){\ifthenelse{\equal{\agstract@onTime}{5}}{\drawX}{}}
        Brownie Point Extension \\
      \framebox(25,20){\ifthenelse{\equal{\agstract@onTime}{6}}{\drawX}{}}
      Late & &
    \end{tabular}

    \restoregeometry
  }

  \renewcommand{\makeheaders}{
    \pagestyle{fancy}
    \fancyhf{}
    \lhead{\agstract@name}
    \chead{Homework \#\agstract@assignment}
    \rhead{Math 171 - Spring \the\year}
    \rfoot{\thepage\ of \pageref{LastPage}}
    % \setlength{\headheight}{15.2pt}
    \setlength{\headsep}{10pt}
  }
}

\newcommand{\makecover}{
  \AtBeginDocument{\coverblock}
  \AtBeginDocument{% insert empty page
    \null
    \thispagestyle{empty}
    \addtocounter{page}{-2}
    \newpage
  }
}


% For classes where profs want names on the back
\DeclareOption{anon}{%
  \renewcommand{\makecover}{%
    \AtEndDocument{\coverblock}%
  }%
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions*


\makecover{}
\makeheaders{}
