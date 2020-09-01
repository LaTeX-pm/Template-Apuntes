%% Base del template: overleaf.com/learn/latex/Writing_your_own_class

%% Identificación
%% The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notebookFMG}[2020/08/30 Clase de Documento para realizar apuntes]

%% ====================================================================

%% Paquetes requeridos
\RequirePackage[spanish]{babel}               % Para el español
\RequirePackage[]{fancyhdr}                   % Para insertar headers y footers
% \RequirePackage[Sonny]{fncychap}                   % Para tener capítulos bknes
\RequirePackage[letterpaper]{geometry}        % Para modificar la geometría del libro
\RequirePackage{ifthen}                       % Para tener condicionales
\RequirePackage[utf8]{inputenc}               % Para tener formato utf8


%% ====================================================================

%% Definiciones preliminares, necesarias para las opciones del documento
% Configuraciones generales para las opciones de la clase
\def\marginnoteoption {false}      % Opción para activar las notas al margen
\def\twosideoption {false}         % Opción para activar los dos lados del libro

% Definiciones de la portada
\def\tituloportada {Titulo de la Portada}
\def\autordeldocumento {Nombre del autor}
\def\repositorio {Link repositorio}
\def\fecha {\today}
\def\nombredelcurso {Curso}
\def\codigodelcurso {CO-1234}
\def\nombreuniversidad {Universidad de Chile}
\def\nombrefacultad {Facultad de Ciencias Físicas y Matemáticas}
\def\departamentouniversidad {Departamento de la Universidad}

% Márgenes de la portada
\def\firstpagemarginbottom {3.0}        % Margen inferior página portada [cm]
\def\firstpagemarginleft {2.54}         % Margen izquierdo página portada [cm]
\def\firstpagemarginright {2.54}        % Margen derecho página portada [cm]
\def\firstpagemargintop {3.8}           % Margen superior página portada [cm]

% Márgenes de la página
\def\pagemarginbottom {2.7}        % Margen inferior página [cm]
\def\pagemarginleft {2.54}         % Margen izquierdo página [cm]
\def\pagemarginright {2.54}        % Margen derecho página [cm]
\def\pagemargintop {3.0}           % Margen superior página [cm]
\def\pagemarginnote {0.0}          % Margen de las notas al margen
\def\pagemarginnotesep {0.0}       % Separación entre el cuerpo y notas al margen

%% ====================================================================

%% En esta parte se manejan las opciones entregadas a la clase
\DeclareOption{marginnote}{% Opción de la nota al margen
    \def\marginnoteoption {true}
}

