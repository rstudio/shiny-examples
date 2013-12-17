shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    dist <- rnorm(input$obs)
    hist(dist)
  })
  
})
