library(shiny)
library(plotly)

source("My Script.R")

ui <- fluidPage(uiOutput("msg"))

server <- function(input, output, session) {
  output$msg <- renderUI(msg)
}

shinyApp(ui, server, options = list(display.mode = "showcase"))
