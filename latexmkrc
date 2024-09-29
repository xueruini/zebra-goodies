# vim: set ft=perl:

@default_files=('zebra-goodies.dtx');

$pdf_mode = 5;

$xelatex = "xelatex -file-line-error -halt-on-error -interaction=nonstopmode -no-pdf -synctex=1 %O %S";
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
