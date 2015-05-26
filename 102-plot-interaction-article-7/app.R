library(ggplot2)
ui <- basicPage(
  plotOutput("plot1", brush = "plot_brush"),
  verbatimTextOutput("info")
)

server <- function(input, output) {
  options(width = 100) # Increase text width for printing table
  output$plot1 <- renderPlot({
    ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()
  })

  output$info <- renderPrint({
    brushedPoints(mtcars, input$plot_brush, allRows = TRUE)
  })
}

shinyApp(ui, server)
