# vim: set ft=perl:

@default_files=('zebra-goodies.dtx');

$pdf_mode = 1;

$pdflatex = "pdflatex -file-line-error -halt-on-error -interaction=nonstopmode %O %S";

$out_dir="./out";

$bibtex_use = 0;

$clean_ext = "hd sty tmp ins synctex.gz xdv";

$makeindex = "makeindex -s gind.ist %O -o %D %S";
add_cus_dep('glo', 'gls', 0, 'glo2gls');
sub glo2gls {
    system("makeindex -s gglo.ist -o \"$_[0].gls\" \"$_[0].glo\"");
}
push @generated_exts, "glo", "gls";

# The main .dtx run generates zebra-goodies-demo-twocol.tex.
# When the documentation later requests the corresponding PDF, latexmk
# can build it from the generated .tex and then rerun the main document.
add_cus_dep('tex', 'pdf', 0, 'tex2pdf');
sub tex2pdf {
    return 0 unless $_[0] =~ /demo-twocol$/;
    return Run_subst(
        "pdflatex -file-line-error -halt-on-error -interaction=nonstopmode -output-directory=out %S"
    );
}
