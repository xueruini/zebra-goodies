# Makefile.template

  A template for creating your own Makefile to compile LaTeX source.

# zebra.sty

  An all-in-one package for paper writing for the group.

## Options

* `show`: boolean option, whether to show the notes. Enabled by default. Example to disable it:

  ```latex
\usepackage[show=false]{zebra}
  ```
* `microtype`: boolean option, whether to load package `microtype`. Enabled by default.

## Take Notes

   Add comments, todos, anything you like during revise in a colorful way. The package also summarizes the revise note by the end of the document. Predefined commands are as follows:
   
   ```latex
\todo[<who>]{bla bla}
\fixed[<who>]{bla bla}
\comment[<who>]{bla bla}
\note[<who>]{bla bla}
\placeholder[<who>]{bla bla}
   ```
   Want to define new note commands? Sure:
   ```latex
% \zebranewnote{<note name>}{<xcolor color>}
\zebranewnote{question}{red!80}

\question{what's this?}
   ```

## Use Colors 
   Several colors is provided via `xcolor` for ploting: `zebrablue`, `zebrared`, `zebrayellow`, `zebrapurple`, and `zebragreen`.
