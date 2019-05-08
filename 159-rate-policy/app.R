library(shiny)

initRange <- c(1, 2)

ui <- fluidPage(
  p("Make sure the output below is debounced (i.e. rapidly changing the slider doesn't rapidly update the output below it) both before and after updating the slider. Also, make sure after updating to a date, that the result is of a Date type."),
  actionButton("update", "Update slider"),
  sliderInput(
    "slider",
    label = "Dates",
    min = initRange[1],
    max = initRange[2],
    value = initRange,
    dragRange = T
  ),
  verbatimTextOutput("output"),
  p(
    a("Issue #2387", href = "https://github.com/rstudio/shiny/issues/2387"), "/",
    a("PR #2404", href = "https://github.com/rstudio/shiny/pull/2404")
  )
)

server <- function(input, output, session) {
  observeEvent(input$update,{
    dRange <- as.Date(c("2012-12-22","2017-08-09"))
    updateSliderInput(
      session, "slider",
      min = dRange[1],
      max = dRange[2],
      value = dRange
    )
  })
  output$output <- renderPrint({
    str(input$slider)
  })
}

shinyApp(ui, server)
