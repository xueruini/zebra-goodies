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
- `sort`: order of the detailed note list. `none` (default, document order) or `type` (grouped by note type).
    ```latex
    \usepackage[sort=type]{zebra-goodies}
    ```
- `microtypeexpansion` / `nomicrotypeexpansion`: enable or disable `microtype` font expansion. Default: enabled.
    ```latex
    \usepackage[nomicrotypeexpansion]{zebra-goodies}
    ```
- `hyperref` / `nohyperref`: load or skip `hyperref`. Default: enabled.
    ```latex
    \usepackage[nohyperref]{zebra-goodies}
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
\zebranewnote{question}{mycyan}              % uses default symbol
\zebranewnote{question}{mycyan}[$\diamond$]  % custom symbol for this type

\question[who]{what's this?}
```

## Customise Existing Types

Use `\zebrasetup` to change the colour or symbol of any note type after loading:

```latex
\zebrasetup{color/todo=red}                 % red todos
\zebrasetup{symbol/fixed=$\surd$}           % tick mark for fixed notes
\zebrasetup{color/todo=red, symbol/fixed=$\surd$}  % combine several keys
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
