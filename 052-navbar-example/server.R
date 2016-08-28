function(input, output, session) {
  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })

  output$summary <- renderPrint({
    summary(cars)
  })

  output$table <- DT::renderDataTable({
    DT::datatable(cars)
  })
}
