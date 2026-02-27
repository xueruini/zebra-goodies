# vim: set ft=perl:

@default_files=('zebra-goodies.dtx');

$pdf_mode = 1;

$pdflatex = "pdflatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 %O %S";

# $xelatex = "xelatex -file-line-error -halt-on-error -interaction=nonstopmode -no-pdf -synctex=1 %O %S";
# $xdvipdfmx = "xdvipdfmx -q -E -o %D %O %S";

$out_dir="./out";

$bibtex_use = 1.5;

$clean_ext = "hd sty tmp ins synctex.gz xdv";

$makeindex = "makeindex -s gind.ist %O -o %D %S";
add_cus_dep('glo', 'gls', 0, 'glo2gls');
sub glo2gls {
    system("makeindex -s gglo.ist -o \"$_[0].gls\" \"$_[0].glo\"");
}
push @generated_exts, "glo", "gls";

# Build the two-column demo PDF before the main document.
# The main doc includes it via \includegraphics.
# The demo .tex is extracted from the .dtx by docstrip alongside the .sty.
my $demo = "zebra-goodies-demo-twocol";
if (! -f "$demo.tex" || ! -f "zebra-goodies.sty") {
    system("tex zebra-goodies.dtx") == 0
        or warn "Failed to extract files from .dtx\n";
}
if (-f "$demo.tex"
    && (! -f "out/$demo.pdf"
        || -M "out/$demo.pdf" > -M "$demo.tex"
        || -M "out/$demo.pdf" > -M "zebra-goodies.sty")) {
    system("pdflatex -interaction=nonstopmode -output-directory=out $demo.tex") == 0
        or warn "Failed to compile demo\n";
}
