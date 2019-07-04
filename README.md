# zebra-goodies

A collection of handy macros for note taking, like `todo` and `comment`. This is
not intended for general cases. Use it at your own risk.

## Options

- `draft`: boolean option, whether to show the notes. Enabled by default. Example to disable it:
    ```latex
    \usepackage[draft=false]{zebra-goodies}
    % or use the complementary option "final"
    \usepackage[final]{zebra-goodies}
    ```
- `microtype`: boolean option, whether to load package `microtype`. Enabled by default.

## Take Notes

Add comments, todos, notes anything you like during revise in a colorful way.
The package also summarizes the revise notes at the end of the document.
Predefined commands are as follows:

```latex
\todo[<who>]{bla bla}
\fixed[<who>]{bla bla}
\comment[<who>]{bla bla}
\note[<who>]{bla bla}
\placeholder[<who>]{bla bla}
```

If any of them does not work, it is very likely that it has been defined by
other packages. We will not override the definition, so you have to turn to its
full version as follows:

```latex
\zebratodo[<who>]{bla bla}
\zebrafixed[<who>]{bla bla}
\zebracomment[<who>]{bla bla}
\zebranote[<who>]{bla bla}
\zebraplaceholder[<who>]{bla bla}
```

## Define new Notes

```latex
% \zebranewnote{<note name>}{<xcolor color>}

\colorlet{mycyan}{cyan}
\zebranewnote{question}{mycyan}

\question[who]{what's this?}
```

## Use Colors 

Several colors are provided via `xcolor` for ploting:
- `zebrablue`
- `zebrared`
- `zebrayellow`
- `zebrapurple`
- `zebragreen`
