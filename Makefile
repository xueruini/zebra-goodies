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
	        $(OUTPUT)/$$name.lof $(OUTPUT)/$$name.lot $(OUTPUT)/$$name.out \
	        $(OUTPUT)/$$name.log $(OUTPUT)/$$name.pass*.log && \
	  for i in 1 2 3; do \
	    if ! pdflatex -halt-on-error -interaction=nonstopmode \
	         -output-directory=$(OUTPUT) $$f \
	         > $(OUTPUT)/$$name.pass$$i.log 2>&1; then \
	      echo "  FAIL (pdflatex pass $$i)" && pass=false; \
	    fi; \
	  done && \
	  if grep -qi '^!\|LaTeX Error\|Emergency stop\|Float(s) lost\|undefined.*zebranote' \
	       $(OUTPUT)/$$name.log; then \
	    echo "  FAIL (LaTeX error in final log)" && pass=false; \
	  fi && \
	  if grep -qi 'undefined references' $(OUTPUT)/$$name.log; then \
	    echo "  FAIL (undefined references after 3 passes)" && pass=false; \
	  fi && \
	  if grep -qi 'has been referenced but does not exist\|missing destination' \
	       $(OUTPUT)/$$name.log; then \
	    echo "  FAIL (missing destination in final log)" && pass=false; \
	  fi && \
	  if grep -qi 'Token not allowed in a PDF string' $(OUTPUT)/$$name.log; then \
	    echo "  FAIL (PDF-string warning in final log)" && pass=false; \
	  fi && \
	  if test "$$name" = "pdfstring" && test -f $(OUTPUT)/$$name.out && \
	       grep -q 'PDFSTRING-' $(OUTPUT)/$$name.out; then \
	    echo "  FAIL (note body leaked into PDF bookmark)" && pass=false; \
	  fi && \
	  if grep -qi 'multiply-defined labels' $(OUTPUT)/$$name.log && \
	       test "$$name" != "identity"; then \
	    echo "  FAIL (unexpected multiply-defined labels)" && pass=false; \
	  fi && \
	  if grep -q 'Package zebra Warning' $(OUTPUT)/$$name.log; then \
	    case "$$name" in \
	      identity|template-acm-sigconf|template-ieee-conference|template-llncs) ;; \
	      *) echo "  FAIL (unexpected zebra warning)" && pass=false ;; \
	    esac; \
	  fi; \
	done; \
	$$pass && echo "All tests passed." || (echo "Some tests FAILED." && exit 1)

dist-clean: clean
	rm -rf $(TARGET) $(TARGET).zip

.PHONY: all view ctan clean dist-clean test
