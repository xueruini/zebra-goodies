TARGET = zebra-goodies
SOURCE = README.md zebra-goodies.sty

all: ctan

ctan: clean
	@mkdir -p $(TARGET)
	@ln $(SOURCE) $(TARGET)
	@zip -r $(TARGET) $(TARGET)
	@rm -rf $(TARGET)

clean:
	@rm -rf $(TARGET) $(TARGET).zip

.PHONY: all ctan clean
