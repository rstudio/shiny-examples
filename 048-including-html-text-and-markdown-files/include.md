This file is include.md
=======================

The content of this file is:

* Processed with the markdown package, which transforms it into HTML.
* The output is included in the web page.

## Including code

In the .md file, R code is highlighted, and code can be included inline with backticks, as in `sum(1:10)`. However, this is *not* an .Rmd file, and the code will not be executed by knitr.

```{r}
# Some example code
x <- 12
x + 1
```
