ui <- function(request) {
  fluidPage(
    plotOutput("plot"),
    sliderInput("n", "Number of observations", 1, nrow(faithful), 100),
    bookmarkButton()
  )
}

server <- function(input, output, session) {
  output$plot <- renderPlot({
    hist(faithful$eruptions[seq_len(input$n)], breaks = 40)
  })
}

enableBookmarking(store = "url")
shinyApp(ui, server)
