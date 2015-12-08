# zebra-latex-goodies
Packages for paper writing for the group.

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
\makeatletter
  % \zebr@newnote{<note name>}{<xcolor color>}
  \zebr@newnote{question}{red!80}
\makeatother

\question{what's this?}
   ```

## Use Colors 
   Several colors is provided via `xcolor` for ploting: `zebrablue`, `zebrared`, `zebrayellow`, `zebrapurple`, and `zebragreen`.
