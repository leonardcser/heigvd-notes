MD_FILE = ist_formulaire.md
TEMPLATE = templates/template.tex
OUTPUT = ist_formulaire.pdf

# Default target: watch for changes
default:
	@echo "$(MD_FILE)\n$(TEMPLATE)" | entr -cs 'make build'

# Build target: generate the PDF
build:
	pandoc -o $(OUTPUT) --template=$(TEMPLATE) --listings $(MD_FILE)

