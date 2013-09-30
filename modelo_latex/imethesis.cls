%% It may be distributed under the terms of the LaTeX Project Public
%% License, as described in lppl.txt in the base LaTeX distribution.
%% Either version 1.0 or, at your option, any later version.
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{imethesis}[20/07/2001 v1.0 Standard LaTeX document class for IME thesis]
%\LoadClass{article}
\RequirePackage[portuges,english]{babel}
% *** Alterado por Leonardo Zão em Nov/2010
% \RequirePackage{epsfig} ????
% ***
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\newif\if@append
\@appendfalse
\newif\if@abrevia
\@abreviafalse
\newif\if@simbo
\@simbofalse
\if@compatibility\else
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\fi
\if@compatibility
  \renewcommand\@ptsize{0}
\else
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility
\else
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\fi
\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\ExecuteOptions{a4paper,12pt,oneside,titlepage,onecolumn,final,openany}
\ProcessOptions
\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\thepage\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}}{}}%
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection. \ %
        \fi
        ##1}}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\dsp{\def\baselinestretch{1.37}\large\normalsize}
%==========================================================
\def\university#1{\gdef\@university{#1}}
\def\thesisapp#1{\gdef\@thesisapp{#1}}
\def\chair#1#2{\gdef\@chair{#1} \gdef\@chairfrom{#2}}
%\def\vicechair#1#2{\gdef\@vicechair{#1} \gdef\@vicechairfrom{#2}}
\def\memberone#1#2{\gdef\@memberone{#1} \gdef\@memberonefrom{#2}}
\def\membertwo#1#2{\gdef\@membertwo{#1} \gdef\@membertwofrom{#2}}
\def\memberthree#1#2{\gdef\@memberthree{#1} \gdef\@memberthreefrom{#2}}
\def\cityear#1#2{\gdef\@cityear{#1\\#2}\gdef\@year{#2}}
\def\abrevauthor#1{\gdef\@abrevauthor{#1}}
\def\cipcode#1{\gdef\@cipcode{#1}}
\def\patente#1{\gdef\@patente{#1}}
%==========================================================
%                  TITLE PAGE
%==========================================================
\if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
 % \null \vfil
 % \vskip 60\p@
  \begin{center}%
    {\normalsize \MakeUppercase{\textbf{\@university}} \par}%
    \vskip 2cm%
    {\normalsize
 %    \lineskip .75em%
      \begin{tabular}[t]{c}%
%        \MakeUppercase{\textbf{\@patente\space\@author}}
      \end{tabular}\par}%
 %   {\MakeUppercase{\@title} \par}%
    \vskip 4cm%
    {\MakeUppercase{\large \textbf{\@title}} \par}%
%    {\MakeUppercase{\fontsize{14}{14} \textbf{Controle Linear a Parâmetros Variáveis}} \par}
%    \vskip 4mm%
%    {\MakeUppercase{\fontsize{14}{14} \textbf{de Sistemas Não-Lineares}} \par}
     \vskip 3cm%
     \parbox{6.0cm}{\ }%
     \parbox{10.5cm}{\@thesisapp}\\[\baselineskip]%
     \parbox{6.0cm}{\ }%
     \parbox{10.5cm}{Orientador: \@chair}\\  
     \parbox{6.0cm}{\ }%
     %\parbox{10cm}{Co-orientador: \@vicechair}\\
     \vfill %
    {\large \@cityear \par}%       % Set year in \large size.
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  %\setcounter{footnote}{0}%%%%%%%%%%%%%%%%%%%%%%%%%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
%  \global\let\@author\@empty
%  \global\let\@date\@empty
%  \global\let\@title\@empty
%  \global\let\title\relax
%  \global\let\author\relax
%  \global\let\date\relax
  \global\let\and\relax
}
\else
\newcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  %\setcounter{footnote}{0}%%%%%%%%%%%%%%%%%%%%%%%%%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
%  \global\let\@author\@empty
%  \global\let\@date\@empty
%  \global\let\@title\@empty
%  \global\let\title\relax
%  \global\let\author\relax
%  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@cityear}%
  \end{center}%
  \par
  \vskip 1.5em}
