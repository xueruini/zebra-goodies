# zebra-goodies

A collection of handy note-taking macros such as `todo` and `comment`. It is
primarily intended for draft and review workflows.

## Options

- `draft`: boolean option, whether to show the notes. Enabled by default. Example to disable it:
    ```latex
    \usepackage[draft=false]{zebra-goodies}
    % or use the complementary option "final"
    \usepackage[final]{zebra-goodies}
    ```
- `microtypeexpansion`: boolean option, whether to enable `microtype` font expansion. Enabled by default. `zebra-goodies` ensures `microtype` is loaded. Example to disable expansion while keeping `microtype` loaded:
    ```latex
    \usepackage[microtypeexpansion=false]{zebra-goodies}
    % or use the complementary option "nomicrotypeexpansion"
    \usepackage[nomicrotypeexpansion]{zebra-goodies}
    ```
    Engines without font expansion support still fall back to `expansion=false` automatically.
- `hyperref`: boolean option, whether to load package `hyperref`. Enabled by default. Example to disable it:
    ```latex
    \usepackage[hyperref=false]{zebra-goodies}
    % or use the complementary option "nohyperref"
    \usepackage[nohyperref]{zebra-goodies}
    ```
- `listofnotes`: boolean option, whether to print the summary table and detailed note list at the end of the document. Enabled by default. Example to disable it:
    ```latex
    \usepackage[listofnotes=false]{zebra-goodies}
    % or use the complementary option "nolistofnotes"
    \usepackage[nolistofnotes]{zebra-goodies}
    ```

## Take Notes

Add comments, todos, and notes during drafting in a visible way. The package
also prints a summary table and a detailed note list at the end of the document.
The predefined commands are:

```latex
\todo[<who>]{bla bla}
\fixed[<who>]{bla bla}
\comment[<who>]{bla bla}
\note[<who>]{bla bla}
\placeholder[<who>]{bla bla}
```

If any of these short names does not work, it is very likely that another
package has already defined it. `zebra-goodies` does not overwrite existing
commands, so use the always-available prefixed forms instead:

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

Several colors are provided via `xcolor` for plotting:
- `zebrablue`
- `zebrared`
- `zebrayellow`
- `zebrapurple`
- `zebragreen`

## Author

Ruini Xue <xueruini@gmail.com>

## License

Copyright (C) 2016-2026, Ruini Xue

This work may be distributed and/or modified under the conditions of
the LaTeX Project Public License (LPPL), version 1.3c. The latest
version of this license is at:

http://www.latex-project.org/lppl.txt

This work is "maintained" (as per LPPL maintenance status) by Ruini Xue.
