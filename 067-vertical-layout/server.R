function(input, output) {
  output$plot1 <- renderPlot({
    plot(x = rnorm(input$n), y = rnorm(input$n))
  })
}
