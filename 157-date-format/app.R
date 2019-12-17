library(shiny)

ui <- fluidPage(
  HTML(
    "<h3>Informative warnings for mis-specified date strings</h3>
    (Issue <a href='https://github.com/rstudio/shiny/issues/2402'>#2402</a>;
    PR: <a href='https://github.com/rstudio/shiny/pull/2403'>#2403</a>)"
  ),
  tabsetPanel(
    tabPanel("Test result", uiOutput("res")),
    tabPanel("Warnings", verbatimTextOutput("warnings")),
    tabPanel("Inputs", uiOutput("inputs"))
  )
)


server <- function(input, output, session) {

  # variable for tracking warning message
  warn_messages <- reactiveVal(NULL)

  # turn any warnings produced by calling a function
  # into a notification and optionally call the function
  # again to return the results (use `return = FALSE` if
  # function produces side effects)
  catchWarning <- function(f, ..., return = TRUE) {
    tryCatch(f(...), warning = function(w) {
      isolate({
        msgs <- c(warn_messages(), w$message)
        warn_messages(msgs)
      })
      if (return) f(...)
    })
  }

  output$inputs <- renderUI({
    tagList(
      catchWarning(dateInput, "x1", "Mis-specified `value`", value = "2014-13-1"),
      catchWarning(dateInput, "x2", "Mis-specified `min`", min = ""),
      catchWarning(dateInput, "x3", "Mis-specified `max`", max = "abjs"),
      catchWarning(dateRangeInput, "x4", "Mis-specified `start`", start = "null"),
      catchWarning(dateRangeInput, "x5", "Mis-specified `end`", end = "NA"),
      catchWarning(dateRangeInput, "x6", "Mis-specified `min`", min = "21380-03-10"),
      catchWarning(dateRangeInput, "x7", "Mis-specified `max`", max = 12)
    )
  })

  outputOptions(output, "inputs", suspendWhenHidden = FALSE)

  observe({
    catchWarning(updateDateInput, session, "x1", max = "2014-01-96", return = FALSE)
    catchWarning(updateDateInput, session, "x2", value = "   ", return = FALSE)
    catchWarning(updateDateInput, session, "x3", min = "{}", return = FALSE)
    catchWarning(updateDateRangeInput, session, "x4", end = "x", return = FALSE)
    catchWarning(updateDateRangeInput, session, "x5", start = "29", return = FALSE)
    catchWarning(updateDateRangeInput, session, "x6", max = "val", return = FALSE)
    catchWarning(updateDateRangeInput, session, "x7", min = "$", return = FALSE)
  })

  output$warnings <- renderPrint(warn_messages())

  output$res <- renderUI({
    n <- length(warn_messages())
    status <- if (n == 14)
      tags$b("Test passed (it's OK if you see warnings in your R console)", style = "color: green")
    else
      p(tags$b("Fail:", style = "color: red"), "expected 14 warnings, but got", n)
  })

}

shinyApp(ui, server)
