function(input, output) {

  # You can access the value of the widget with input$checkbox, e.g.
  output$value <- renderPrint({ input$checkbox })

}
