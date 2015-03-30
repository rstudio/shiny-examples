library(shiny)

ui <- fluidPage(
  actionButton("do", "Close")
)

server <- function(input, output) {
  observeEvent(input$do, {
    stopApp()
  })
}

shinyApp(ui, server)