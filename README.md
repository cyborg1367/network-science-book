<<<<<<< HEAD
# Network Science Quarto Template

This is a Quarto **book** project designed to produce both:

-   an HTML website
-   a PDF handout/book

## Files

-   `_quarto.yml` — project configuration
-   `index.qmd` — overview page
-   `chapters/03-random-graphs.qmd` — first chapter template
-   `styles.scss` — visual theme customizations

## In RStudio

1.  Open RStudio.
2.  Go to **File \> Open Project**.
3.  Open this folder.
4.  Install packages if needed.
5.  Render with:

``` r
quarto::quarto_render()
```

or use the **Render** button.

## Required R packages

``` r
install.packages(c("igraph", "dplyr", "ggplot2", "tidyr", "purrr", "tinytex", "quarto"))
tinytex::install_tinytex()
```

## Add a new chapter

1.  Create a new file in `chapters/`, for example `04-small-world.qmd`
2.  Add it to `_quarto.yml` under `book: chapters:`
3.  Render again
=======
# network-science-book
Quarto book for the Network Science course
>>>>>>> a4230ad7aed7f1a8c182bed494ca2f515f98d768
