MD_FILES = ist_formulaire_1.md ist_formulaire_2.md
TEMPLATE = templates/template.tex
OUTPUTS = $(patsubst %.md,%.pdf,$(MD_FILES))

# Default target: watch for changes
default: $(OUTPUTS)
	@printf "%s\n" $(MD_FILES) $(TEMPLATE) | entr -cs 'make build'

# Build target: generate the PDF
build: $(OUTPUTS)

# Pattern rule to build a PDF from a Markdown file
%.pdf: %.md
	pandoc -o $@ --template=$(TEMPLATE) --listings $<

