library(shiny)

ui <- fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  actionButton("do", "Click Me")
)

server <- function(input, output, session) {
  observeEvent(input$do, {
    session$sendCustomMessage(type = 'testmessage',
      message = 'Thank you for clicking')
  })
}

shinyApp(ui, server)