function(input, output) {

  # You can access the value of the widget with input$slider1, e.g.
  output$value <- renderPrint({ input$slider1 })

  # You can access the values of the second widget with input$slider2, e.g.
  output$range <- renderPrint({ input$slider2 })
}
