library(shiny)
ui <- fluidPage(
  dateInput("val", "Date Input", max = Sys.Date()),
  "Below is a test for ",
  a("#2355", href = "https://github.com/rstudio/shiny/issues/2335"),
  verbatimTextOutput("res")
)
server <- function(input, output, session) {
  output$res <- renderPrint({
    if (length(input$val) > 0) "Test passed!" else "Test didn't pass :("
  })
}
shinyApp(ui, server)
