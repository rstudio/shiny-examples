library(shiny)
library(ggplot2)

m <- mpg[c("fl", "cty", "drv")]
m <- m[!duplicated(m), ]

ui <- basicPage(
  p("Brushing the plot should return the correct number of data points"),
  p(
    a("Issue #1433", href = "https://github.com/rstudio/shiny/issues/1433"), "/",
    a("PR #2410", href = "https://github.com/rstudio/shiny/pull/2410")
  ),
  plotOutput("plot1", brush = "plot_brush"),
  verbatimTextOutput("info")
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(m) +
      geom_point(aes(fl, cty)) +
      facet_wrap(~drv, scales = "free_x")
  })
  output$info <- renderPrint({
    brushedPoints(m, input$plot_brush)
  })
}

shinyApp(ui, server)
