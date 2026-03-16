TARGET = zebra-goodies
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
	rm -f $(TARGET).sty $(TARGET).ins $(DEMO).tex $(TARGET).log

dist-clean: clean
	rm -rf $(TARGET) $(TARGET).zip

.PHONY: all view ctan clean dist-clean
