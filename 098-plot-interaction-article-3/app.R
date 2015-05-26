ui <- basicPage(
  plotOutput("plot1", click = "plot_click"),
  verbatimTextOutput("info")
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  })

  output$info <- renderPrint({
    # With base graphics, need to tell it what the x and y variables are.
    nearPoints(mtcars, input$plot_click, xvar = "wt", yvar = "mpg")
    # nearPoints() also works with hover and dblclick events
  })
}

shinyApp(ui, server)
