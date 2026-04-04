# Shared setup helpers for the Network Science Quarto book.

ns_book_packages <- function() {
  unique(c(
    "igraph",
    "dplyr",
    "ggplot2",
    "tidyr",
    "purrr",
    "plotly",
    "ggraph",
    "tibble",
    "scales",
    "patchwork",
    "tidyverse",
    "ragg",
    "tinytex",
    "quarto"
  ))
}

ns_package_profile <- function(profile = c("core", "interactive", "advanced", "index")) {
  profile <- match.arg(profile)

  switch(
    profile,
    core = c("igraph", "dplyr", "ggplot2", "tidyr", "purrr"),
    interactive = c("igraph", "dplyr", "ggplot2", "tidyr", "purrr", "plotly"),
    advanced = c("igraph", "dplyr", "ggplot2", "tidyr", "purrr", "tibble", "scales"),
    index = "ggplot2"
  )
}

ns_install_packages <- function(pkgs = ns_book_packages()) {
  install.packages(pkgs)
  invisible(pkgs)
}

ns_load_packages <- function(pkgs) {
  missing_pkgs <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]

  if (length(missing_pkgs) > 0) {
    stop(
      paste0(
        "Missing required packages: ",
        paste(missing_pkgs, collapse = ", "),
        ".\nRun:\n",
        "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv')\n",
        "renv::restore()\n",
        "\nIf you are not using renv, run:\n",
        "source('R/book-setup.R')\n",
        "ns_install_packages()"
      ),
      call. = FALSE
    )
  }

  invisible(lapply(
    pkgs,
    function(pkg) {
      suppressPackageStartupMessages(
        library(pkg, character.only = TRUE)
      )
    }
  ))
}

ns_course_palette <- function(preset = c("core", "random", "evolution", "smallworld", "advanced", "index")) {
  preset <- match.arg(preset)

  switch(
    preset,
    core = list(
      teal = "#0F766E",
      blue = "#0EA5E9",
      gold = "#F59E0B",
      warm = "#D97706",
      ink = "#1F2937",
      slate = "#475569",
      grid = "#E5E7EB"
    ),
    random = list(
      teal = "#0F766E",
      blue = "#0EA5E9",
      gold = "#F59E0B",
      warm = "#D97706",
      ink = "#1F2937",
      slate = "#475569",
      grid = "#E5E7EB"
    ),
    evolution = list(
      teal = "#0F766E",
      blue = "#2563EB",
      gold = "#F59E0B",
      coral = "#E76F51",
      ink = "#1F2937",
      grid = "#E5E7EB"
    ),
    smallworld = list(
      teal = "#0F766E",
      blue = "#0EA5E9",
      gold = "#F59E0B",
      warm = "#D97706",
      ink = "#1F2937",
      slate = "#475569",
      grid = "#E5E7EB"
    ),
    advanced = list(
      teal = "#0F766E",
      blue = "#0EA5E9",
      gold = "#F59E0B",
      warm = "#D97706",
      ink = "#1F2937",
      slate = "#475569",
      grid = "#E5E7EB",
      coral = "#F97316",
      rose = "#DC2626",
      violet = "#7C3AED"
    ),
    index = list(
      ink = "#1F2937"
    )
  )
}

