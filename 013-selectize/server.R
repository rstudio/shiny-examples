library(shiny)

shinyServer(function(input, output) {
  output$e4out <- renderText({
    paste('You selected', if (input$e4 == '') 'nothing' else input$e4, 'in the example 4',
          if (input$e6 != '') sprintf('and the movie "%s"', input$e6))
  })
})
