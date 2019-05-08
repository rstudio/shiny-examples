library(shiny)

shinyApp(
  ui = fluidPage(
    tags$script("Shiny.addCustomMessageHandler('test_result', function(message) { alert(message); })"),
    p(
      a("Issue #2396", href = "https://github.com/rstudio/shiny/issues/2396"), "/",
      a("PR #2418", href = "https://github.com/rstudio/shiny/pull/2418")
    ),
    selectInput("variable", "Variable:",
                c("Cylinders" = "cyl", "Transmission" = "am", "Gears" = "gear")
    ),
    verbatimTextOutput("txt")
  ),
  server = function(input, output, session) {
    observe({
      inputs <- .subset2(input, "impl")$toList()
      if (length(inputs) > 1) {
        session$sendCustomMessage("test_result", "Test didn't pass. More input variables than expected.")
      } else if (length(inputs) == 1) {
        session$sendCustomMessage("test_result", "Test passed!")
      }
    })
  }
)
