shinyServer(function(input, output) {

  # You can access the value of the widget with input$file, e.g.
  output$plot <- renderPlot({ hist(input$file[ , 1]) })

})
