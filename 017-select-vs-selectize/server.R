function(input, output, session) {
  output$out1 <- renderPrint(input$in1)
  output$out2 <- renderPrint(input$in2)
  output$out3 <- renderPrint(input$in3)
  output$out4 <- renderPrint(input$in4)
  output$out5 <- renderPrint(input$in5)
  output$out6 <- renderPrint(input$in6)
}
