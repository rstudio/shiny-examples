function(input, output) {

  # You can access the value of the widget with input$num, e.g.
  output$value <- renderPrint({ input$num })

}
