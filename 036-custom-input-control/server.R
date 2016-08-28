function(input, output, session) {
  
  output$selection <- renderPrint(
    input$mychooser
  )
  
}
