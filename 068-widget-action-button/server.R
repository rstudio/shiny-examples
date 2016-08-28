function(input, output) {

  # You can access the value of the widget with input$action, e.g.
  output$value <- renderPrint({ input$action })

}
