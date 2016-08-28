function(input, output) {

  # submit buttons do not have a value of their own, 
  # they control when the app accesses values of other widgets.
  # input$num is the value of the number widget.
  output$value <- renderPrint({ input$num })

}
