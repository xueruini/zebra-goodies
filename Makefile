TARGET = zebra-goodies
OUTPUT = out
DESTFS = README.md $(TARGET).dtx $(OUTPUT)/$(TARGET).pdf

all: $(TARGET).pdf

sty:
	tex $(TARGET).dtx

$(TARGET).pdf: FORCE_MAKE
	latexmk $(TARGET).dtx

ctan: dist-clean all
	mkdir -p $(TARGET)
	ln $(DESTFS) $(TARGET)
	zip -r $(TARGET) $(TARGET)
	rm -rf $(TARGET)

clean:
	latexmk -C $(TARGET).dtx

dist-clean: clean
	rm -rf $(TARGET) $(OUTPUT) $(TARGET).zip

.PHONY: all sty ctan clean dist-clean FORCE_MAKE
