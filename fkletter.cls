% ================================================================== %
%                                                                    %
%                         Requirement Things                         %
%                                                                    %
% ================================================================== %

\NeedsTeXFormat{LaTeX2e}

% This class is mainly for summer applications and other things. For
% the most part, formatting follows that of my standard class, but I
% figured it was worth making a standalone .cls file so that I don't
% have to hack a bunch of things with class options, and/or
\ProvidesClass{letter}[2018/3/21 v0.01 letter class]

% This class based on the standard article class
\LoadClass{article}



% ================================================================== %
%                                                                    %
%                              Packages                              %
%                                                                    %
% ================================================================== %

% Sensible margins
\RequirePackage[margin=1in]{geometry}

% Better fonts
\RequirePackage{lmodern}

% Make sure we're inputting stuff correctly
\RequirePackage[utf8]{inputenc}

%
\RequirePackage[T1]{fontenc}

% And in english!
\RequirePackage[english]{babel}

% I've offloaded my math macros into a separate package (in this repo)
\RequirePackage{fkmath}

% Fancy page header
\RequirePackage{fancyhdr}

% Because I've learned my lesson about manual line breaks
\RequirePackage{parskip}

% For customizing the enumerate environment
\RequirePackage{enumitem}

% So that the whitespace around section headers can be made less
% obnoxiously large
\RequirePackage{titlesec}

% Add a color package for color manipulations.
\RequirePackage{xcolor}

% For more bearable referencing
\RequirePackage{fancyref}

% For urls and stuff
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  urlcolor=blue
}

% ================================================================== %
%                                                                    %
%                          Control Sequences                         %
%                                                                    %
% ================================================================== %


% ------------------------ Creature Comforts ----------------------- %

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

% We want to let align environments overflow page breaks
\allowdisplaybreaks


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\endinput
