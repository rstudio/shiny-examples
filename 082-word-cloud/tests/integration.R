
library(shiny)
tests <- list.files("./integration", full.names=TRUE)
lapply(tests, source)
