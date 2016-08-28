function(input, output) {

  # You can access the value of the widget (as a vector of length 2)
  # with input$slider2, e.g.
  output$value <- renderPrint({ input$slider2 })

}
