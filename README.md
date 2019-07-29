shiny-examples
==============

This is a collection of Shiny examples. You can see them in action on
`http://gallery.shinyapps.io/example-name` where `example-name` is the directory
name of an example here, e.g. http://gallery.shinyapps.io/001-hello

To run the examples locally, you can install the **shiny** package in R, and
use the function `runGitHub()`. For example, to run the example `001-hello`:

```R
if (!require('shiny')) install.packages("shiny")
shiny::runGitHub("shiny-examples", "rstudio", subdir = "001-hello")
```

Or you can clone or download this repository, and use run
`shiny::runApp("001-hello")`.

Note the examples listed below depend on the [development
version](https://github.com/rstudio/shiny) of **shiny** to show some new
features under development. Please be cautious that such features may or may
not end up in the final release, or they may also change according to the
feedback.

* [None]
