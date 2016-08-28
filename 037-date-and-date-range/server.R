function(input, output, session) {

  # input$date and others are Date objects. When outputting
  # text, we need to convert to character; otherwise it will
  # print an integer rather than a date.
  output$dateText  <- renderText({
    paste("input$date is", as.character(input$date))
  })

  output$dateText2 <- renderText({
    paste("input$date2 is", as.character(input$date2))
  })

  output$dateRangeText  <- renderText({
    paste("input$dateRange is", 
      paste(as.character(input$dateRange), collapse = " to ")
    )
  })

  output$dateRangeText2 <- renderText({
    paste("input$dateRange2 is", 
      paste(as.character(input$dateRange2), collapse = " to ")
    )
  })
}
