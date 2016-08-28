function(input, output) {

  # You can access the value of the widget with input$date, e.g.
  output$value <- renderPrint({ input$date })

}
