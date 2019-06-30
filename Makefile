TARGET = zebra-goodies
DESTFS = README.md $(TARGET).sty $(TARGET).pdf

all: $(TARGET).pdf

sty: FORCE_MAKE
	tex $(TARGET).dtx

$(TARGET).pdf: FORCE_MAKE
	latexmk $(TARGET).dtx

ctan: clean all
	@mkdir -p $(TARGET)
	@ln $(DESTFS) $(TARGET)
	@zip -r $(TARGET) $(TARGET)
	@rm -rf $(TARGET)

clean:
	@rm -rf $(TARGET) $(TARGET).zip
	latexmk -c $(TARGET).dtx

.PHONY: all ctan clean FORCE_MAKE
