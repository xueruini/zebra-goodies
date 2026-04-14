# zebra

A writing revision toolkit for LaTeX. The current release focuses on inline
note-taking, providing macros (`\todo`, `\comment`, `\fixed`, `\note`,
`\placeholder`) for collaborative writing. Notes are colour-coded, numbered,
and marked in the margin. A summary table and clickable note list are appended
at the end of the document. The `final` option suppresses all notes for clean
output.

> **Migration:** This package was previously distributed as `zebra-goodies`.
> The old name still works but prints a deprecation warning.

## Options

- `draft` / `final`: show or suppress notes. Default: `draft`.
    ```latex
    \usepackage[final]{zebra}
    ```
- `sort`: order of the detailed note list. `none` (default, document order) or `type` (grouped by note type).
    ```latex
    \usepackage[sort=type]{zebra}
    ```
- `pagelinks`: enable or disable clickable page-number links in the detailed note list. Default: enabled. Set `pagelinks=false` to disable them. The alias `nopagelinks` is also accepted.
    ```latex
    \usepackage[pagelinks=false]{zebra}
    ```
- `font-expansion`: control `microtype` font expansion, which usually improves the appearance of the document. Disable it if it conflicts with your engine or another package by setting `font-expansion=false`. The alias `nofont-expansion` is also accepted. Default: enabled. `microtype` remains loaded when expansion is disabled.
    ```latex
    \usepackage[font-expansion=false]{zebra}
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

## Refer to Notes

Labels may be placed inside note bodies with the usual `\label` command.
Standard `\ref` returns the note number, while `\zebraref` prints the note
type together with the number.

```latex
\todo{\label{zebra:intro}revise the introduction}

See Todo~\ref{zebra:intro} on p.~\pageref{zebra:intro}.
See \zebraref{zebra:intro} for the full reference.
```

Labels inside notes are unavailable in `final` mode because the notes
themselves are suppressed. For notes in moving arguments such as `\section`
and `\caption`, add a `\label` inside the note for stable cross-references.

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
