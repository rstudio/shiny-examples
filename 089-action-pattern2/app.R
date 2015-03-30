library(shiny)

ui <- fluidPage(
  actionButton("go", "Go"),
  numericInput("n", "n", 50),
  plotOutput("plot")
)

server <- function(input, output) {

  randomVals <- eventReactive(input$go, {
    runif(input$n)
  })

  output$plot <- renderPlot({
    hist(randomVals())
  })
}

shinyApp(ui, server)
