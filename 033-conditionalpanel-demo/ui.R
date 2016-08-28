fluidPage(

  titlePanel("Conditional panels"),

  column(4, wellPanel(
    sliderInput("n", "Number of points:",
                min = 10, max = 200, value = 50, step = 10)
  )),

  column(5,
    "The plot below will be not displayed when the slider value",
    "is less than 50.",

    # With the conditionalPanel, the condition is a JavaScript
    # expression. In these expressions, input values like
    # input$n are accessed with dots, as in input.n
    conditionalPanel("input.n >= 50",
      plotOutput("scatterPlot", height = 300)
    )
  )
)
