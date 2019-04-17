Test for https://github.com/rstudio/shiny/issues/2385

Run this test using `rmarkdown::run("index.Rmd")`. If you're running R from the terminal (not RStudio), you'll need to make sure that the `RSTUDIO_PANDOC` environment variable is defined, or that pandoc is on your system path. On Mac, it's like this:

```
RSTUDIO_PANDOC=/Applications/RStudio.app/Contents/MacOS/pandoc R --quiet -e 'rmarkdown::run("index.Rmd", shiny_args = list(launch.browser=TRUE))'
```
