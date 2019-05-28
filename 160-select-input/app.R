library(shiny)

shinyApp(
  ui = fluidPage(
    p(
      "This test ensures that", code("selectInput()"), "doesn't introduce extra input variable(s).",
      a("Issue #2396", href = "https://github.com/rstudio/shiny/issues/2396"), "/",
      a("PR #2418", href = "https://github.com/rstudio/shiny/pull/2418")
    ),
    selectInput("variable", "Variable:",
                c("Cylinders" = "cyl", "Transmission" = "am", "Gears" = "gear")
    ),
    uiOutput("testResult")
  ),
  server = function(input, output, session) {

    output$testResult <- renderUI({
      input$variable

      nInputs <- length(.subset2(input, "impl")$toList())
      if (nInputs == 1) {
        tags$b("Test passed, move along", style = "color: green")
      } else {
        p(
          tags$b("Test failed: ", style = "color: red"),
          "expected one input value, but got ",
          nInputs
        )
      }
    })
  }

)