\DeclareOption{twoside}{% Opción de twoside
    \def\twosideoption {true}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % Pasar el resto de los argumentos a la clase de documento original. Cosas que sinceramente no entiendo.
\ProcessOptions\relax

\LoadClass[]{book}

%% ====================================================================

%% Cuerpo de la clase. La mayoría de las declaraciones aparecen aquí.
% Comando para utilizar las notas al margen, si es que está activada la opción
\newcommand{\marginnotecommand}[2]{\ifthenelse{\equal{\marginnoteoption}{true}}{#1}{#2}}

% Comando para utilizar twoside, si es que está activada la opción
\newcommand{\twosidecommand}[2]{\ifthenelse{\equal{\twosideoption}{true}}{#1}{#2}}

\marginnotecommand{% Actualizar las configuraciones de la página dependiendo de que si se quieren notas al margen o no
    \def\pagemarginleft {2.0}
    \def\pagemarginright {5.0}
    \def\pagemarginnote {4.0}
    \def\pagemarginnotesep {0.5}
}{}

\newcommand{\header}{% Comando que crea el header
    \twosidecommand{% Opción si se decide ocupar twoside
        \fancyheadoffset[LE,RO]{% Opción para que el header ocupe toda la página
            \dimexpr\marginparsep+\marginparwidth
        }
        \fancyhead[LE,RO]{\thepage}
        \fancyhead[RE,LO]{\rightmark}
    }{% Opción si no se decide ocupar twoside
        \fancyheadoffset[R]{% Opción para que el header ocupe toda la página
            \dimexpr\marginparsep+\marginparwidth
        }
        \fancyhead[R]{\thepage}
        \fancyhead[L]{\rightmark}
    }
}
\newcommand{\footer}{% Comando que crea el footer
    \twosidecommand{% Opción si se decide ocupar twoside
        \fancyfootoffset[LE,RO]{% Opción para que el footer ocupe toda la página
            \dimexpr\marginparsep+\marginparwidth
        }
        \fancyfoot[LE,RO]{\nombreuniversidad}
        \fancyfoot[RE,LO]{\codigodelcurso~\nombredelcurso}
    }{% Opción si no se decide ocupar twoside
        \fancyfootoffset[R]{% Opción para que el footer ocupe toda la página
            \dimexpr\marginparsep+\marginparwidth
        }
        \fancyfoot[R]{\nombreuniversidad}
        \fancyfoot[L]{\codigodelcurso~\nombredelcurso}
    }
}
\newcommand{\setheaderfooter}{% Comando que setea el header y el footer
    \pagestyle{fancy}
    \fancyhf{}
    \renewcommand{\headrulewidth}{0.5pt}
    \header
    \footer
}

\newcommand{\auxsetpagemargincm}[6]{ % Comando auxiliar utilizado para modificar los márgenes de la página
    \twosidecommand{% Opción si se decide ocupar twoside
        \newgeometry{
            left=#1cm,
            top=#2cm,
            right=#3cm,
            bottom=#4cm,
            marginparwidth=#5cm,
            marginparsep=#6cm,
            twoside=true,
        }
    }{% Opción si no se decide ocupar twoside
        \newgeometry{
            left=#1cm,
            top=#2cm,
            right=#3cm,
            bottom=#4cm,
            marginparwidth=#5cm,
            marginparsep=#6cm,
            twoside=false
        }
    }
}
% Utilizado para modificar los márgenes de la página
\newcommand{\setpagemargincm}[4]{\auxsetpagemargincm{#1}{#2}{#3}{#4}{\pagemarginnote}{\pagemarginnotesep}}

\newcommand{\tablaautor}{ % Comando que crea la tabla que resume la información del autor
    \begin{tabular}{ll}
        Autor: & \autordeldocumento \\
        Repositorio: & \repositorio \\
        Fecha: & \fecha \\
    \end{tabular}
}

\newcommand{\portada}{ % Comando que crea la portada. Es el análogo del "\maketitle". La idea original fue inspirada a partir de manualdelatex.com/tutoriales/crear-una-portada
    \setpagemargincm{\firstpagemarginleft}{\firstpagemargintop}{\firstpagemarginright}{\firstpagemarginbottom}
    \frontmatter % Enumerar en roman
    \begin{titlepage}
        % Aquí va el nombre de la universidad
        \centering
        {\bfseries\LARGE \nombreuniversidad \par}
        \vspace{1pt}
        % Aquí va el nombre de la facultad
        {\scshape\Large \nombrefacultad \par}
        \vspace{3cm}
        % Aquí va el título de la portada
        {\scshape\Huge \tituloportada \par}
        \vspace{1pt}
        {\itshape\Large \nombredelcurso~\codigodelcurso \par}
        \vfill
        % Aquí va la tabla resumen
        \begin{minipage}{1.0\linewidth}
            \begin{flushright}
                \tablaautor
            \end{flushright}
        \end{minipage}
    \end{titlepage}
    \pagestyle{fancy}
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
}

\newcommand{\indice}{% Comando para iniciar el índice
    \setpagemargincm{\firstpagemarginleft}{\pagemargintop}{\firstpagemarginright}{\pagemarginbottom}
    \tableofcontents
}

\newcommand{\contenidoconfig}{% Comando para iniciar las configuraciones iniciales del contenido
    % Setea los márgenes de la página
    \setpagemargincm{\pagemarginleft}{\pagemargintop}{\pagemarginright}{\pagemarginbottom}
    % Setea el header/footer
    \setheaderfooter
    \mainmatter % Enumerar con números
}

