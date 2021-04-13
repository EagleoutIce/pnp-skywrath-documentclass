%% Version: 1.0
%% Author:  Florian Sihler, 18.08.2020
%% This LaTeX2e documentclass is based on the pnp-guide layout of lilly and the
%% standalone version which will be developed in the future
%% Development notes:
%%    All internal commands and registers will be prefixed with 'pnpsw@
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pnp-skywrath}[2020/18/08 EagleoutIce - pnp-skywrath documentclass]

%% Options
\ProcessOptions\relax

%% lengths
\AtBeginDocument{%
\parskip=1.5ex \@plus .75ex \@minus .5ex\relax
\parindent\z@
\setlength{\skip\footins}{.75cm} \footnotesep=2mm\relax
}

%% documentclass
\LoadClass[a4paper,11pt,titlepage=firstiscover,numbers=noenddot]{scrartcl}

%% Required packages
% encoding
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
% beautify & layout
\RequirePackage{lmodern,microtype,enumitem,multicol,relsize,amssymb,lastpage}
\RequirePackage[automark]{scrlayer-scrpage}
\RequirePackage[many]{tcolorbox}
% general
\RequirePackage[all]{nowidow}
\RequirePackage[hidelinks]{hyperref}
% toc
\RequirePackage{tocloft,titlesec}
% layout
\RequirePackage[a4paper,total={170mm,257mm},centering,left=20mm,top=20mm]{geometry}

%% colors
\definecolor{MudWhite}{RGB}{245,245,243}
\definecolor{Charcoal}{RGB}{54,69,79}
\definecolor{cprimary}{RGB}{195,33,72}

%% fonts
\RequirePackage{XCharter,miama}
\RequirePackage[charter]{mathdesign}

\def\SetDecoFont#1{\gdef\@decoFont##1{#1{##1}}}
\SetDecoFont{\fmmfamily}

\def\decoFont#1{\begingroup\@decoFont{#1}\endgroup}

\setcounter{tocdepth}{2}

%% style enumerations
\setlist[]{labelindent=.75em}

\setlist[description]{font=\mdseries\rmfamily\itshape,labelindent=0pt}
\setlist[itemize,1]{label={\textcolor{cprimary!40!white}{$\blacktriangleright$}}}
\setlist[itemize,2]{label={\textcolor{cprimary!40!white}{\smaller[2]\raisebox{2pt}{$\blacksquare$}}}}
\setlist[itemize,3]{label={\textcolor{cprimary!40!white}{\raisebox{1.45pt}{\textendash}}}}
\setlist[itemize,4]{label={\textcolor{cprimary}{\smaller[1]\raisebox{.25pt}{*}}}}

\def\pnpsw@enum@font#1{{\itshape#1.}}
\setlist[enumerate,1]{label={\pnpsw@enum@font{\arabic*}}}
\setlist[enumerate,2]{label={\pnpsw@enum@font{\roman*}}}
\setlist[enumerate,3]{label={\pnpsw@enum@font{\alph*}}}
\setlist[enumerate,4]{label={\pnpsw@enum@font{\Roman*}}}

