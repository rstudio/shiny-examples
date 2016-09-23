function(input, output) {

  output$actionOut <- renderPrint({ input$action })
  output$checkboxOut <- renderPrint({ input$checkbox })
  output$checkGroupOut <- renderPrint({ input$checkGroup })
  output$dateOut <- renderPrint({ input$date })
  output$datesOut <- renderPrint({ input$dates })
  output$fileOut <- renderPrint({ input$file })
  output$numOut <- renderPrint({ input$num })
  output$radioOut <- renderPrint({ input$radio })
  output$selectOut <- renderPrint({ input$select })
  output$slider1Out <- renderPrint({ input$slider1 })
  output$slider2Out <- renderPrint({ input$slider2 })
  #output$submitOut <- renderPrint({ input$submit })
  output$textOut <- renderPrint({ input$text })

}
