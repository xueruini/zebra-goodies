# zebra-goodies

Inline note-taking macros (`\todo`, `\comment`, `\fixed`, `\note`, `\placeholder`)
for collaborative paper writing. Notes are colour-coded, numbered, and marked in
the margin. A summary table and clickable note list are appended at the end of the
document. The `final` option suppresses all notes for clean output.

## Options

- `draft` / `final`: show or suppress notes. Default: `draft`.
    ```latex
    \usepackage[final]{zebra-goodies}
    ```
- `symbol`: global margin symbol. Default: `\textdbend`.
    ```latex
    \usepackage[symbol=\textdagger]{zebra-goodies}
    ```
- `microtypeexpansion` / `nomicrotypeexpansion`: enable or disable `microtype` font expansion. Default: enabled.
    ```latex
    \usepackage[nomicrotypeexpansion]{zebra-goodies}
    ```
- `hyperref` / `nohyperref`: load or skip `hyperref`. Default: enabled.
    ```latex
    \usepackage[nohyperref]{zebra-goodies}
    ```
- `listofnotes` / `nolistofnotes`: print or suppress the end-of-document note list. Default: enabled.
    ```latex
    \usepackage[nolistofnotes]{zebra-goodies}
    ```

## Take Notes

```latex
\todo[<who>]{bla bla}
\fixed[<who>]{bla bla}
\comment[<who>]{bla bla}
\note[<who>]{bla bla}
\placeholder[<who>]{bla bla}
```

If a short name clashes with another package, use the prefixed form:

```latex
\zebratodo[<who>]{bla bla}
\zebrafixed[<who>]{bla bla}
\zebracomment[<who>]{bla bla}
\zebranote[<who>]{bla bla}
\zebraplaceholder[<who>]{bla bla}
```

## Define New Notes

```latex
\colorlet{mycyan}{cyan}
\zebranewnote{question}{mycyan}              % uses global symbol
\zebranewnote{question}{mycyan}[$\diamond$]  % custom symbol for this type

\question[who]{what's this?}
```

## Change Symbol of Existing Types

```latex
\zebranotesymbol{fixed}{$\surd$}
```

## Author

Ruini Xue <xueruini@gmail.com>

## License

Copyright (C) 2016-2026, Ruini Xue

This work may be distributed and/or modified under the conditions of
the LaTeX Project Public License (LPPL), version 1.3c. The latest
version of this license is at:

http://www.latex-project.org/lppl.txt

This work is "maintained" (as per LPPL maintenance status) by Ruini Xue.
