%% -----------------------------------------------------------------------------
%% Version: 1.0
%% Author:  Florian Sihler, 18.08.2020
%%
%% This LaTeX2e documentclass is based on the pnp-guide layout of lilly and the
%% standalone version which will be developed in the future
%%

%% Development notes:
%%    All internal commands and registers will be prefixed with 'pnpsw@
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pnp-skywrath}[2020/18/08 EagleoutIce - pnp-skywrath documentclass]


%% Options
%% -----------------------------------------------------------------------------

\ProcessOptions\relax%

%% lengths
%% -----------------------------------------------------------------------------

\AtBeginDocument{%
\setlength{\parskip}{1.5ex \@plus 0.75ex \@minus 0.5ex}%
\setlength{\parindent}{0pt}%
\setlength{\skip\footins}{0.75cm}%
\setlength{\footnotesep}{2mm}%
}

%% documentclass
%% -----------------------------------------------------------------------------

\LoadClass[a4paper,11pt,titlepage=firstiscover,numbers=noenddot]{scrartcl}

%% Packages
%% -----------------------------------------------------------------------------

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
%% -----------------------------------------------------------------------------

\definecolor{MudWhite}{RGB}{245,245,243}
\definecolor{Charcoal}{RGB}{54,69,79}
\definecolor{cprimary}{RGB}{195,33,72}

%% fonts
%% -----------------------------------------------------------------------------

\RequirePackage{XCharter,miama}
\RequirePackage[charter]{mathdesign}

\def\decoFont#1{%
    \begingroup\fmmfamily{#1}\endgroup%
}

\setcounter{tocdepth}{2}

%% style enumerations
%% -----------------------------------------------------------------------------

\setlist[]{labelindent=1em}

\setlist[description]{font=\mdseries\itshape}
\setlist[itemize,1]{label={\textcolor{cprimary}{\larger$\triangleright$}}}
\setlist[itemize,2]{label={\textcolor{cprimary}{\smaller[3]\raisebox{2pt}{$\blacksquare$}}}}
\setlist[itemize,3]{label={\textcolor{cprimary}{\raisebox{1.45pt}{\textendash}}}}
\setlist[itemize,4]{label={\textcolor{cprimary}{\smaller[2]\raisebox{1.45pt}{$\circ$}}}}


%% style the table of contents
%% -----------------------------------------------------------------------------

\def\pnpsw@cftdotfill#1{%
    \def\@tempa{#1}\def\@tempb{\cftnodots}%
    \ifx\@tempa\@tempb \hfill\else \leaders\hbox{$\m@th\mkern #1 mu\hbox{\tiny\cftdot}\mkern #1 mu$}\hfill\fi%
}

\def\cftsubsecfont{\footnotesize}
\def\cftsubsecleader{{\pnpsw@cftdotfill{\cftsecdotsep}}}
\def\cftsubsecpagefont{\scriptsize}
\def\cftsubsecnumwidth{1.45em}
\setlength{\cftbeforesecskip}{2.3pt}

\DeclareRobustCommand{\sectionlinesformat}[4]{%
\def\temp@@a{#1}\def\temp@@b{paragraph}\noindent\phantomsection\ifx\temp@@a\temp@@b\relax #4\else{{\smaller #3}\, #4}\fi%
}

\DeclareRobustCommand{\@seccntformat}[1]{%
  \def\temp@@a{#1}%
  \def\temp@@b{section}\def\temp@@c{subsection}%
  \ifx\temp@@a\temp@@b%
  	\textcolor{cprimary}{\thesection}%
  \else\ifx\temp@@a\temp@@c%
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
{-2ex \@plus-.2ex \@minus .2ex}{.1ex \@minus .02ex}
{\normalfont\small\itshape}}

\renewcommand{\contentsname}{}%
\AtBeginDocument{\@ifundefined{addto}{}{%
\addto\captionsngerman{%
        \renewcommand{\contentsname}{}%
}\addto\captionsenglish{%
\renewcommand{\contentsname}{}%
}}}

%% basic style
%% -----------------------------------------------------------------------------
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
\renewcommand{\sectionmark}[1]{%
    \markright{#1}\renewcommand{\pnpsw@rightmark}{#1}%
}

%% we have no header. (there is a koma-option for that, but its not that 'reliable')
\setheadsepline{0pt}

%% Set Hooks for the Beginning of the Document:
%% We will reset the Geometry-Layout to achieve a more beautiful Page-Layout:
\AtBeginDocument{%
    \SetStyle%
}

%% title layout
%% -----------------------------------------------------------------------------

\tcbset{%
  pnpsw@tocstyle/.style={%
    colback=MudWhite!5,boxrule=1pt,
    enhanced jigsaw,breakable=true,
    opacityback=0.9,arc is angular=5mm,
    fuzzy halo=0.1mm with MudWhite,top=0.1mm,
    bottom=0.11mm,colframe=Charcoal%
  }
}

\def\toctitle#1{\gdef\pnpsw@toctitle{#1}} \toctitle{Kurzübersicht}
\def\TableOfContents{%
\bgroup%
\begin{center}
	\hypersetup{linkcolor=black}%
	\begin{tcolorbox}[pnpsw@tocstyle,bottom=5.6pt]
		\leavevmode\\\noindent{\Large{\pnpsw@toctitle}}\hfill\\[-1.5\baselineskip]
		\setlength\columnsep{25pt}\begin{multicols}{2}
		\tableofcontents
		\end{multicols}
    \end{tcolorbox}
\end{center}
\egroup%
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
			\Large\pnpsw@subtitle\bigskip\\
		\end{center}
	\end{minipage}}\\
}

\renewenvironment{abstract}[1][Abstract]{%
    \leavevmode\begin{minipage}{\linewidth}\decoFont{#1}%
        \smallskip\newline\itshape\ignorespaces%
}{\end{minipage}}


\endinput