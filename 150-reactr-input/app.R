library(shiny)
library(reactR)

simpleTextInput <- function(inputId, default = "") {
  createReactShinyInput(
    inputId = inputId,
    class = 'simple-text-input',
    dependencies = htmltools::htmlDependency(
      'simple-text-input',
      '1.0.0',
      src = file.path(getwd(), "js"),
      script = 'input.js',
      all_files = FALSE
    ),
    default = default,
    container = tags$span
  )
}

ui <- fluidPage(
  titlePanel("reactR Input Demo"),
  tags$h1("Input"),
  tags$p("Enter text in the box below. It should show up in the output area."),
  simpleTextInput('simpleTextInput'),
  tags$h1("Output"),
  textOutput("simpleTextOutput")
)

server <- function(input, output, session) {
  output$simpleTextOutput <- renderText(input$simpleTextInput)
}

shinyApp(ui, server)