\fi
%==========================================================
%
%==========================================================
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{3}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\nomecapitulo}
\newcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{plain}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries \nomeparte~\thepart
       \par
       \vskip 20\p@
     \fi
     \Huge \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
                \null
                \thispagestyle{empty}%
                \newpage
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindenttrue
            \dsp
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                \if@append \refstepcounter{section} \else \refstepcounter{chapter} \fi%
                        \typeout{\@chapapp\space\thechapter.}%
                    {
                    \def\\{ }%
                    \if@append
                        \addcontentsline{toc}{section}{\protect\numberline{\thesection\ }\uppercase{\@chapapp \space \@arabic\c@section}:\space#1}
                    \else
                        \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter\ }#1}
                    \fi
                }%
                    \else
                        {\def\\{ }  % allow \\ in title
                \addcontentsline{toc}{chapter}{#1}}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}

\def\@makechapterhead#1{%
%  \vspace*{50\p@}%
    {\parindent \z@ \raggedright \normalfont
        \interlinepenalty\@M
    \if@append 
        \thesection \space \@chapapp \space \@arabic\c@section: \space \MakeUppercase{#1} \par \nobreak% 
    \else 
        \bfseries \thechapter \space \MakeUppercase{#1} \par \nobreak%
    \fi
    \vskip 3\baselineskip
    \dsp
}}

\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}

\def\@makeschapterhead#1{
                 \parindent \z@ 
                         \normalfont
                         \hbox to\textwidth{\bfseries \hfill
                         \MakeUppercase{#1}\hfill}%
                         \nobreak
                         \vskip 20\p@
                 \dsp
                        }

\newcommand\section{\@startsection {section}{1}{\z@}%
                                     {-3.5ex \@plus -1ex \@minus -.2ex}%
                                     {2.3ex \@plus.2ex}%
                                     {\normalfont\MakeUppercase}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\MakeUppercase}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\MakeUppercase}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                     {3.25ex \@plus1ex \@minus.2ex}%
                                     {-1em}%
                                     {\normalfont\normalsize}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                     {3.25ex \@plus1ex \@minus .2ex}%
                                     {-1em}%
                                     {\normalfont\normalsize}}

\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
%  \setlength\leftmargini  {2.5cm}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand{\labelenumi}{\alph{enumi})}
%\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\arabic{enumii})}
%\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}


\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}

\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}

\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
\if@compatibility
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
    }
\else
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\fi
\newcommand\appendix{
  %  \setcounter{chapter}{0}% {\@chapapp\ \@arabic\c@section:}%
    \setcounter{section}{0}%
    \gdef\@chapapp{\nomeapendice}%
    \chapter{\underline{\@chapapp s}}%
    \@appendtrue%
  %     \gdef\thechapter{\@arabic\c@chapter}%
%       \renewcommand \thesection {\thechapter.\@arabic\c@section}%
%       \setcounter{section}{0}{\thesection \@chapapp\ \@arabic\c@section:}%
    \gdef\thechapter{\@arabic\c@chapter}%
    \renewcommand \thesection {\thechapter.\@arabic\c@section}%
}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\nomefigura~\thefigure}
\newenvironment{figure}
               {\ssp\@float{figure}}
               {\end@float\dsp}
\newenvironment{figure*}
               {\ssp\@dblfloat{figure}}
               {\end@dblfloat\dsp}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\nometabela~\thetable}
\newenvironment{table}
               {\ssp\@float{table}}
               {\end@float\dsp}
\newenvironment{table*}
               {\ssp\@dblfloat{table}}
               {\end@dblfloat\dsp}

\newcounter{abreviatura}
\def\ftype@abreviatura{3}
\def\ext@abreviatura{loa}
\def\abrevia#1#2{\addtocontents{loa}{\contentsline {abreviatura}{#2}{#1}}}

\newcounter{simbolo}
\def\ftype@simbolo{4}
\def\ext@simbolo{los}
\def\simbo#1#2{\addtocontents{los}{\contentsline {simbolo}{#2}{#1}}}

