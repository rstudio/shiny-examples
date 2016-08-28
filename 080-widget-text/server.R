function(input, output) {

  # You can access the value of the widget with input$text, e.g.
  output$value <- renderPrint({ input$text })

}
