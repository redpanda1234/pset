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

% \let\theorem\undefined
% \let\c@theorem\undefined

% \let\lemma\undefined
% \let\c@lemma\undefined

% \let\corollary\undefined
% \let\c@corollary\undefined

% \let\definition\undefined
% \let\c@definition\undefined

% \let\note\undefined
% \let\c@note\undefined

% \let\example\undefined
% \let\c@example\undefined

% Math
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
% \RequirePackage{lmodern}

% So that we can redefine the godawful defaults
\RequirePackage{xcolor}

% FIXME: is this even used?
% \RequirePackage{textpos}

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

% Make the colors look halfway passable, at least for now.
% \definecolor{lgray}{RGB}{230, 230, 230}
% \definecolor{tgray}{RGB}{70, 70, 70}
% \definecolor{red}{RGB}{200, 0, 0}
% \mode<presentation> {

  % \setbeamercolor*{palette secondary}{use=structure,fg=tgray,bg=lgray}
  % \setbeamercolor*{palette tertiary}{use=structure,fg=lgray,bg=tgray}
  % \setbeamercolor*{normal text}{fg=darkgray}
  % \setbeamercolor*{frametitle}{fg=black}
  % \setbeamercolor*{title}{fg=black}
  % \setbeamercolor*{itemize item}{fg=black}
  % \setbeamercolor*{itemize subitem}{fg=black}
  % \setbeamerfont*{section in head/foot}{size=\scriptsize}
  % \setbeamerfont*{subsection in head/foot}{size=\scriptsize}
% }

% Get rid of yucky navigation bar at the bottom
\beamertemplatenavigationsymbolsempty

% TODO: make this into a callable, optional command that fills the
% bottom of the presentation as needed to fit all the logos in.
\logo{%
  \makebox[0.95\paperwidth]{%
    \includegraphics[width=1.5cm,keepaspectratio]{seal.png}%
    \hfill%
    \raisebox{-.75em}{
    \includegraphics[width=1.25cm,keepaspectratio=true]{logo.png}}%
  ~
  ~
  ~
  }%
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

\endinput
