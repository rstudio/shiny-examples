library(shiny)

initRange <- c(1, 2)

ui <- fluidPage(
  p("Make sure the output below is debounced: if you keep moving the slider, the value should update only after you have stopped for 0.25 seconds.
     Next, click on the 'Update to Dates' button. The slider should show dates, the output value should still be debounced when moving the slider, and the type of the values in the text box should be Date[1:2]."),
  actionButton("update", "Update to Dates"),
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
