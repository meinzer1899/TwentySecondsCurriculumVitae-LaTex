%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Twenty Seconds Curriculum Vitae in LaTex
% ****************************************
% 
% Lise: MIT
%
% For further information please visit:
% https://github.com/spagnuolocarmine/TwentySecondsCurriculumVitae-LaTex
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%
% CLASS %
%%%%%%%%%
\ProvidesClass{twentysecondcv}[2015/02/28 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%%%%%%%%%%%%
% PACKAGES %
%%%%%%%%%%%%
%\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[default]{raleway}
\renewcommand*\familydefault{\sfdefault} 	
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
%MY STUFF
\RequirePackage[					% typographic tuning
	activate={true,nocompatibility},
	final,
	tracking=true,
	kerning=true,
	spacing=true]
{microtype}
\RequirePackage{pdfpages}
\RequirePackage{simpleicons}



%%%%%%%%%%%
% OPTIONS %
%%%%%%%%%%%
% icons
\newbool{icon}
\DeclareOption{icon}{%
  \booltrue{icon}
}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\ifbool{icon}{\RequirePackage{fontawesome}}{}

\usetikzlibrary{calc}


%%%%%%%%%%
% colors %
%%%%%%%%%%
\definecolor{white}{RGB}{255,255,255} 
\definecolor{darkgray}{HTML}{333333} 
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{lightgray}{HTML}{999999}
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB0B00}
\definecolor{blue}{HTML}{6CE0F1}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{cerulean}{HTML}{007BA7}
\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{maindarkgray}{HTML}{B3B3B3}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{fillheader}{white}
  \colorlet{asidecolor}{sidecolor}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
  \colorlet{asidecolor}{sidecolor}
\fi

\colorlet{textcolor}{gray}
\colorlet{headercolor}{mainblue}

%%%%%%%%%%%%%%%%%%%%%%%%
% Profile left SideBar %
%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

% compute size of profile picture
\newcommand{\imsize}{\linewidth}
\newlength\imagewidth
\newlength\imagescale
\renewcommand{\imsize}{0.618\linewidth}
\pgfmathsetlength{\imagewidth}{5cm}%
\pgfmathsetlength{\imagescale}{\imagewidth/600}%

