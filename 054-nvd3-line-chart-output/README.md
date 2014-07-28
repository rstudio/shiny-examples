# Output example

An adaptation of the [NVD3.js](http://nv3d.org/) charting library's [Simple Line Chart](http://nvd3.org/ghpages/line.html) example. Demonstrates creating a custom Shiny output binding that uses a JavaScript component.

Run this example by calling:

`shiny::runGitHub("shiny-js-examples", "jcheng5", subdir="output")`

## Implementation

`linechart.R` contains reusable R functions `lineChartOutput` and `renderLineChart` that can be called from a Shiny app's `ui.R` and `server.R` (respectively) to add line charts.

The file `www/linechart-binding.js` contains the JavaScript code that defines a custom Shiny output binding for the line charts. It's loaded into the app implicitly by the `lineChartOutput` function.

The `www/d3` and `www/nvd3` directories contain the 3rd party libraries [D3](http://d3js.org/) and [NVD3](http://nvd3.org/). They also are loaded from `lineChartOutput`.

## Packaging note

This example is set up for easy reading of the code and easy running via `shiny::runGitHub()`.

If instead we wanted to make this line chart component easily distributable to other Shiny users, we would set it up as a package. `linechart.R` would go into the `R` subdirectory. The contents of `www` would be moved to `inst`, and `lineChartOutput` would call `shiny::addResourcePath` to make them available at a URL prefix like `"linechart"`. See [shiny-incubator](https://github.com/rstudio/shiny-incubator) for one example.
