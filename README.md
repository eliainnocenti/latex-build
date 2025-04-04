# LaTeX Build Environment Setup

This repository provides a modular build environment for LaTeX projects using a Makefile and a configuration file. It is designed to be used either as a **submodule** in your LaTeX project or as a standalone directory that you can clone or download.

## Use Cases

1. **As a Submodule**: Add this repository as a submodule to your LaTeX project to maintain a shared build environment across multiple projects.
2. **As a Standalone Directory**: Clone or download this repository and use it directly in your LaTeX project.

## File Structure

```
project/
├── latex-build/       # Contains the build scripts and templates
├── local.mk           # Project-specific configuration (created during setup)
├── main.tex           # Your main LaTeX file
├── references.bib     # Optional bibliography file
└── out/               # Output directory for generated files (default)
```

## Setup Instructions

### Option 1: Using as a Submodule

1. Navigate to your LaTeX project directory:
   ```bash
   cd /path/to/your/project
   ```

2. Add this repository as a submodule:
   ```bash
   git submodule add https://github.com/eliainnocenti/latex-build.git
   git submodule update --init --recursive
   ```

3. Follow the steps in the **Project Environment Setup** section below.

### Option 2: Using as a Standalone Directory

1. Clone or download this repository into your LaTeX project directory:
   ```bash
   git clone https://github.com/eliainnocenti/latex-build.git
   ```

2. Follow the steps in the **Project Environment Setup** section below.

### Differences Between Submodule and Standalone Usage

| Feature                     | Submodule Usage                          | Standalone Usage                       |
|-----------------------------|------------------------------------------|----------------------------------------|
| **Version Control**         | Tracks updates to `latex-build` as part of your project. | Independent of your project.           |
| **Updates**                 | Use `git submodule update` to pull updates. | Manually pull updates from the repo.   |
| **Portability**             | Requires Git submodule support.          | Works without Git submodules.          |

## Configuration Options in `local.mk`

The `local.mk` file contains all the project-specific configuration options. Below is a detailed explanation of each option:

### General Settings

- **`LATEX`**:  
  The command used to compile LaTeX files (default: `pdflatex`).  
  Example:  
  ```makefile
  LATEX = pdflatex
  ```

- **`BIBTEX`**:  
  The command used to process bibliography files (default: `bibtex`). Leave empty if not using a bibliography.  
  Example:  
  ```makefile
  BIBTEX = bibtex
  ```

- **`MAIN_TEX`**:  
  The main LaTeX source file for your project. This is the entry point for your LaTeX document.  
  Example:  
  ```makefile
  MAIN_TEX = main.tex
  ```

- **`OUTPUT_PDF`**:  
  The desired name for the generated PDF file.  
  Example:  
  ```makefile
  OUTPUT_PDF = mypaper.pdf
  ```

- **`BIB_FILE`**:  
  The bibliography file used in your project. Leave empty if your project does not use a bibliography.  
  Example:  
  ```makefile
  BIB_FILE = references.bib
  ```

- **`OUTPUT_DIR`**:  
  The directory where all intermediate and final output files will be stored.  
  Example:  
  ```makefile
  OUTPUT_DIR = out
  ```

### Advanced Settings

- **`COPY_SPECIFIC`**:  
  Enable or disable copying the output PDF to a specific directory with a specific name. Set this to `true` to enable the feature.  
  Example:  
  ```makefile
  COPY_SPECIFIC = true
  ```

- **`SPECIFIC_DIR`**:  
  The directory where the renamed PDF should be copied. This is only used if `COPY_SPECIFIC` is set to `true`.  
  Example:  
  ```makefile
  SPECIFIC_DIR = final
  ```

- **`SPECIFIC_PDF`**:  
  The new name for the PDF file in the `SPECIFIC_DIR`. This is only used if `COPY_SPECIFIC` is set to `true`.  
  Example:  
  ```makefile
  SPECIFIC_PDF = final_output.pdf
  ```

## Project Environment Setup

### 1. Initialize Configuration

From the **project root**, run the following command to create a local configuration file:

```bash
make -C latex-build init
```

- This command checks if a file named `local.mk` exists in the project root.
- If not, it copies the template file (`latex-build/template.mk`) to `local.mk`.
- The script will display a message prompting you to update the file.

### 2. Update `local.mk`

Open `local.mk` in the project root and update the settings based on your project requirements. Refer to the **Configuration Options** section above for details.

### 3. Build Your Document

With your configuration in place, compile your LaTeX project by running:

```bash
make -C latex-build
```

This command will:
- Run `pdflatex` on your main file.
- Check for the presence of your bibliography file and run `bibtex` if it exists.
- Run additional `pdflatex` passes to resolve all references.
- Rename the resulting PDF to match the value of `OUTPUT_PDF`.
- If `COPY_SPECIFIC` is enabled, copy the PDF to `SPECIFIC_DIR` with the name `SPECIFIC_PDF`.

### 4. Clean Auxiliary Files

To remove auxiliary files generated during compilation, run:

```bash
make -C latex-build clean
```

This command will:
- Remove all files in the `OUTPUT_DIR`.
- If `COPY_SPECIFIC` is enabled, remove the file specified by `SPECIFIC_PDF` in `SPECIFIC_DIR`.

### 5. Update `local.mk` with New Template Changes

If the `template.mk` file is updated (e.g., new configuration options are added), you can update your `local.mk` file without losing your custom settings. Use the following command:

```bash
make -C latex-build update-local
```

This command will:
- Compare `template.mk` with your existing `local.mk`.
- Add any new variables from `template.mk` to `local.mk`.
- Preserve your custom values for existing variables in `local.mk`.

#### Example

Suppose your `template.mk` file is updated to include a new variable:

```makefile
NEW_OPTION = default_value
```

And your current `local.mk` looks like this:

```makefile
MAIN_TEX = main.tex
OUTPUT_PDF = mypaper.pdf
```

After running `make -C latex-build update-local`, your `local.mk` will be updated to:

```makefile
MAIN_TEX = main.tex
OUTPUT_PDF = mypaper.pdf
NEW_OPTION = default_value
```

This ensures that your custom settings remain intact while incorporating new options from the template.

## Summary

- **Submodule Usage**: Ideal for maintaining a shared build environment across multiple projects.
- **Standalone Usage**: Suitable for quick setups or projects without Git submodules.
- **Key Files**:
  - **latex-build/Makefile**: Contains the build logic and an `init` target.
  - **latex-build/template.mk**: Template for your local configuration.
  - **local.mk**: Project-specific configuration (created in the project root via `make -C latex-build init`).

This modular approach allows you to streamline your LaTeX workflow while keeping project-specific settings separate. Enjoy a hassle-free LaTeX build process!

## Author

Elia Innocenti  
GitHub: [@eliainnocenti](https://github.com/eliainnocenti)  
Email: [elia.innocenti@studenti.polito.it](mailto:elia.innocenti@studenti.polito.it)
