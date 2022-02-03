% ================================================================== %
%                                                                    %
%                         Requirement Things                         %
%                                                                    %
% ================================================================== %

\NeedsTeXFormat{LaTeX2e}

% You'll notice none of my class files ever leave v0.01
\ProvidesClass{fknotes}[2018/3/21 v0.01 notes class]

% This class based on the standard book class
\LoadClass{book}



% ================================================================== %
%                                                                    %
%                              Packages                              %
%                                                                    %
% ================================================================== %

% Bigger margins
\RequirePackage[margin=1.5in, tmargin=1.25in]{geometry}

% Non-manual line breaking
\RequirePackage{parskip}

% Better fonts
\RequirePackage{lmodern}

% Make sure we're inputting stuff correctly
\RequirePackage[utf8]{inputenc}

% And in english!
\RequirePackage[english]{babel}


% -------------------------- Prettifying --------------------------- %

% Professional-looking tables in tabular
\RequirePackage{booktabs}

% Fancy headers and footers
\RequirePackage{fancyhdr}

% Adjustable margins as needed
\RequirePackage{changepage}

% ------------------------------ Math ------------------------------ %

% My math macros
\RequirePackage{fkmath}


% --------------------- Figures & Referencing ---------------------- %

% For figures and subfigures
\RequirePackage{float}
\RequirePackage{subcaption}

% For \includegraphics
\RequirePackage{graphicx}

% For linked cross-referencing
\RequirePackage[breaklinks=true,
  bookmarks,
  pdfpagemode=UseOutlines,
  pdfpagelayout=SinglePage,
  colorlinks=true,
  ]{hyperref}

% For ensuring cleveref uses the correct short names when referencing
% lemmas and such
\RequirePackage{aliascnt}

% Better cross-referencing behavior
\RequirePackage[capitalize]{cleveref}

% Make the footnotes stick to the bottom of the page when we have an
% automatic break for big diagrams and such.
\RequirePackage[bottom]{footmisc}

% For making things like ``page _____ of ____''
\RequirePackage{lastpage}


% ------------------------------ Misc ------------------------------ %

% Customized enumerate labeling
\RequirePackage{enumitem}


% ----------------------- Non-core packages ------------------------ %

% IPA for pronunciation guides
\RequirePackage{tipa}

% If using ひらがな / etc.
\RequirePackage{kotex}
\RequirePackage{kana}


% ================================================================== %
%                                                                    %
%                          Control Sequences                         %
%                                                                    %
% ================================================================== %


% ------------------------ Creature Comforts ----------------------- %

