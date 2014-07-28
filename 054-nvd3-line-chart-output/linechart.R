library(shiny)

# To be called from ui.R
lineChartOutput <- function(inputId, width="100%", height="400px") {
  style <- sprintf("width: %s; height: %s;",
    validateCssUnit(width), validateCssUnit(height))
  
  tagList(
    # Include CSS/JS dependencies. Use "singleton" to make sure that even
    # if multiple lineChartOutputs are used in the same page, we'll still
    # only include these chunks once.
    singleton(tags$head(
      tags$script(src="d3/d3.v3.min.js"),
      tags$script(src="nvd3/nv.d3.min.js"),
      tags$link(rel="stylesheet", type="text/css", href="nvd3/nv.d3.min.css"),
      tags$script(src="linechart-binding.js")
    )),
    div(id=inputId, class="nvd3-linechart", style=style,
      tag("svg", list())
    )
  )
}

# To be called from server.R
renderLineChart <- function(expr, env=parent.frame(), quoted=FALSE) {
  # This piece of boilerplate converts the expression `expr` into a
  # function called `func`. It's needed for the RStudio IDE's built-in
  # debugger to work properly on the expression.
  installExprFunction(expr, "func", env, quoted)
  
  function() {
    dataframe <- func()

    mapply(function(col, name) {

      values <- mapply(function(val, i) {
        list(x = i, y = val)
      }, col, 1:nrow(dataframe), SIMPLIFY=FALSE, USE.NAMES=FALSE)

      list(key = name, values = values)
      
    }, dataframe, names(dataframe), SIMPLIFY=FALSE, USE.NAMES=FALSE)
  }
}


# Data frame or list looks like:
# 
# {
#   "Series A": [1,2,3,4,5],
#   "Series B": [6,7,8,9,10]
# }
# 
# D3 expects:
# 
# [
#   {
#     key: "Series A",
#     values: [{x:1,y:1}, {x:2,y:2}, {x:3,y:3}, {x:4,y:4}, {x:5,y:5}]
#   },
#   {
#     key: "Series B",
#     values: [{x:1,y:6}, {x:2,y:7}, {x:3,y:8}, {x:4,y:9}, {x:5,y:10}]
#   }
# ]
dataFrameToD3 <- function(df=cars) {

}
