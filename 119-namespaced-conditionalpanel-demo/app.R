myPlotUI <- function(id, label = "My Plot") {
  ns <- NS(id)
  tagList(
    column(4, wellPanel(
      sliderInput(
        ns("n"),
        "Number of points:",
        min = 10,
        max = 200,
        value = 50,
        step = 10
      )
    )),

    column(
      5,
      tags$h2(label),
      "The plot below will be not displayed when the slider value",
      "is less than 50.",

      # With the conditionalPanel, the condition is a JavaScript
      # expression. In these expressions, input values like
      # input$n are accessed with dots, as in input.n
      conditionalPanel("input.n >= 50",
                       ## The condition is namespaced to this particular
                       ## instance of this module by providing the ns parameter.
                       ## Consequently, input.n refers to this module's input
                       ## named n, and no other.
                       ns = ns,
                       plotOutput(ns("scatterPlot"), height = 300))
    )
  )
}

myPlot <- function(input, output, session, deviates) {
  output$scatterPlot <- renderPlot({
    x <- rnorm(input$n)
    y <- rnorm(input$n)
    plot(x, y)
  })
}

server <- function(input, output) {
  callModule(myPlot, "plot1")
  callModule(myPlot, "plot2")
}

ui <- fluidPage(
  titlePanel("Namespaced conditional panels"),
  fluidRow(
    myPlotUI("plot1", label = "My first plot")
  ),
  fluidRow(
    myPlotUI("plot2", label = "My second plot")
  )
)

shinyApp(ui = ui, server = server)
