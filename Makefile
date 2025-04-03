# Makefile in latex-build/

# Author: Elia Innocenti
# GitHub: @eliainnocenti
# Email: elia.innocenti@studenti.polito.it

# Check for local configuration file in the project root, except for the "init" and ".copy-and-update" targets.
ifneq ($(filter init .copy-and-update,$(MAKECMDGOALS)),)
# Skip the local.mk check for these targets.
else
ifeq ("$(wildcard ../local.mk)","")
$(error "local.mk not found in the root directory. Please run 'make -C latex-build init' to create a template local.mk file.")
endif
endif

# Include the local configuration (defines MAIN_TEX, OUTPUT_PDF, BIB_FILE, OUTPUT_DIR)
-include ../local.mk

# Define commands for LaTeX and BibTeX.
LATEX  := pdflatex
BIBTEX := bibtex

# Default target: build the output PDF.
all: $(OUTPUT_DIR)/$(OUTPUT_PDF)

# Build rule for the output PDF.
$(OUTPUT_DIR)/$(OUTPUT_PDF): $(MAIN_TEX)
	@mkdir -p $(OUTPUT_DIR)
	@echo "Compiling ../$(MAIN_TEX) to generate $(OUTPUT_DIR)/$(OUTPUT_PDF)..."
	$(LATEX) -output-directory=$(OUTPUT_DIR) ../$(MAIN_TEX)
	@if [ -f "../$(BIB_FILE)" ]; then \
		echo "Bibliography file found, running bibtex..."; \
		$(BIBTEX) $(OUTPUT_DIR)/$(basename $(MAIN_TEX)); \
		$(LATEX) -output-directory=$(OUTPUT_DIR) ../$(MAIN_TEX) \
	fi
	$(LATEX) -output-directory=$(OUTPUT_DIR) ../$(MAIN_TEX)
	@echo "Build complete: $(OUTPUT_DIR)/$(OUTPUT_PDF) created."
	@if [ "$(COPY_SPECIFIC)" = "true" ] && [ -n "$(SPECIFIC_DIR)" ] && [ -n "$(SPECIFIC_PDF)" ]; then \
		mkdir -p ../$(SPECIFIC_DIR); \
		cp $(OUTPUT_DIR)/$(OUTPUT_PDF) ../$(SPECIFIC_DIR)/$(SPECIFIC_PDF); \
		echo "Copied $(OUTPUT_DIR)/$(OUTPUT_PDF) to ../$(SPECIFIC_DIR)/$(SPECIFIC_PDF)."; \
	fi

# Clean auxiliary files.
clean:
	@echo "Cleaning up auxiliary files in $(OUTPUT_DIR)..."
	@rm -rf $(OUTPUT_DIR)
	@if [ "$(COPY_SPECIFIC)" = "true" ] && [ -n "$(SPECIFIC_DIR)" ] && [ -n "$(SPECIFIC_PDF)" ]; then \
		if [ -f "../$(SPECIFIC_DIR)/$(SPECIFIC_PDF)" ]; then \
			rm -f ../$(SPECIFIC_DIR)/$(SPECIFIC_PDF); \
			echo "Removed ../$(SPECIFIC_DIR)/$(SPECIFIC_PDF)."; \
		fi \
	fi

# Command to check if required tools are available.
check-tools:
	@echo "Checking required tools..."
	@if ! command -v $(LATEX) >/dev/null 2>&1; then \
		echo "Error: $(LATEX) is not installed or not in PATH."; \
		exit 1; \
	else \
		echo "$(LATEX) is available."; \
		$(LATEX) --version | head -n 1; \
	fi
	@if [ -n "$(BIBTEX)" ]; then \
		if ! command -v $(BIBTEX) >/dev/null 2>&1; then \
			echo "Error: $(BIBTEX) is not installed or not in PATH."; \
			exit 1; \
		else \
			echo "$(BIBTEX) is available."; \
			$(BIBTEX) --version | head -n 1; \
		fi \
	fi

# Internal helper function to copy and update the template configuration file.
# This function removes the second line of the template.mk file and creates a new local.mk file.
.copy-and-update:
	@echo "Copying template.mk to create ../local.mk..."
	@cp template.mk ../local.mk
	@sed -i '' '2d' ../local.mk
	@echo "Template local.mk created. Please update ../local.mk with your project's details."

# The "init" target copies the template configuration to the project root.
init:
	@if [ -f ../local.mk ]; then \
		echo "local.mk already exists in the root directory."; \
	else \
		$(MAKE) .copy-and-update; \
	fi
	@$(MAKE) check-tools >/dev/null || (echo "Error: Required tools are missing. Please install them and try again." && exit 1)

.PHONY: all clean init check-tools
