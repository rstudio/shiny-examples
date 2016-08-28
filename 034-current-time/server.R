options(digits.secs = 3) # Include milliseconds in time display

function(input, output, session) {

  output$currentTime <- renderText({
    # invalidateLater causes this output to automatically
    # become invalidated when input$interval milliseconds
    # have elapsed
    invalidateLater(as.integer(input$interval), session)

    format(Sys.time())
  })
}
