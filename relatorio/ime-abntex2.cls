%%
%% Customizações do abnTeX2 (http://abnTeX2.googlecode.com) para a Universidade XXXX
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Jan Segre, jansegre@gmail.com
%%
%% Further information about abnTeX2 are available on http://abntex2.googlecode.com/
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ime-abntex2}[2013/04/01 v1.0 Modelo da Universidade Brasil baseado em abnTeX2]
\usepackage[utf8]{inputenc}		% Codificacao do documento (conversão automática dos acentos)

%
% Repassa todos os parametros a classe abntex2,
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}
\ProcessOptions\relax
\LoadClass{abntex2}

% alterando a capa
\renewcommand{\imprimircapa}{%
  \begin{capa}%
    \center
    \vspace*{-2.5cm}
    \includegraphics[height=25mm]{Brasao}\\
    \ABNTEXchapterfont\small
    {\bfseries
    MINISTÉRIO DA DEFESA\\
    EXÉRCITO BRASILEIRO\\
    DEPARTAMENTO DE CIÊNCIA E TECNOLOGIA\\
    INSTITUTO MILITAR DE ENGENHARIA\\
    (Real Academia de Artilharia, Fortificação e Desenho/1792)\\
    CURSO DE GRADUAÇÃO EM ENGENHARIA DE COMPUTAÇÃO}

    \vfill

    \ABNTEXchapterfont\Large\imprimirautor

    \vfill

    \ABNTEXchapterfont\LARGE\imprimirtitulo

    \vfill

    {\ABNTEXchapterfont\large\imprimirlocal}\\
    {\ABNTEXchapterfont\large\imprimirdata}

    \vspace*{1cm}
  \end{capa}
}


% folha de rosto

\makeatletter

\renewcommand{\folhaderostocontent}{
\begin{center}
{\ABNTEXchapterfont\Large Instituto Militar de Engenharia}

%\vspace*{1cm}

%{\ABNTEXchapterfont\large\imprimirautor}

\vspace*{\fill}\vspace*{\fill}

\begin{center}
\ABNTEXchapterfont\bfseries\Large\imprimirtitulo
\end{center}

%\vspace*{\fill}
\vspace*{5cm}

\abntex@ifnotempty{\imprimirpreambulo}{%
  \hspace{.45\textwidth}
  \begin{minipage}{.5\textwidth}
  \SingleSpacing
  \par \imprimirpreambulo
  \par {\imprimirorientadorRotulo~\imprimirorientador\par}
  \abntex@ifnotempty{\imprimircoorientador}{%
    {\imprimircoorientadorRotulo~\imprimircoorientador}%
  }%
  \end{minipage}%
  \vspace*{\fill}
}%

\vspace*{\fill}

%{\abntex@ifnotempty{\imprimirinstituicao}{\imprimirinstituicao\vspace*{\fill}}}

{\large\imprimirlocal}

\par

{\large\imprimirdata}
\vspace*{1cm}
\end{center}
}

\makeatother
