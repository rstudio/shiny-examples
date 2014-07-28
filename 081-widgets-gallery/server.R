library(shiny)

shinyServer(function(input, output) {

  output$action <- renderPrint({ input$action })
  output$checkbox <- renderPrint({ input$checkbox })
  output$checkGroup <- renderPrint({ input$checkGroup })
  output$date <- renderPrint({ input$date })
  output$dates <- renderPrint({ input$dates })
  output$file <- renderPrint({ input$file })
  output$num <- renderPrint({ input$num })
  output$radio <- renderPrint({ input$radio })
  output$select <- renderPrint({ input$select })
  output$slider1 <- renderPrint({ input$slider1 })
  output$slider2 <- renderPrint({ input$slider2 })
  #output$submit <- renderPrint({ input$submit })
  output$text <- renderPrint({ input$text })

})
