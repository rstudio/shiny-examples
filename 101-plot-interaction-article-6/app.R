library(ggplot2)
ui <- basicPage(
  plotOutput("plot1", brush = "plot_brush", height = 250),
  verbatimTextOutput("info")
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point() +
      facet_grid(. ~ cyl) +
      theme_bw()
  })

  output$info <- renderPrint({
    brushedPoints(mtcars, input$plot_brush)
  })
}

shinyApp(ui, server)
