library(shiny)

ui <- withTags(fluidPage(
  h3("Test of additional renderPlot args"),
  ol(
    li("The background of the plot should be entirely transparent."),
    li("Try resizing the browser's width, make sure it's transparent even after redraw.")
  ),
  style("body { background-color: #A3E4D7; }"),
  plotOutput("plot")
))

server <- function(input, output, session) {
  output$plot <- renderPlot({
    par(bg = NA)
    plot(cars)
  }, bg = NA)
}

shinyApp(ui, server)