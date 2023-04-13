function(input, output, session) {

  updateSelectizeInput(session, 'x2', choices = list(
    Eastern = list(`Rhode Island` = 'RI', `New Jersey` = 'NJ'),
    Western = list(`Oregon` = 'OR', `Washington` = 'WA'),
    Middle = list(Iowa = 'IA')
  ), selected = 'IA')

  output$values <- renderPrint({
    list(x1 = input$x1, x2 = input$x2, x3 = input$x3, x4 = input$x4)
  })
}
