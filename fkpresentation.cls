% ================================================================== %
%                                                                    %
%                         Requirement Things                         %
%                                                                    %
% ================================================================== %

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{fkpresentation}[2019/2/10 v0.01 presentation class]

% This class based on the standard article class
\LoadClass[10pt, t]{beamer}



% ================================================================== %
%                                                                    %
%                              Packages                              %
%                                                                    %
% ================================================================== %

% Make sure we're inputting stuff correctly
\RequirePackage[utf8]{inputenc}

% And in english!
\RequirePackage[english]{babel}

% Ok so turns out that enumitem doesn't play well with beamer, so
% guess that's just busted
% \RequirePackage{fkmath}

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
\usetikzlibrary{decorations} % For underbraces, etc.

% Or plots, etc.
\RequirePackage{pgfplots}
\pgfplotsset{compat=newest}

% ...Which you would probably place in figure environments
\RequirePackage{float}

% Because I've learned my lesson about manual line breaks
\RequirePackage{parskip}

% For better commands
\RequirePackage{xifthen}

% For quasi-legitimate looking tables
\RequirePackage{booktabs}


% -------------------------- Beamer Stuffs ------------------------- %

% For hyperlinking things
\RequirePackage{hyperref}

% A nice font
\RequirePackage{lmodern}

% So that we can redefine the godawful defaults
\RequirePackage{xcolor}

% Tell beamer to use lmodern
\usefonttheme{serif}


% ================================================================== %
%                                                                    %
%                          Misc. Formattings                         %
%                                                                    %
% ================================================================== %

% Let align environments overflow page breaks
\allowdisplaybreaks

% I don't like autoindentation for new paragraphs in proofs
\setlength\parindent{0pt}

\usetheme{Dresden}
\usecolortheme{crane}

% Get rid of yucky navigation bar at the bottom
\beamertemplatenavigationsymbolsempty

% Circles look less professional; put them last.
% Triangles don't look good as the second level; put them first.
% Ball looks bad, so use square for middle level.
\setbeamertemplate{itemize item}[triangle]
\setbeamertemplate{itemize subitem}[square]
\setbeamertemplate{itemize subsubitem}[circle]

% Subtly shrink text size throughout itemize
\setbeamerfont{itemize/enumerate body}{}
\setbeamerfont{itemize/enumerate subbody}{size=\small}
\setbeamerfont{itemize/enumerate subsubbody}{size=\footnotesize}

% Force bibliography items to one line
\setbeamertemplate{bibliography entry title}{}
\setbeamertemplate{bibliography entry location}{}
\setbeamertemplate{bibliography entry note}{}


% TODO: make this into a callable, optional command that fills the
% bottom of the presentation as needed to fit all the logos in.
\logo{
  \makebox[0.975\paperwidth]{%
    \includegraphics[width=1.5cm,keepaspectratio]{seal.png}%
    \hfill%
    \raisebox{-.75em}{
    \includegraphics[width=1.25cm,keepaspectratio=true]{logo.png}}%
  ~
  % ~
  % ~
  }%
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

\endinput
