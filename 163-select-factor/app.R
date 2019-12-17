library(shiny)

# Regression test for https://github.com/rstudio/shiny/pull/2524/
choices <- factor(setNames(letters, LETTERS))

ui <- fluidPage(
  title = "Select from Factor",
  tags$ol(
    tags$li("Select any capital letter from the input below."),
    tags$li("You should see your selection reflected, in lower case, in the output area.")
  ),
  selectInput("letter", "Letters", choices = choices),
  tags$h3("Output"),
  verbatimTextOutput("selected")
)

server <- function(input, output, session) {
  output$selected <- renderText({
    sprintf("You selected: %s", input$letter)
  })
}

shinyApp(ui, server)
