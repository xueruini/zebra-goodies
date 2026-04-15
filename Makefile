TARGET = zebra
OUTPUT = out
DEMO   = $(TARGET)-demo-twocol

all:
	latexmk $(TARGET).dtx

# Package for CTAN upload
ctan: all
	rm -rf $(TARGET) $(TARGET).zip
	mkdir -p $(TARGET)
	cp README.md $(TARGET).dtx $(OUTPUT)/$(TARGET).ins $(OUTPUT)/$(TARGET).pdf $(TARGET)/
	zip -r $(TARGET).zip $(TARGET)
	rm -rf $(TARGET)

# Build and open the PDF viewer
view: all
	latexmk -pv $(TARGET).dtx

clean:
	rm -rf $(OUTPUT)
	rm -f $(TARGET).sty $(TARGET)-goodies.sty $(TARGET).ins $(DEMO).*
	rm -f $(TARGET).aux $(TARGET).glo $(TARGET).gls $(TARGET).idx $(TARGET).ilg $(TARGET).log $(TARGET).out $(TARGET).toc $(TARGET).tmp $(TARGET).hd $(TARGET).dvi

# Run regression tests (3 pdflatex passes each)
TESTS = $(wildcard tests/*.tex)

test: all
	@cp $(OUTPUT)/$(TARGET).sty . && \
	pass=true; \
	for f in $(TESTS); do \
	  echo "=== $$f ===" && \
	  name=$$(basename $$f .tex) && \
	  rm -f $(OUTPUT)/$$name.aux $(OUTPUT)/$$name.toc \
	        $(OUTPUT)/$$name.lof $(OUTPUT)/$$name.lot $(OUTPUT)/$$name.out && \
	  for i in 1 2 3; do \
	    if pdflatex -halt-on-error -interaction=nonstopmode \
	         -output-directory=$(OUTPUT) $$f 2>&1 \
	       | grep -qi 'undefined.*zebranote\|error!'; then \
	      echo "  FAIL (pass $$i)" && pass=false; \
	    fi; \
	  done; \
	done; \
	$$pass && echo "All tests passed." || (echo "Some tests FAILED." && exit 1)

dist-clean: clean
	rm -rf $(TARGET) $(TARGET).zip

.PHONY: all view ctan clean dist-clean test
