#!/usr/bin/env Rscript

args <- commandArgs(TRUE)

if (length(args) == 0) {
  cat(sep = "\n",
    "Usage: deployApp account server appdir",
    "",
    "Examples:",
    "  ./deployApp.R alan rsc.radixu.com 001-hello",
    ""
  )

  q()
}

library(rsconnect)
library(packrat)

deps <- packrat:::dirDependencies(args[[3]])
deps <- deps[!"shiny" %in% deps]
if (length(deps) > 0) install.packages(deps)

packrat::.snapshotImpl(args[[3]], snapshot.sources = FALSE)

rsconnect::deployApp(
  appDir = args[[3]],
  appName = args[[3]],
  account = args[[1]],
  server = args[[2]],
  logLevel = 'verbose',
  launch.browser = FALSE,
  forceUpdate = TRUE
)
