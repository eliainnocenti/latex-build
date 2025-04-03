# Template configuration for your LaTeX project.
# Copy this file to ../local.mk using the 'make -C latex-build init' command and update the values below.

# Specify the command for LaTeX (default: pdflatex).
# This is the tool used to compile your LaTeX source files into a PDF.
LATEX = pdflatex

# Specify the command for BibTeX (default: bibtex).
# This is the tool used to process bibliography files. Leave empty if not using BibTeX.
BIBTEX = bibtex

# Note: All file and directory paths specified below are relative to the root directory of the project. 
# For example, if MAIN_TEX is set to "main.tex", it refers to "project/main.tex" (not "project/build/main:tex").

# Specify your main LaTeX source file (e.g., mypaper.tex).
# This is the entry point for your LaTeX project. All other files are included from this file.
MAIN_TEX = main.tex

# Define the desired name for the output PDF (e.g., mypaper.pdf).
# This is the name of the PDF file generated after compilation.
OUTPUT_PDF = main.pdf

# Specify the bibliography file if your project uses one (e.g., references.bib).
# Leave this empty if your project does not use a bibliography.
BIB_FILE = 

# Specify the output directory for build files (default: out/).
# This is where all intermediate and final output files will be stored.
OUTPUT_DIR = out

# Enable or disable copying the output PDF to a specific directory with a specific name (default: false).
# Set this to "true" to enable the feature.
COPY_SPECIFIC = false

# Specify the directory where the renamed PDF should be copied (e.g., final/).
# This is the target directory for the renamed PDF. Leave empty if COPY_SPECIFIC is false.
SPECIFIC_DIR = 

# Specify the new name for the copied PDF (e.g., final_output.pdf).
# This is the new name for the PDF file in the SPECIFIC_DIR. Leave empty if COPY_SPECIFIC is false.
SPECIFIC_PDF =