ns_course_theme <- function(course_cols, preset = c("core", "random", "evolution", "smallworld", "advanced", "index")) {
  preset <- match.arg(preset)

  base_theme <- ggplot2::theme_minimal(base_size = 13)

  if (preset == "index") {
    return(
      base_theme +
        ggplot2::theme(
          plot.title.position = "plot",
          panel.grid.minor = ggplot2::element_blank()
        )
    )
  }

  if (preset == "core") {
    return(
      base_theme +
        ggplot2::theme(
          plot.title.position = "plot",
          plot.caption.position = "plot",
          panel.grid.minor = ggplot2::element_blank(),
          panel.grid.major.x = ggplot2::element_line(color = course_cols$grid, linewidth = 0.35),
          panel.grid.major.y = ggplot2::element_line(color = course_cols$grid, linewidth = 0.35),
          axis.title = ggplot2::element_text(color = course_cols$ink, face = "plain"),
          axis.text = ggplot2::element_text(color = course_cols$ink),
          axis.ticks = ggplot2::element_line(color = course_cols$grid, linewidth = 0.3),
          plot.title = ggplot2::element_text(face = "bold", color = course_cols$ink, size = ggplot2::rel(1.12)),
          plot.subtitle = ggplot2::element_text(color = course_cols$slate, margin = ggplot2::margin(b = 10)),
          plot.caption = ggplot2::element_text(color = course_cols$slate, hjust = 1, size = ggplot2::rel(0.86)),
          legend.position = "top",
          legend.title = ggplot2::element_text(color = course_cols$ink, face = "bold"),
          legend.text = ggplot2::element_text(color = course_cols$slate),
          strip.text = ggplot2::element_text(face = "bold", color = course_cols$ink),
          strip.background = ggplot2::element_rect(fill = scales::alpha(course_cols$blue, 0.08), color = NA),
          plot.background = ggplot2::element_rect(fill = "white", color = NA),
          panel.background = ggplot2::element_rect(fill = "white", color = NA),
          plot.margin = ggplot2::margin(10, 12, 8, 6)
        )
    )
  }

  if (preset == "random") {
    return(
      ns_course_theme(course_cols, preset = "core") +
        ggplot2::theme(
          legend.key.width = grid::unit(1.2, "lines")
        )
    )
  }

  if (preset == "evolution") {
    return(
      base_theme +
        ggplot2::theme(
          plot.title.position = "plot",
          panel.grid.minor = ggplot2::element_blank(),
          panel.grid.major.x = ggplot2::element_line(color = course_cols$grid, linewidth = 0.35),
          panel.grid.major.y = ggplot2::element_line(color = course_cols$grid, linewidth = 0.35),
          axis.title = ggplot2::element_text(color = course_cols$ink),
          axis.text = ggplot2::element_text(color = course_cols$ink),
          plot.title = ggplot2::element_text(face = "bold", color = course_cols$ink),
          plot.subtitle = ggplot2::element_text(color = "#475569"),
          legend.position = "top"
        )
    )
  }

  if (preset == "smallworld") {
    return(
      base_theme +
        ggplot2::theme(
          plot.title.position = "plot",
          panel.grid.minor = ggplot2::element_blank(),
          panel.grid.major.x = ggplot2::element_line(color = course_cols$grid, linewidth = 0.35),
          panel.grid.major.y = ggplot2::element_line(color = course_cols$grid, linewidth = 0.35),
          axis.title = ggplot2::element_text(color = course_cols$ink),
          axis.text = ggplot2::element_text(color = course_cols$ink),
          plot.title = ggplot2::element_text(face = "bold", color = course_cols$ink),
          plot.subtitle = ggplot2::element_text(color = course_cols$slate),
          legend.position = "top"
        )
    )
  }

  base_theme +
    ggplot2::theme(
      plot.title.position = "plot",
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(color = course_cols$grid, linewidth = 0.35),
      panel.grid.major.y = ggplot2::element_line(color = course_cols$grid, linewidth = 0.35),
      axis.title = ggplot2::element_text(color = course_cols$ink),
      axis.text = ggplot2::element_text(color = course_cols$ink),
      plot.title = ggplot2::element_text(face = "bold", color = course_cols$ink),
      plot.subtitle = ggplot2::element_text(color = course_cols$slate),
      legend.position = "top",
      legend.title = ggplot2::element_text(color = course_cols$ink),
      legend.text = ggplot2::element_text(color = course_cols$ink)
    )
}

ns_book_setup <- function(
  preset = c("core", "random", "evolution", "smallworld", "advanced", "index"),
  packages = NULL,
  seed = NULL,
  chunk_options = NULL,
  envir = parent.frame()
) {
  preset <- match.arg(preset)

  if (is.null(packages)) {
    packages <- switch(
      preset,
      core = ns_package_profile("core"),
      random = ns_package_profile("interactive"),
      evolution = ns_package_profile("core"),
      smallworld = ns_package_profile("core"),
      advanced = ns_package_profile("advanced"),
      index = ns_package_profile("index")
    )
  }

  ns_load_packages(packages)

  if (!is.null(chunk_options)) {
    do.call(knitr::opts_chunk$set, chunk_options)
  }

  course_cols <- ns_course_palette(preset)
  assign("course_cols", course_cols, envir = envir)
  ggplot2::theme_set(ns_course_theme(course_cols, preset = preset))

  if (!is.null(seed)) {
    set.seed(seed)
  }

  invisible(course_cols)
}
