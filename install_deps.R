#!/usr/bin/env Rscript

# This script installs some development packages that are needed for various
# apps. It can be sourced from RStudio, or run with Rscript.


# Returns the file currently being sourced or run with Rscript
this_file <- function() {
  cmdArgs <- commandArgs(trailingOnly = FALSE)
  needle <- "--file="
  match <- grep(needle, cmdArgs)
  if (length(match) > 0) {
    # Rscript
    return(normalizePath(sub(needle, "", cmdArgs[match])))
  } else {
    # 'source'd via R console
    return(normalizePath(sys.frames()[[1]]$ofile))
  }
}

is_installed <- function (pkg) {
  if (system.file(package = pkg) == "")
    FALSE
  else
    TRUE
}

# Install a package or packages if not already installed.
install_if_needed <- function(pkgs) {
  installed_idx <- vapply(pkgs, is_installed, TRUE)
  needed <- pkgs[!installed_idx]
  if (length(needed) > 0) {
    message("Installing needed packages from CRAN: ", paste(needed, collapse = ", "))
    install.packages(needed)
  }
}

# Core packages
install_if_needed(c("devtools", "rsconnect", "packrat", "knitr"))

# Some packages must be installed from GitHub
devtools::install_github(c(
  # For 087-crandash
  "hadley/shinySignals",
  "jcheng5/bubbles",
  "jcheng5/googleCharts",
  "rstudio/shinyvalidate"
  # , "rstudio/shiny"
))

# Autodetect packages needed for the examples (will install from CRAN)
install_if_needed(packrat:::dirDependencies(dirname(this_file())))
