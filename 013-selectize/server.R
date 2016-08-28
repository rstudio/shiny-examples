library(shiny)

function(input, output) {
  output$ex_out <- renderPrint({
    str(sapply(sprintf('e%d', 0:7), function(id) {
      input[[id]]
    }, simplify = FALSE))
  })
  output$github <- renderText({
    paste('You selected', if (input$github == '') 'nothing' else input$github,
          'in the Github example.')
  })
}
