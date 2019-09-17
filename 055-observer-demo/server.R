function(input, output, session) {

  # Create a random name for the log file
  logfilename <- tempfile('logfile', fileext = '.txt')

  output$logfile <- renderText({
    sprintf("Log file: %s", logfilename)
  })

  # This observer adds an entry to the log file every time
  # input$n changes.
  obs <- observe({    
    cat(input$n, '\n', file = logfilename, append = TRUE)
  })


  session$onSessionEnded(function() {
    # When the client ends the session, clean up the log file
    # for this session.
    unlink(logfilename)
  })


  output$text <- renderText({
    paste0("The value of input$n is: ", input$n)
  })

}
