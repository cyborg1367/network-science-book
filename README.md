# Network Science

Quarto book for a Network Science course, with both HTML and PDF output.

## Project structure

-   `_quarto.yml`: student book configuration
-   `index.qmd`: landing page and course overview
-   `chapters/01-preface.qmd`: course preface and reader guide
-   `chapters/`: chapter source files (student-facing)
-   `instructor/solutions/`: instructor solution source (one `.qmd` per chapter)
-   `instructor/_quarto.yml`: separate instructor-only book project
-   `R/book-setup.R`: shared R setup helpers for package loading, plotting theme, and chunk defaults
-   `renv.lock`: reproducible package lockfile
-   `renv/`: project-local renv infrastructure
-   `styles.scss`: book-specific visual theme overrides
-   `references.bib`: bibliography for cited chapters
-   `docs/`: rendered student site output
-   `instructor-docs/`: rendered instructor solutions (HTML and PDF)

## Setup

Open the project in RStudio and install the required packages once:

``` r
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")
renv::restore()
tinytex::install_tinytex()
```

This restores the project library from `renv.lock` and keeps the book reproducible across machines. The shared helper in `R/book-setup.R` is still used by the chapters themselves.

## Render

### Student book

From R:

``` r
quarto::quarto_render()
```

Or use the Quarto Render button in RStudio. Output goes to `docs/`.

### Instructor solutions manual

The solutions live in a **separate Quarto book** and are not included in the student build.

From R:

``` r
quarto::quarto_render("instructor")
```

Or from the shell:

``` bash
quarto render instructor
```

Output goes to `instructor-docs/`. Commit this folder when you want the rendered solutions on GitHub. If the student site is public, do not deploy `instructor-docs/` to the same URL as `docs/`.

## Adding or updating chapters

1.  Create or edit files in `chapters/`.
2.  Add the chapter file to `_quarto.yml` under `book: chapters:`.
3.  If the chapter needs shared setup, source `R/book-setup.R` in the setup chunk and call `ns_book_setup(...)`.
4.  Add or update the matching file in `instructor/solutions/` and list it in `instructor/_quarto.yml`.
5.  Render the student book and, when solutions change, render the instructor book.

## Maintenance notes

-   Keep `README.md`, `index.qmd`, and `_quarto.yml` in sync when chapter order changes.
-   Prefer `renv::restore()` for environment setup rather than ad hoc package installation.
-   If a chapter cites references, keep `references.bib` in version control.
-   Shared package lists, palettes, and plotting defaults should live in `R/book-setup.R` rather than being duplicated per chapter.
