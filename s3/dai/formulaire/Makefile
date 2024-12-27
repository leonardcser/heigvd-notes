MD_FILE = dai_formulaire.md
TEMPLATE = templates/template.tex
OUTPUT = dai_formulaire.pdf

# Default target: watch for changes
default:
	@echo "$(MD_FILE)\n$(TEMPLATE)" | entr -cs 'make build'

# Build target: generate the PDF
build:
	pandoc -o $(OUTPUT) --template=$(TEMPLATE) --listings $(MD_FILE)

