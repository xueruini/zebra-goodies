MAIN    = $(shell find ./ -maxdepth 1 -type f -name "*.tex" -exec basename {} \;)
PICS    = $(shell ls figures/*.pdf figures/*.tex)
BIBFILE = zebra-latex-goodies/zebra.bib
OTHER   = zebra-latex-goodies/zebra.sty
DEP     = $(PICS) $(BIBFILE) $(OTHER)
TRG     = $(MAIN:%.tex=%.pdf)

LATEXMK = latexmk
# use pdflatex
LATEXMKOPT = -pdf
# use xelatex
# LATEXMKOPT = -xelatex

all: $(TRG)

$(TRG): $(MAIN) $(DEP)
	$(LATEXMK) $(LATEXMKOPT) $(MAIN)

clean:
	$(LATEXMK) -C $(MAIN)

# for mac
view: $(TRG)
	open $(TRG)

.PHONY: all view clean
