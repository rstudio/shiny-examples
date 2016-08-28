function(input, output, session) {
  output$plot <- renderPlot({
    mtscaled <- as.matrix(scale(mtcars))
    heatmap(mtscaled,
      col = topo.colors(200, alpha=0.5),
      Colv=F, scale="none")
  })

  output$plot2 <- renderPlot({
    plot(head(cars, input$n), main="Foo")
  }, bg = "#F5F5F5")
}
