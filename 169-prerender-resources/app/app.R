library(shiny)

ui <- fluidPage(
  "If you see this app and 'hello' in the JS console, then this test passed",
  tags$script(src = "js/log-app.js")
)

server <- function(input, output) {}

shinyApp(ui, server)
