fluidPage(
  verticalLayout(
    titlePanel("Vertical layout example"),
    plotOutput("plot1"),
    wellPanel(
      sliderInput("n", "Number of points", 10, 200,
                  value = 50, step = 10)
    )
  )
)
