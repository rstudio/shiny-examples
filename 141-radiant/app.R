## CRAN
# install.packages("radiant")

## Github instructions
# install.packages("radiant", repos = "https://radiant-rstats.github.io/minicran/")

library(radiant)

## Regular execution
# radiant::radiant()

# Retrieve the underlying shinyapp in radiant
shiny::shinyAppDir(system.file("app", package = "radiant"))