\newcommand{\profilesection}[2]{{\noindent\color{black!80} \huge #1 \rule[0.15\baselineskip]{#2}{1pt} \vspace{1pt}}}

\newcommand{\cvdate}[1]{\renewcommand{\givencvdate}{#1}}                % date
\newcommand{\cvmail}[1]{\renewcommand{\givencvmail}{#1}}                % mail
\newcommand{\cvnumberphone}[1]{\renewcommand{\givennumberphone}{#1}}    % phone
\newcommand{\cvaddress}[1]{\renewcommand{\givencvaddress}{#1}}          % address
\newcommand{\cvsite}[1]{\renewcommand{\givencvsite}{#1}}                % site
\newcommand{\aboutme}[1]{\renewcommand{\givenaboutme}{\justifying#1}}   % about me
\newcommand{\profilepic}[1]{\renewcommand{\givenprofilepic}{#1}}        % picture
\newcommand{\cvname}[1]{\renewcommand{\givencvname}{#1}}                % name
\newcommand{\cvjobtitle}[1]{\renewcommand{\givencvjobtitle}{#1}}        % job title
\newcommand{\cvxing}[1]{\renewcommand{\givencvxing}{#1}}                % xing profile

\newcommand{\givencvname}{REQUIRED!} % name
\newcommand{\givencvdate}{}          % date
\newcommand{\givencvmail}{}          % mail
\newcommand{\givennumberphone}{}     % phone
\newcommand{\givencvaddress}{}       % address
\newcommand{\givenaboutme}{}         % about me
\newcommand{\givenprofilepic}{}      % picture
\newcommand{\givencvsite}{}          % site
\newcommand{\givencvjobtitle}{}      % job title
\newcommand{\givencvxing}{}          % xing profile


% icon in grey circle; #1 -> icon
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{
  \node[shape=circle,draw,minimum size=18pt,inner sep=1pt, 
  sidecolor,text=darkgray] (char) {#1};}
}

% Text in square node with rounded corners; #1 -> text, #2 -> color
\newcommand*\round[2]{%
\tikz[baseline=(char.base)]\node[anchor=center,draw,rectangle,
  rounded corners,minimum width=5.5cm,inner sep=1.6pt,
  fill=#2,#2,text=white] (char) {#1};%
}


% returns minipage width minus two times \fboxsep
% to keep padding included in width calculations
% can also be used for other boxes / environments
\newcommand{\mpwidth}{\linewidth-\fboxsep-\fboxsep}
%----------------------------------------------------------------------------------------
%	META SKILL
%----------------------------------------------------------------------------------------

% Renders a progress-bar to indicate a certain skill in percent.
% param 1: name of the skill / tech / etc.
% param 2: level (for example in years)
% param 3: percent, values range from 0 to 1
\newcommand\skills[1]{%
	\renewcommand{\givenskill}{
	\newcommand\spaceToRight{8pt}
	
	\hspace{-4pt}
	\begin{tikzpicture}[scale=1,rounded corners=2pt,very thin]
		\foreach [count=\i] \name/\level/\percent in {#1} {
		\fill [maindarkgray] (0,-\i) rectangle (1\mpwidth-\spaceToRight, -\i+0.15);
		\fill [mainblue] (0,-\i) rectangle (\percent\mpwidth-\spaceToRight, -\i+0.15);
		\node [above right] at (0,-\i+0.15) {\name};
		\node [above left] at (1\mpwidth-\spaceToRight,-\i+0.15) {\level};
	} % end for each
	\end{tikzpicture}%
}
}

% text style skills
\newcommand{\givenskill}{}
  \newcommand\skillstext[1]{
    \renewcommand{\giventextskill}{
    \begin{flushleft}
    \noindent
    \foreach \skill in {#1}
    {
      \tikz[baseline]\node[anchor=base,draw,fill=gray,sidecolor,text=mainblue,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{\skill};
    }
    \end{flushleft}
  }
}

\newcommand{\giventextskill}{}

\newcommand{\makeprofile}
{
  % grey bar on the left side
  \begin{tikzpicture}[remember picture,overlay]
      \node [rectangle, fill=asidecolor, anchor=north, minimum width=9.90cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
  \end{tikzpicture}

  \begin{textblock}{6}(0.5, 0.2)
    \begin{flushleft}
      \hspace{13pt}

      % profile picture
      \ifthenelse{\equal{\givenprofilepic}{}}{}{\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
          \clip (600/2, 567/2) circle (567/2);
          \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\givenprofilepic}};
      \end{tikzpicture}}

      % name
      {\Huge\color{mainblue}\givencvname}

      % jobtitle
      \begin{flushright}
        {\Large\color{black!80}\givencvjobtitle}
      \end{flushright}
      \renewcommand{\arraystretch}{1.6}
      
      % profile links (github, xing)
      \begin{table}[]
      	\centering
      	\begin{tabular}{ccc}
      		\href{https://www.github.com/\givencvsite}{\Large\icon{\faicon{github}}} & \href{https://www.xing.com/profile/\givencvxing/cv}{\large\icon{\faicon{xing}}} &
      		\href{mailto:\givencvmail}{\large\icon{\faicon{envelope}}}
      	\end{tabular}
      \end{table}

      % table with icons 
      \begin{tabular}{c @{\hskip 0.2cm} p{5cm}}
        % CV date
        \ifthenelse{\equal{\givencvdate}{}}{}{\textsc{\large\icon{\faicon{birthday-cake}}} & \givencvdate\\}
        % CV address
        \ifthenelse{\equal{\givencvaddress}{}}{}{\textsc{\large\icon{\faicon{map-marker}}} & \givencvaddress\\}
        % CV phone
        \ifthenelse{\equal{\givennumberphone}{}}{}{\textsc{\Large\icon{\faicon{mobile-phone}}} & \givennumberphone\\}
        % CV github
        %\ifthenelse{\equal{\givencvsite}{}}{}{\textsc{\large\icon{\faicon{github}}} & \href{https://www.github.com/\givencvsite}{\textcolor{cerulean}\givencvsite}\\}
        % CV xing
        %\ifthenelse{\equal{\givencvxing}{}}{}{\textsc{\large\icon{\faicon{xing}}} & \href{https://www.xing.com/profile/\givencvxing/cv}{\textcolor{cerulean}\givencvxing}\\}
        % CV mail
        %\ifthenelse{\equal{\givencvmail}{}}{}{\textsc{\large\icon{\faicon{inbox}}} & \href{mailto:\givencvmail}{\givencvmail}}
      \end{tabular}

      % about me text
      \profilesection{Hallo!}{2cm}
      \newline
      \givenaboutme

      % skills with scale
      \profilesection{Technologien}{2cm}
      \givenskill
      
      \profilesection{Stärken}{2cm}
      \giventextskill
      \noindent
      \scriptsize
      \noindent
      

    \end{flushleft}
  \end{textblock}
  \vspace{-10pt}
}

%%%%%%%%%%%%%%%%%%%%%
% Section Color box %
%%%%%%%%%%%%%%%%%%%%%
\newcounter{colorCounter}
\def\@sectioncolor<#1>{
  {%
  % Switch between blue and gray
   \round{#1}{%
      \ifodd\value{colorCounter}%
        mainblue%
      \else%
        maingray%
      \fi%
    }%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  \par%
  {%
    \LARGE 
    \color{headercolor}%
    \@sectioncolor<#1>%
  }
  \par\vspace{\parskip}
}

\newcommand{\sectionicon}[2]{
  \par%
  {%
    \LARGE 
    #1 
    \color{headercolor}%
    \@sectioncolor<#2>%
  }
  \par\vspace{\parskip}
}

\renewcommand{\subsection}[1]{
  \par\vspace{.5\parskip}%
  {%
  \large\color{headercolor} #1%
  }
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List twenty environment %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\tabcolsep}{0pt}
\newenvironment{twenty}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\color{headercolor}}
\newcommand{\twentyitem}[4]{%
  \hspace{5pt}#1&\parbox[t]{11cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize#3}\\%
    #4\vspace{\parsep}%
  }\\%
}
\setlength{\tabcolsep}{0pt}
\newenvironment{twentyicon}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\color{headercolor}}
\newcommand{\twentyitemicon}[5]{%
 \hspace{3pt}\faicon{#1}\hspace{2pt}#2&\parbox[t]{11.2cm}{%
    \textbf{#3}%
    \hfill%
    {\footnotesize#4}\\%
    #5\vspace{\parsep}%
  }\\%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Small twenty List environment %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\tabcolsep}{0pt}
\newenvironment{twentyshort}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\color{headercolor}}
\newcommand{\twentyitemshort}[2]{%
  \hspace{5pt}#1&\parbox[t]{11cm}{%
    \textbf{#2}%
  }\\%
}
\setlength{\tabcolsep}{0pt}
\newenvironment{twentyshorticon}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\color{headercolor}}
\newcommand{\twentyitemshorticon}[3]{%
  \hspace{3pt}\faicon{#1}\hspace{3pt}#2&
      \parbox[t]{11.5cm}{%
    \textbf{#3}%
  }\\%
}

%%%%%%%%%%%%%%%%
% Page Setting %
%%%%%%%%%%%%%%%%
\RequirePackage[left=7.3cm,top=0.1cm,right=0.5cm,bottom=0.2cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}

\newenvironment{changemargin}[2]{%
\begin{list}{}{%
\setlength{\topsep}{0pt}%
\setlength{\leftmargin}{#1}%
\setlength{\rightmargin}{#2}%
\setlength{\listparindent}{\parindent}%
\setlength{\itemindent}{\parindent}%
\setlength{\parsep}{\parskip}%
}%
\item[]}{\end{list}}
