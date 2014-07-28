# Chooser demo

Demonstrates creating a custom Shiny input binding for a simple JavaScript-enabled "dueling select box" input widget.

Run this example by calling:

`shiny::runGitHub("shiny-js-examples", "jcheng5", subdir="input")`

## Implementation

`chooser.R` contains reusable R function `chooserInput` that can be used in `ui.R`. It also registers an input handler with Shiny to reshape the data into a nicer form before handing it over to the app's server side R code.

The file `www/chooser-binding.js` contains the JavaScript code that defines a custom Shiny input binding for the chooser, as well as the implementation of the chooser itself. It's loaded into the app implicitly by the `chooserInput` function.

## Packaging note

This example is set up for easy reading of the code and easy running via `shiny::runGitHub()`.

If instead we wanted to make this line chart component easily distributable to other Shiny users, we would set it up as a package. `chooser.R` would go into the `R` subdirectory. The contents of `www` would be moved to `inst`, and `chooserInput` would call `shiny::addResourcePath` to make them available at a URL prefix like `"chooser"`. See [shiny-incubator](https://github.com/rstudio/shiny-incubator) for one example.
