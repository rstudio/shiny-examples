library(shiny)

ui <- function(req) {
  fluidPage(
    h2("Bookmarking of dynamic inputs"),
    p("Change the slider value below, then make a bookmark URL. Navigate to that URL and ensure that the slider value is restored correctly."),
    uiOutput("ui"),
    bookmarkButton()
  )
}

server <- function(input, output, session) {
  output$ui <- renderUI({
    sliderInput("x", "x", 1, 10, 5)
  })
}

enableBookmarking("url")

shinyApp(ui, server)

