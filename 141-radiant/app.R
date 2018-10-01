
# install.packages("radiant", repos = "https://radiant-rstats.github.io/minicran/")

library(radiant)

# radiant::radiant()
shiny::shinyAppDir(system.file("app", package = "radiant"))
