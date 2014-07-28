library(shinyIncubator)

shinyServer(function(input, output, session) {
  output$plot <- renderPlot({
    if (input$go == 0)
      return()

    # Wrap the entire expensive operation with withProgress
    withProgress(session, {
      setProgress(message = "Calculating, please wait",
        detail = "This may take a few moments...")
      Sys.sleep(1)
      setProgress(detail = "Still working...")
      Sys.sleep(1)
      anotherExpensiveOperation()
      Sys.sleep(1)
      setProgress(detail = "Almost there...")
      Sys.sleep(1)
      plot(rnorm(100), rnorm(100))
    })
  })

  anotherExpensiveOperation <- function() {
    # It's OK for withProgress calls to nest; they will have
    # a stacked appearance in the UI.
    #
    # Use min/max and setProgress(value=x) for progress bar
    withProgress(session, min = 0, max = 10, {
      setProgress(message = "Here's a sub-task")
      for (i in 1:10) {
        setProgress(value = i)
        if (i == 7)
          setProgress(detail = "Sorry, this is taking a while")
        Sys.sleep(0.3)
      }
    })
  }
})