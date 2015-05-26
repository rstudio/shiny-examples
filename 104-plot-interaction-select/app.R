library(ggplot2)
library(Cairo)   # For nicer ggplot2 output when deployed on Linux

# We'll use a subset of the mtcars data set, with fewer columns
# so that it prints nicely
mtcars2 <- mtcars[, c("mpg", "cyl", "disp", "hp", "wt", "am", "gear")]


ui <- fluidPage(
  fluidRow(
    column(width = 4,
      plotOutput("plot1", height = 300,
        # Equivalent to: click = clickOpts(id = "plot_click")
        click = "plot1_click",
        brush = brushOpts(
          id = "plot1_brush"
        )
      )
    )
  ),
  fluidRow(
    column(width = 6,
      h4("Points near click"),
      verbatimTextOutput("click_info")
    ),
    column(width = 6,
      h4("Brushed points"),
      verbatimTextOutput("brush_info")
    )
  )
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(mtcars2, aes(wt, mpg)) + geom_point()
  })

  output$click_info <- renderPrint({
    # Because it's a ggplot2, we don't need to supply xvar or yvar; if this
    # were a base graphics plot, we'd need those.
    nearPoints(mtcars2, input$plot1_click, addDist = TRUE)
  })

  output$brush_info <- renderPrint({
    brushedPoints(mtcars2, input$plot1_brush)
  })
}

shinyApp(ui, server)
