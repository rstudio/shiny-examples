shinyServer(function(input, output) {
  output$nText <- renderText({
    # Take a dependency on input$goButton
    input$goButton

    # Use isolate() to avoid dependency on input$n
    isolate(input$n)
  })
})
