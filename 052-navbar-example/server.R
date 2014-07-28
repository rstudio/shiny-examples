shinyServer(function(input, output, session) {
  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })

  output$summary <- renderPrint({
    summary(cars)
  })

  output$table <- renderDataTable({
    cars
  }, options=list(iDisplayLength=10))
})