%% style the table of contents
\def\pnpsw@cftdotfill#1{%
    \def\@tempa{#1}\def\@tempb{\cftnodots}%
    \ifx\@tempa\@tempb \hfill\else \leaders\hbox{$\m@th\mkern #1 mu\hbox{\tiny\cftdot}\mkern #1 mu$}\hfill\fi%
}

\def\cftsubsecfont{\footnotesize}
\def\cftsubsecleader{{\pnpsw@cftdotfill{\cftsecdotsep}}}
\def\cftsubsecpagefont{\scriptsize}
\def\cftsubsecnumwidth{1.45em}
\cftbeforesecskip=2.3pt

\def\pnpsw@@section{section}\def\pnpsw@@subsection{subsection}%
\def\pnpsw@@paragraph{paragraph}

\DeclareRobustCommand{\sectionlinesformat}[4]{%
\def\temp@@a{#1}\noindent\phantomsection\ifx\temp@@a\pnpsw@@paragraph\relax #4\else{{\smaller #3}\, #4}\fi%
}

\DeclareRobustCommand{\@seccntformat}[1]{%
  \def\temp@@a{#1}%
  \ifx\temp@@a\pnpsw@@section%
  	\textcolor{cprimary}{\thesection}%
  \else\ifx\temp@@a\pnpsw@@subsection%
    \textcolor{cprimary}{\thesection.\arabic{#1}}%
    \else\textcolor{cprimary}{\thesubsection.\arabic{#1}}\fi%
  \fi%
}

\renewcommand{\section}{\@startsection{section}{1}{\z@}
{-4ex \@plus -1ex \@minus -.4ex}{1ex \@plus.2ex \@minus .1ex}
{\normalfont\Large\bfseries}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}
{-3ex \@plus -0.1ex \@minus -.4ex}{0.25ex \@plus.2ex \@minus .1ex}
{\normalfont\normalsize\bfseries}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}
{-2ex \@plus -0.1ex \@minus -.2ex}{.2ex \@plus.2ex \@minus .1ex}
{\normalfont\itshape}}
\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}
{-2.5ex \@plus-.2ex \@minus .2ex}{.1ex \@minus .5ex}
{\normalfont\itshape \raisebox{.91pt}{$\color{cprimary}\blacktriangleright$}~}}

\renewcommand{\contentsname}{}%
\AtBeginDocument{\@ifundefined{addto}{}{%
\addto\captionsngerman{%
        \renewcommand{\contentsname}{}%
}\addto\captionsenglish{%
\renewcommand{\contentsname}{}%
}}}

%% basic style
\def\pnpsw@rightmark{}
\def\SetStyle{%
	\pagenumbering{arabic}%
	\pagestyle{scrheadings}%
	\clearscrheadfoot%
	\ofoot{\textbf{\thepage}/\footnotesize{\pageref*{LastPage}}}%
	\lofoot{\footnotesize{\thesection.~\pnpsw@rightmark}}%
	\addtocontents{toc}{\protect\thispagestyle{scrheadings}}%
}

%% Check Markers:
\renewcommand\sectionmark[1]{%
    \markright{#1}\def\pnpsw@rightmark{#1}%
}

%% we have no header. (there is a koma-option for that, but its not that 'reliable')
\setheadsepline{0pt}

%% Set Hooks for the Beginning of the Document:
%% We will reset the Geometry-Layout to achieve a more beautiful Page-Layout:
\AtBeginDocument{\SetStyle}

% footnotes:
\def\thefootnote{$\langle\arabic{footnote}\rangle$}
\def\thempfootnote{$\langle\roman{mpfootnote}\rangle$}

%% title layout
\tcbset{%
  pnpsw@tocstyle/.style={%
    colback=MudWhite!5,boxrule=1pt,
    enhanced jigsaw,breakable=true,
    opacityback=.9,arc is angular=5mm,
    fuzzy halo=.1mm with MudWhite,top=0.1mm,
    bottom=.11mm,colframe=Charcoal%
  }
}

\def\toctitle#1{\gdef\pnpsw@toctitle{#1}} \toctitle{Kurzübersicht}
\def\TableOfContents{%
\begingroup%
\begin{center}
	\hypersetup{linkcolor=black}%
	\begin{tcolorbox}[pnpsw@tocstyle,bottom=5.6pt]
		\leavevmode\\\noindent{\Large{\pnpsw@toctitle}}\hfill\\[-1.5\baselineskip]
		\setlength\columnsep{25pt}\begin{multicols}{2}
		\tableofcontents
		\end{multicols}
    \end{tcolorbox}
\end{center}
\endgroup%
}

\def\pnpsw@title{}
\def\pnpsw@subtitle{}
\def\pnpsw@author{}

% overwrites defaults
\def\title#1{\gdef\pnpsw@title{#1}}
\def\subtitle#1{\gdef\pnpsw@subtitle{#1}}
\def\author#1{\gdef\pnpsw@author{#1}}

\def\maketitle{%
	\leavevmode{\begin{minipage}{\linewidth}
		\begin{center}
			{\fontsize{50}{50}\selectfont\decoFont{\pnpsw@title}}\\
			\large\pnpsw@subtitle\bigskip\\
		\end{center}
	\end{minipage}}\\
}

\renewenvironment{abstract}[1][Abstract]{%
    \leavevmode\begin{minipage}{\linewidth}\textbf{#1}%
        \smallskip\newline\itshape\ignorespaces%
}{\end{minipage}}
\endinput