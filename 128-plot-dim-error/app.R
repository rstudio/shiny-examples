# Test for https://github.com/rstudio/shiny/issues/1964

library(shiny)

ui <- fluidPage(
  p("Verify that this app doesn't crash on startup, and that Go draws a plot."),
  actionButton("go", "Go"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  w <- eventReactive(input$go, { 400 })
  h <- eventReactive(input$go, { 400 })
  
  output$plot <- renderPlot({
    plot(cars)
  }, width = w, height = h)
}

shinyApp(ui, server)

