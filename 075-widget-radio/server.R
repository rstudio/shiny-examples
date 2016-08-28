function(input, output) {

  # You can access the values of the widget (as a vector)
  # with input$radio, e.g.
  output$value <- renderPrint({ input$radio })

}
