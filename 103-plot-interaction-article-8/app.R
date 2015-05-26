library(ggplot2)
ui <- basicPage(
  plotOutput("plot1",
    brush = brushOpts(id = "plot_brush", fill = "#ccc", direction = "x"),
    height = 250
  )
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(ChickWeight, aes(x=Time, y=weight, colour=factor(Chick))) +
      geom_line() +
      guides(colour=FALSE) +
      theme_bw()
  })
}

shinyApp(ui, server)
