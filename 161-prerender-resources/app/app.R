library(shiny)

ui <- fluidPage(
  "If you see this app and 'file 1' and 'file 2' in the JS console, then this test passed",
  tags$script(src = "js/log-app.js")
)

server <- function(input, output) {}

shinyApp(ui, server)
