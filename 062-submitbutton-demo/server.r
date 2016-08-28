function(input, output) {
  output$plot1 <- renderPlot({
    hist(rnorm(input$n))
  })

  output$text <- renderText({
    paste("Input text is:", input$text)
  })
}
