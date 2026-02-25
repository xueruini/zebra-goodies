TARGET = zebra-goodies
OUTPUT = out
DEMO   = $(TARGET)-demo-twocol

all: $(OUTPUT)/$(TARGET).pdf

# Extract .sty, .ins, and demo .tex from .dtx (all land in current dir)
$(TARGET).sty $(TARGET).ins $(DEMO).tex: $(TARGET).dtx
	tex $(TARGET).dtx

# Compile the two-column demo (finds .sty in current dir)
$(OUTPUT)/$(DEMO).pdf: $(DEMO).tex $(TARGET).sty
	latexmk -pdf -outdir=$(OUTPUT) $(DEMO).tex

# Compile the main documentation (needs the demo PDF)
$(OUTPUT)/$(TARGET).pdf: $(TARGET).dtx $(OUTPUT)/$(DEMO).pdf
	latexmk $(TARGET).dtx

# Package for CTAN upload
ctan: all
	rm -rf $(TARGET) $(TARGET).zip
	mkdir -p $(TARGET)
	cp README.md $(TARGET).dtx $(TARGET).ins $(OUTPUT)/$(TARGET).pdf $(TARGET)/
	zip -r $(TARGET).zip $(TARGET)
	rm -rf $(TARGET)

# Build and open the PDF viewer
view: all
	latexmk -pv $(TARGET).dtx

clean:
	latexmk -C $(TARGET).dtx
	latexmk -C -outdir=$(OUTPUT) $(DEMO).tex
	rm -f $(TARGET).sty $(TARGET).ins $(DEMO).tex

dist-clean: clean
	rm -rf $(TARGET) $(OUTPUT) $(TARGET).zip

.PHONY: all view ctan clean dist-clean
