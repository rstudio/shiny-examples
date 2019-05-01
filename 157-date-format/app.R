library(shiny)

ui <- fluidPage(
  tags$script("Shiny.addCustomMessageHandler('test_result', function(message) { alert(message); })"),
  HTML(
    "<h3>Informative warnings for mis-specified date strings</h3>
    (Issue <a href='https://github.com/rstudio/shiny/issues/2402'>#2402</a>;
    PR: <a href='https://github.com/rstudio/shiny/pull/2403'>#2403</a>)"
  ),
  uiOutput("dates")
)


server <- function(input, output, session) {

  # number of warnings thrown over the course of one tick
  nWarnings <- 0

  # turn any warnings produced by calling a function
  # into a notification and optionally call the function
  # again to return the results (use `return = FALSE` if
  # function produces side effects)
  doNotification <- function(f, ..., return = TRUE) {
    tryCatch(f(...), warning = function(w) {
      nWarnings <<- nWarnings + 1
      msg <- paste("Warning:", w$message)
      showNotification(msg, type = "warning", duration = NULL)
      if (return) f(...)
    })
  }

  output$dates <- renderUI({
    tagList(
      doNotification(dateInput, "x1", "Mis-specified `value`", value = "2014-13-1"),
      doNotification(dateInput, "x2", "Mis-specified `min`", min = ""),
      doNotification(dateInput, "x3", "Mis-specified `max`", max = "abjs"),
      doNotification(dateRangeInput, "x4", "Mis-specified `start`", start = "null"),
      doNotification(dateRangeInput, "x5", "Mis-specified `end`", end = "NA"),
      doNotification(dateRangeInput, "x6", "Mis-specified `min`", min = "21380-03-10"),
      doNotification(dateRangeInput, "x7", "Mis-specified `max`", max = 12)
    )
  })

  observe({
    doNotification(updateDateInput, session, "x1", value = "2014-13-1", return = FALSE)
    doNotification(updateDateInput, session, "x2", value = "2014-13-1", return = FALSE)
    doNotification(updateDateInput, session, "x3", value = "2014-13-1", return = FALSE)
    doNotification(updateDateRangeInput, session, "x4", end = "NA", return = FALSE)
    doNotification(updateDateRangeInput, session, "x5", end = "NA", return = FALSE)
    doNotification(updateDateRangeInput, session, "x6", end = "NA", return = FALSE)
    doNotification(updateDateRangeInput, session, "x7", end = "NA", return = FALSE)
  }, priority = 1000)

  observe({
    if (nWarnings == 14) {
      session$sendCustomMessage("test_result", "Test has passed! 14 warnings were thrown")
    } else {
      session$sendCustomMessage("test_result", paste("Test didn't pass :(. Only", nWarnings, "warnings were thrown"))
    }
  }, priority = -1000)

}

shinyApp(ui, server)