%\newcounter{sigla}
%\def\ftype@sigla{5}
%\def\ext@sigla{lon}
%\newcommand{sigla}[2]{ #1\it#2}
\newcommand{\abreviatura}[2]{#1\space(\space#2\space)%
                     \if@abrevia
                        \addtocontents{loa}{\protect\parbox[t]{0.1\textwidth}{#1}%
                                            \protect\parbox[t]{0.05\textwidth}{-}%
                                            \protect\parbox[t]{0.7\textwidth}{#2}%
                                            \protect\\}%
                     \else
                        \@abreviatrue
                        \addtocontents{loa}{\protect\parbox[t]{0.9\textwidth}{\bfseries\MakeUppercase\nomeabreviatura}%
                                            \protect\\[0.5cm]}%                     
                        \addtocontents{loa}{\protect\parbox[t]{0.1\textwidth}{#1}%
                                            \protect\parbox[t]{0.05\textwidth}{-}%
                                            \protect\parbox[t]{0.7\textwidth}{#2}%
                                            \protect\\}%
                     \fi
                    }
\newcommand{\simbolo}[2]{#1%
                     \if@simbo
                        \addtocontents{los}{\protect\parbox[t]{0.1\textwidth}{#1}%
                                            \protect\parbox[t]{0.05\textwidth}{-}%
                                            \protect\parbox[t]{0.7\textwidth}{#2}%
                                            \protect\\}%
                     \else
                        \@simbotrue
                        \addtocontents{los}{\protect\\
                                            \protect\parbox[t]{0.9\textwidth}{\bfseries\MakeUppercase\nomesimbolo}%
                                            \protect\\[0.5cm]}%                     
                        \addtocontents{los}{\protect\parbox[t]{0.1\textwidth}{#1}%
                                            \protect\parbox[t]{0.05\textwidth}{-}%
                                            \protect\parbox[t]{0.7\textwidth}{#2}%
                                            \protect\\}%
                     \fi
                    }


%\def\sigla#1#2{\addtocontents{lon}{\contentsline {sigla}{#2}{#1}}}  

\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
%==========================================================
%                   TABLE OF CONTENTS
%==========================================================
\newcommand\@pnumwidth{1.55em}%era 1.55
\newcommand\@tocrmarg{5em}%era 2.55--5
\newcommand\@dotsep{2} %era 3--2
\setcounter{tocdepth}{3} %{3}
\newcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\nomeconteudo
        \@mkboth{\MakeUppercase\nomeconteudo}{\MakeUppercase\nomeconteudo}}%
    {\let\footnotemark\relax  % in case one is in the title
    \@starttoc{toc}}%
    \if@restonecol\twocolumn\fi
    \newpage
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2%\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{\baselineskip}           %1.0em \@plus\p@}
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \bfseries \MakeUppercase{#1} \normalfont
      \nobreak
      \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
      \hfil \nobreak \hb@xt@\@pnumwidth{\hss #2}\par
      \nobreak
      \global\@nobreaktrue
      \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}

\newcommand*\l@listas[2]{%
  \ifnum \c@tocdepth >\m@ne
     \addpenalty{-\@highpenalty}%
     \vskip 0.5\baselineskip               %1.0em \@plus\p@
     \setlength\@tempdima{3.0em}%
     \begingroup
       \parindent \z@ \rightskip \@pnumwidth
       \parfillskip -\@pnumwidth
       \leavevmode
       \advance\leftskip\@tempdima
       \hskip -\leftskip
       \MakeUppercase{#1}
       \nobreak
       \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
       \hfil \nobreak \hb@xt@\@pnumwidth{\hss #2}\par
       \penalty\@highpenalty
     \endgroup
  \fi}

\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
     \addpenalty{-\@highpenalty}%
     \vskip 1.0em \@plus\p@
     \setlength\@tempdima{4.0em}%{3.0em}
     \begingroup
       \parindent \z@ \rightskip \@pnumwidth
       \parfillskip -\@pnumwidth
       \leavevmode
       \advance\leftskip\@tempdima
       \hskip -\leftskip
       \bfseries \MakeUppercase{#1} \normalfont
       \nobreak
       \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
       \hfil\nobreak\hb@xt@\@pnumwidth{\hss #2}\par
       \penalty\@highpenalty
	     \endgroup
  \fi}

%\newcommand*\l@section[2]{\addpenalty{-\@highpenalty}%
%                          \setlength\@tempdima{2.4em}%
%                          \begingroup
%                            \parindent \z@ \rightskip \@pnumwidth
%                            \parfillskip -\@pnumwidth
%                            \advance\leftskip\@tempdima
%                            \hskip -\leftskip
%                            \textnormal{#1} \nobreak \dotfill \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
%                            \penalty\@highpenalty
%                          \endgroup
%                          }
\newcommand*\l@section{\normalfont \@dottedtocline{1}{0em}{4.0em}} %{3.0em}
\newcommand*\l@subsection{\normalfont \@dottedtocline{2}{0em}{4.0em}} %{3.0em}
\newcommand*\l@subsubsection{\normalfont \@dottedtocline{3}{0em}{4.0em}} %{3.0em}
\newcommand*\l@paragraph{\normalfont \@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\normalfont \@dottedtocline{5}{12em}{6em}}
%==========================================================
%                 CREDITS PAGE
%==========================================================
\newcommand\makecredits{ %\begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \noindent
    c\@year

    \vspace{10mm}

    \noindent
    INSTITUTO MILITAR DE ENGENHARIA\\
    Praça General Tibúrcio, 80-Praia Vermelha \\
    Rio de Janeiro-RJ CEP 22290-270

    \vspace{10mm}
    \noindent
    Este exemplar é de propriedade do Instituto Militar de Engenharia, que poderá incluí-lo em base de dados, armazenar em
    computador, microfilmar ou adotar qualquer forma de arquivamento.

    \vspace{10mm}
    \indent
    \par{É permitida a menção, reprodução parcial ou integral e a transmissão entre bibliotecas deste trabalho, sem modificação
    de seu texto, em qualquer meio que esteja ou venha a ser fixado, para pesquisa acadêmica, comentários e citações, desde
    que sem finalidade comercial e que seja feita a referência bibliográfica completa.}
    \vspace{10mm}

    \par{Os conceitos expressos neste trabalho são de responsabilidade do(s) autor(es) e do(s) orientador(es).}

    \vspace{10mm}
    \noindent
    \hspace{3cm}
    \framebox[12.5cm]{\footnotesize
        \begin{minipage}{13cm}
        \vspace*{1mm}
        \parbox[t]{1.5cm}{\hspace{2mm} \@cipcode}%
        \parbox[t]{11cm}{\noindent Wanous, C., Prado, J., Vasconcelos, T.}\\
        \parbox[t]{1.5cm}{\ }%
        \parbox[t]{11cm}{\noindent \hspace{4mm} \@title \hspace{1mm}/ \hspace{6mm} Camila Antonaccio Wanous, João Luiz do Prado Neto e Thiago de Paula Vasconelos - Rio de Janeiro : \@university, \@year.}\\
        \parbox[t]{1.5cm}{\ }% 
        \parbox[t]{11cm}{\noindent \hspace{4mm}} \\ 
[\baselineskip]
        \parbox[t]{1.5cm}{\ }%   
        \parbox[t]{11cm}{\noindent \hspace{4mm} Iniciação à Pesquisa (IP)- \@university \vspace{1mm} - Rio de Janeiro, \@year. } \\
[\baselineskip]
        \parbox[t]{1.5cm}{\ }%
        \parbox[t]{11cm}{\noindent \hspace{4mm} 1. Engenharia da computação. 2. Teoria espectral de grafo. 
3. Vetor de Fiedler. 4. Árvores de Tipo I e de Tipo II.\@university.}\\
[\baselineskip]
        \parbox[t]{10cm}{\ }%
        \parbox[t]{4.0 cm}{}
            \end{minipage}%
    }
    %\end{titlepage}%
    %\setcounter{footnote}{0}%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@thanks\@empty
%  \global\let\@author\@empty
%  \global\let\@date\@empty
%  \global\let\@title\@empty
%  \global\let\title\relax
%  \global\let\author\relax
%  \global\let\date\relax
    \global\let\and\relax
    \newpage
}
%==========================================================
%                 APPROVAL PAGE
%==========================================================
\def\@numberofmembers{3}
\def\@approvalspace{.75in}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}
\ifnum \@numberofmembers > 3
\gdef\@approvalspace{.5in}
\fi}
\newcommand\approvalpage{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \thispagestyle{plain}
    \begingroup
       \noindent
       \begin{center}
          %\null\vfill
          \MakeUppercase{\textbf{\@university}}
          \vfill
          \MakeUppercase{\textbf{\@patente\space Camila Antonaccio Wanous}}
          \vfill
          \MakeUppercase{\textbf{\@patente\space João Luiz do Prado Neto}}
          \vfill
          \MakeUppercase{\textbf{\@patente\space Thiago de Paula Vasconcelos}}
          \vfill
          \MakeUppercase{\textbf{\@title}}
          \vfill
       \end{center}
       \indent
       \par {\@thesisapp}
       \par Orientador: {\@chair} %\\[\baselineskip]
       %\par Co-orientador: {\@vicechair}\\[\baselineskip]
       %\noindent
       \par Aprovada em 08 de outubro de 2013 pela seguinte Banca Examinadora:
       \begin{center}
          \vspace{\@approvalspace}
          $\:\overline{\makebox[15cm][c]{{\@chair} {\@chairfrom} - Presidente}}\:$ \\
          \vspace{\@approvalspace}
        % $\:\overline{\makebox[15cm][c]{{\@vicechair} {\@vicechairfrom}}}\:$ \\
        % \vspace{\@approvalspace}
          $\:\overline{\makebox[15cm][c]{{\@memberone} {\@memberonefrom}}}\:$ \\
          \vspace{\@approvalspace}
          \ifnum \@numberofmembers > 2
          $\:\overline{\makebox[15cm][c]{{\@membertwo} {\@membertwofrom}}}\:$ \\
          \vspace{\@approvalspace}
          \fi
          \ifnum \@numberofmembers > 3
          $\:\overline{\makebox[15cm][c]{{\@memberthree} {\@memberthreefrom}}}\:$ \\
          \vspace{\@approvalspace}
          \fi
          \ifnum \@numberofmembers > 4
          $\:\overline{\makebox[15cm][c]{{\@memberfour} {\@memberfourfrom}}}\:$ \\
          \vspace{\@approvalspace}
          \fi
          \vfill\null
          {\@cityear}
          \vfill\null
       \end{center}
    \endgroup
    \if@restonecol\twocolumn\fi
    \newpage
}
%==========================================================
%                 DEDICATORIA
%==========================================================
\newenvironment{dedicatoria}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \onecolumn
        \null
        \vspace{11.5cm}
        \parindent \z@
        \leftskip=6.5cm
        \noindent
        \par
        \selectlanguage{portuges}
                }
                {\if@restonecol\onecolumn\else\clearpage\fi}
%==========================================================
%                 AGRADECIMENTOS
%==========================================================
\newenvironment{agradecimentos}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \onecolumn
        \chapter*{\nomeagradecimentos
            \@mkboth{\MakeUppercase\nomeagradecimentos}{\MakeUppercase\nomeagradecimentos}}%
                \setlength\parindent{0.75cm}
        \indent
        \par
        \selectlanguage{portuges}
                }
                {\if@restonecol\onecolumn\else\clearpage\fi}
%==========================================================
%                 EPIGRAFE
%==========================================================
\newenvironment{epigrafe}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \onecolumn
        \null
        \vspace{11.5cm}
        \parindent \z@
        \leftskip=6.5cm
        \noindent
        \par
        \selectlanguage{portuges}
                }
                {\if@restonecol\onecolumn\else\clearpage\fi}
%==========================================================
%                 LIST OF FIGURES
%==========================================================
\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
%    \thispagestyle{plain}
    \addcontentsline{toc}{listas}{\protect\nomelistafiguras}
    \chapter*{\nomelistafiguras
     \@mkboth{\MakeUppercase\nomelistafiguras}{\MakeUppercase\nomelistafiguras}}%
    {\let\footnotemark\relax  % in case one is in the title
    \@starttoc{lof}}%
    \if@restonecol\twocolumn\fi
    \newpage
    }

\newcommand*\l@figure[2]{\addpenalty{-\@highpenalty}%
                          \setlength\@tempdima{2.6em}% era 2.6
                          \begingroup
                            %\parindent \z@                     %alterado por saulo
                            \rightskip \@tocrmarg %pnumwidth    %alterado por saulo
                            %\parfillskip -\@pnumwidth          %alterado por saulo
                            \parfillskip -\rightskip            %alterado por saulo
                            \advance\leftskip\@tempdima
                            \hskip -\leftskip
                            \hangindent=\@tempdima
                            \nomefigura\textnormal{#1}
                            \nobreak
                \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
                            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
                            \penalty\@highpenalty
                          \endgroup
                          }

%Retirado do arquivo tocloft.sty
%\renewcommand*{\l@figure}[2]{%
%  \ifnum \c@lofdepth >\z@
%    \vskip \cftbeforefigskip
%    {\leftskip \cftfigindent\relax
%     \rightskip \@tocrmarg
%     \parfillskip -\rightskip
%     \parindent \cftfigindent\relax\@afterindenttrue
%     \interlinepenalty\@M
%     \leavevmode
%     \@tempdima \cftfignumwidth\relax
%     \let\@cftbsnum \cftfigpresnum
%     \let\@cftasnum \cftfigaftersnum
%     \let\@cftasnumb \cftfigaftersnumb
%     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
%     {\cftfigfont #1}\nobreak
%     \cftfigfillnum{#2}}
%   \fi
%  }
%==========================================================
%                 LIST OF TABLES
%==========================================================
\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \thispagestyle{plain}
    \addcontentsline{toc}{listas}{\protect\nomelistatabelas}
    \chapter*{\nomelistatabelas
      \@mkboth{%
          \MakeUppercase\nomelistatabelas}{\MakeUppercase\nomelistatabelas}}%
    {\let\footnotemark\relax  % in case one is in the title
    \@starttoc{lot}}%
    \if@restonecol\twocolumn\fi
    \newpage
    }

\newcommand*\l@table[2]{\addpenalty{-\@highpenalty}%
                          \setlength\@tempdima{2.4em}%
                          \begingroup
                            %\parindent \z@                     %alterado por saulo
                            \rightskip \@tocrmarg %pnumwidth    %alterado por saulo
                            %\parfillskip -\@pnumwidth          %alterado por saulo
                            \parfillskip -\rightskip            %alterado por saulo
                            \advance\leftskip\@tempdima
                            \hskip -\leftskip
                            \hangindent=\@tempdima
                            \nometabela\textnormal{#1}
                            \nobreak
                            \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
                            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
                            \penalty\@highpenalty
                          \endgroup
                          }
%==========================================================
%                 LIST OF SYMBOLS AND ABREVIATURES
%==========================================================
\newcommand\listofsymbols{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \addcontentsline{toc}{listas}{\protect\nomelistasimbolos}
    %\chapter*{\nomelistasimbolos
    % \@mkboth{\MakeUppercase\nomelistasimbolos}{\MakeUppercase\nomelistasimbolos}}%
    %{\let\footnotemark\relax  % in case one is in the title
    %\@starttoc{loa}%
    %\@starttoc{los}}%
    %\if@restonecol\twocolumn\fi
    %\newpage
    }

%\newcommand*\l@simbolo[2]{#2}

%\newcommand*\l@abreviatura[2]{#2}
%==========================================================
%                 LIST OF ABBREVIATIONS
%==========================================================

\newenvironment{abbreviation}
  {\if@openright\cleardoublepage\else\clearpage\fi
   \if@twocolumn
     \@restonecoltrue\onecolumn
   \fi
    %\vspace*{2cm}
    \addcontentsline{toc}{listas}{\protect\nomelistaabreviaturas}
    \chapter*{\nomelistaabreviaturas
      \@mkboth{%
          \MakeUppercase\nomelistaabreviaturas}{\MakeUppercase\nomelistaabreviaturas}}%

   %\begin{minipage}{160mm}}%ALTEREI ERA 100mm
  %{\end{minipage} %\end{flushright}
   \if@restonecol\twocolumn\fi}

%==========================================================
%                 LIST OF NICKNAMES
%==========================================================
\newcommand\listofnicks{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
%    \thispagestyle{plain}
    \addcontentsline{toc}{listas}{\protect\nomelistasiglas}
    %\chapter*{\nomelistasiglas
    % \@mkboth{\MakeUppercase\nomelistasiglas}{\MakeUppercase\nomelistasiglas}}%
    %{\let\footnotemark\relax  % in case one is in the title
    %\@starttoc{lon}}%
    %\if@restonecol\twocolumn\fi
    %\newpage
    }

\newcommand*\l@sigla[2]{{#2} {#1}\\}
%==========================================================
%                 RESUMO
%==========================================================
\newenvironment{resumo}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \onecolumn
        \chapter*{\nomeresumo
            \@mkboth{\MakeUppercase\nomeresumo}{\MakeUppercase\nomeresumo}}%
                \setlength\parindent{0.75cm}
        \indent
        \par
        \ssp
        \selectlanguage{portuges}
                }
                {\if@restonecol\onecolumn\else\clearpage\fi}
%==========================================================
%                 ABSTRACT
%==========================================================
\newenvironment{abstract}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \onecolumn
        \chapter*{\nomeabstract
            \@mkboth{\MakeUppercase\nomeabstract}{\MakeUppercase\nomeabstract}}%
                \setlength\parindent{0.75cm}
                \indent
                \par
        \ssp
        \selectlanguage{english}
        }
               {\if@restonecol\onecolumn\else\clearpage\fi}
%==========================================================
%               BIBLIOGRAFY
%==========================================================
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter{\nomebibliografia
        \@mkboth{\MakeUppercase\nomebibliografia}{\MakeUppercase\nomebibliografia}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `theimebibliography' environment}}%
      \endlist}
\newenvironment{theimebibliography}[1]
    {\chapter{\nomebibliografia
       \@mkboth{\MakeUppercase\nomebibliografia}{\MakeUppercase\nomebibliografia}}%
    \ssp
    \list
    {\@biblabel{\arabic{NAT@ctr}}}{\@bibsetup{#1}%
    \setcounter{NAT@ctr}{0}}%
%       \addtolength{\marginparsep}{\bibindent}%
        \setlength{\itemindent}{-0.8\bibindent}%
%       \setlength{\listparindent}{-\itemindent}%
    \setlength{\itemsep}{\bibsep}%
%   \setlength{\parsep}{\z@}%
        \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=1000\relax
    \let\citeN\cite \let\shortcite\cite
    \let\citeasnoun\cite
    }
    {\def\@noitemerr
    {\@latex@warning{Empty `theimebibliography' environment}}%
    \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
%==========================================================
%               INDEX
%==========================================================
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\nomeindice}]%
                \@mkboth{\MakeUppercase\nomeindice}%
                        {\MakeUppercase\nomeindice}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
\vspace{1.33em}
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
%\@addtoreset{footnote}{chapter} %%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\nomeconteudo{SUM{\'A}RIO}
\newcommand\nomelistafiguras{LISTA DE ILUSTRA{\c{C}}{\~O}ES}
\newcommand\nomelistatabelas{LISTA DE TABELAS}
\newcommand\nomeabreviatura{Abreviaturas}
\newcommand\nomelistaabreviaturas{LISTA DE ABREVIATURAS}
%\newcommand\nomelistaabreviaturas{LISTA DE SÍMBOLOS E ABREVIATURAS}
\newcommand\nomesimbolo{S\'{\i}mbolos}
\newcommand\nomelistasimbolos{Lista de Abreviaturas}
\newcommand\nomelistasiglas{Lista de Siglas}
\newcommand\nomebibliografia{REFER\^ENCIAS BIBLIOGRÁFICAS}
\newcommand\nomeindice{{\'I}NDICE}
\newcommand\nomefigura{FIG.}
\newcommand\nometabela{TAB.}
\newcommand\nomeparte{PARTE}
\newcommand\nomecapitulo{CAP{\'I}TULO}
\newcommand\nomeapendice{AP{\^E}NDICE}
\newcommand\nomeagradecimentos{Agradecimentos}
\newcommand\nomeabstract{Abstract}
\newcommand\nomeresumo{Resumo}
\def\hoje{\number\day \space de \ifcase\month\or janeiro\or fevereiro\or
  mar{\c{c}}o\or abril\or maio\or junho\or julho\or agosto\or setembro\or
  outubro\or novembro\or dezembro\fi \space de \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\newenvironment{frontmatter}
    {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \onecolumn
        \setcounter{page}{2}\renewcommand{\thepage}{\arabic{page}}
    }
    {\newpage}
\endinput
%%
%% End of file `report.cls'.
