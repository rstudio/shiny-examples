function(input, output, session) {

  updateSelectizeInput(session, 'x2', choices = list(
    Eastern = c(`Rhode Island` = 'RI', `New Jersey` = 'NJ'),
    Western = c(`Oregon` = 'OR', `Washington` = 'WA'),
    Middle = list(Iowa = 'IA')
  ), selected = 'IA')

  output$values <- renderPrint({
    list(x1 = input$x1, x2 = input$x2, x3 = input$x3, x4 = input$x4)
  })
}