% For phonetic pronunciation guide
\newcommand{\ipa}[1]{[\textipa{#1}]}

% For tortoiseshell brackets
\newcommand{\kikko}[1]{\scalerel*{〔}{\left(#1\right)} #1
  \scalerel*{〕}{\left(#1\right)}}

% Noun phrase wrapping. Like the above, but for use in plain-text.
\newcommand{\np}[1]{\hspace{-.55em}〔#1〕\hspace{-.55em}}

% ---------------------------- Theorems ---------------------------- %

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[chapter]

% Need to alias the counters so that cleverref can handle the names
% properly
\newaliascnt{lemma}{theorem}
\newtheorem{lemma}[lemma]{Lemma}
\aliascntresetthe{lemma}
\crefname{lemma}{Lemma}{Lemmas}

\newaliascnt{corollary}{theorem}
\newtheorem{corollary}[corollary]{Corollary}
\aliascntresetthe{corollary}
\crefname{corollary}{Corollary}{Corollarys}


\newaliascnt{proposition}{theorem}
\newtheorem{proposition}[proposition]{Proposition}
\aliascntresetthe{proposition}
\crefname{proposition}{Proposition}{Propositions}


% Not necessary here because it uses its own counter
\newtheorem{conjecture}{Conjecture}


% And so on with definitions!
\newtheoremstyle{lightdefinition}   % name
    {1em}                           % Space above
    {1em}                           % Space below
    {\small\rmfamily}                     % Body font
    {}                              % Indent amount
    {\bfseries}                     % Theorem head font
    {.}                             % Punctuation after theorem head
    {.5em}                          % Space after theorem head
    {}  % Theorem head spec (can be left empty, meaning ‘normal’)

\theoremstyle{lightdefinition}
\newtheorem{fact}{Fact}[chapter]
\newtheorem{definition}{Definition}[chapter]
\newtheorem{commondef}{Common Definition}
\newtheorem{question}{Question}
\newtheorem{problem}{Problem}[chapter]
\newtheorem{example}{Example}[chapter]
\newtheorem{counterexample}[example]{Counterexample}
\newtheorem{attempt}{Attempt}




% \newenvironment{definition}
% {\pushQED{\oldqed}\renewcommand{\qedsymbol}{$\lozenge$}\definitionx}
% {\popQED\enddefinitionx}
% \newenvironment{commondef}
% {\pushQED{\oldqed}\renewcommand{\qedsymbol}{$\lozenge$}\commondefx}
% {\popQED\endcommondefx}
% \newenvironment{fact}
% {\pushQED{\oldqed}\renewcommand{\qedsymbol}{$\lozenge$}\factx}
% {\popQED\endfactx}
% \newenvironment{question}
% {\pushQED{\oldqed}\renewcommand{\qedsymbol}{$\lozenge$}\questionx}
% {\popQED\endquestionx}
% \newenvironment{problem}
% {\pushQED{\oldqed}\renewcommand{\qedsymbol}{$\lozenge$}\problemx}
% {\popQED\endproblemx}
% \newenvironment{example}
% {\pushQED{\oldqed}\renewcommand{\qedsymbol}{$\lozenge$}\examplex}
% {\popQED\endexamplex}
% \newenvironment{counterexample}
% {\pushQED{\oldqed}\renewcommand{\qedsymbol}{$\jiong$}\counterexamplex}
% {\popQED\endcounterexamplex}
% \newenvironment{attempt}
% {\pushQED{\oldqed}\renewcommand{\qedsymbol}{$\lozenge$}\attemptx}
% {\popQED\endattemptx}

\newtheorem*{aside}{Aside}
\newtheorem*{claim}{Claim}
\newtheorem*{note}{Note}
\newtheorem*{notation}{Notation}
\newtheorem*{summary}{Summary}
\newtheorem*{remark}{Remark}

% `Small' proof environment (lemmas and such)
\newenvironment{sproof}[1][Proof]
{\begin{proof}[#1]\renewcommand{\qedsymbol}{$\square$}}
{\popQED\end{proof}}



% ================================================================== %
%                                                                    %
%                             Formatting                             %
%                                                                    %
% ================================================================== %


% -------------------------- Title page --------------------------- %

% internal state for coverblock
\def\fknotes@author{}
\def\fknotes@title{}
\def\fknotes@date{}
\def\fknotes@subtitle{}


% Commands to set header block info
\renewcommand{\author}[1]{\def\fknotes@author{#1}}
\renewcommand{\title}[1]{\def\fknotes@title{#1}}
\newcommand{\subtitle}[1]{\def\fknotes@subtitle{#1}}
\renewcommand{\date}[1]{\def\fknotes@date{#1}}

\renewcommand{\maketitle}{
  \begin{titlepage} % Suppresses headers and footers on the title page

    \centering\scshape

    {\LARGE \fknotes@title\\ }
    \ifthenelse{\equal{\fknotes@subtitle}{}}{}{{\Large
        \fknotes@subtitle \\ }}

    \vfill

    {\Large \fknotes@author\\ }
    \vspace{.5\baselineskip}

    \ifthenelse{\equal{\fknotes@date}{}}{}{{\large \normalfont Date:
        \fknotes@date \\ }}

    {\large \normalfont Last Updated: \today}
    \vspace{1\baselineskip}
  \end{titlepage}
  \setcounter{footnote}{0}%
  \thispagestyle{empty}
  \newpage
  \global\let\maketitle\relax
  \global\let\fknotes@author\@empty
  \global\let\fknotes@date\@empty
  \global\let\fknotes@title\@empty
  \global\let\fknotes@subtitle\@empty
  \global\let\author\relax
  \global\let\date\relax
  \global\let\title\relax
  \global\let\subtitle\relax
}



% ----------------------- Headers 'n Footers ----------------------- %

\pagestyle{fancy}{%
  \fancyhf{} %% Clear all headers and footers.
  \fancyhead[LE]{\textbf{\thepage{}}\hspace{1em}\nouppercase\leftmark}
  \fancyhead[RE]{\chaptername\ \thechapter}
  \fancyhead[LO]{Section \thesection}
  \fancyhead[RO]{\nouppercase\rightmark\hspace{1em}\textbf{\thepage}}
}

%%% Redefine the \chaptermark and \sectionmark commands.  Note that
%%%  this redefinition must occur after setting pagestyle to fancy.
\renewcommand{\chaptermark}[1]{%
  \markboth{#1}{}}
\renewcommand{\sectionmark}[1]{%
  \markright{#1}{}}

\addtolength{\headwidth}{.25\marginparsep}
\addtolength{\headwidth}{.25\marginparwidth}

% For: frontmatter
\fancypagestyle{front}{%
  \fancyhf{} %% Clear all headers and footers.
  \fancyhead[LE]{\textbf{\thepage{}}\hspace{1em}\nouppercase\leftmark}
  \fancyhead[RO]{\nouppercase\rightmark\hspace{1em}\textbf{\thepage}}
}

\fancypagestyle{plain}{%
  \fancyhf{} %% Clear all headers and footers.
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{empty}{%
  \fancyhf{} %% Clear all headers and footers.
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

% Renew frontmatter / mainmatter to use different page styling
\renewcommand{\frontmatter}{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
  \pagestyle{front}}

\renewcommand{\mainmatter}{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}%
  \pagestyle{fancy}}

% ----------------------- Table of contents ------------------------ %

% Include sections
\setcounter{tocdepth}{1}

\renewcommand{\tableofcontents}{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }



% ------------------------------ Misc ------------------------------ %

% Let align environments overflow page breaks
\allowdisplaybreaks

% Set appropriate paragraph indentation
\setlength{\parindent}{1.5em}




\DeclareOption*{\PassOptionsToClass{\CurrentOption}{notes}}
\ProcessOptions\relax

\endinput
