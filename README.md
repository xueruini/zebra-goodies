# zebra-goodies

A collection of handy macros for paper writing in my group. Do remove this
package once the paper is finished.

This is not intended for general cases. Use it at your own risk.

## Options

* `draft`: boolean option, whether to show the notes. Enabled by default. Example to disable it:

```latex
\usepackage[draft=false]{zebra-goodies}
```

* `microtype`: boolean option, whether to load package `microtype`. Enabled by default.

## Take Notes

Add comments, todos, anything you like during revise in a colorful way. The package also summarizes the revise notes at the end of the document. Predefined commands are as follows:

```latex
\todo[<who>]{bla bla}
\fixed[<who>]{bla bla}
\comment[<who>]{bla bla}
\note[<who>]{bla bla}
\placeholder[<who>]{bla bla}
```

To define new note commands:

```latex
% \zebranewnote{<note name>}{<xcolor color>}
\zebranewnote{question}{red!80}

\question{what's this?}
```

## Use Colors 

Several colors are provided via `xcolor` for ploting:
- `zebrablue`
- `zebrared`
- `zebrayellow`
- `zebrapurple`
- `zebragreen`
