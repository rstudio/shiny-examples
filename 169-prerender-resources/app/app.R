library(shiny)

ui <- fluidPage(
  "Below is a test for behavior described ",
  a("here", href = "https://github.com/rstudio/rmarkdown/pull/1631"),
  br(),
  span(
    id = "test-message",
    style = "color: red",
    "Test failed :("
  ),
  tags$script(src = "js/run-test.js")
)

server <- function(input, output) {}

shinyApp(ui, server)
