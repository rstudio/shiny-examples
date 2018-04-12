library(shiny)

ui <- fluidPage(
  h3("Pressing \"Clear\" should clear the plot."),
  plotOutput("plot"),
  actionButton("clear", "Clear")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({ plot(cars) })
  
  observeEvent(input$clear, {
    output$plot <- NULL
  })
}

shinyApp(ui, server)
