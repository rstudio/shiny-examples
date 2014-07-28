shinyServer(function(input, output, session) {

  # Create a random name for the log file
  logfilename <- paste0('logfile',
                        floor(runif(1, 1e+05, 1e+06 - 1)),
                        '.txt')


  # This observer adds an entry to the log file every time
  # input$n changes.
  obs <- observe({    
    cat(input$n, '\n', file = logfilename, append = TRUE)
  })


  # When the client ends the session, suspend the observer.
  # Otherwise, the observer could keep running after the client
  # ends the session.
  session$onSessionEnded(function() {
    obs$suspend()

    # Also clean up the log file for this example
    unlink(logfilename)
  })


  output$text <- renderText({
    paste0("The value of input$n is: ", input$n)
  })

})
