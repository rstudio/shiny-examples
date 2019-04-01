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

ui <- function(request) {
  fluidPage(
    titlePanel("reactR Input Demo"),
    tags$p("Enter text under 'Input' below. It should show up under 'Output'."),
    tags$p("You should also be able to bookmark this page and the input will retain its value."),
    tags$p(bookmarkButton()),
    tags$h1("Input"),
    tags$div(
      tags$p(simpleTextInput('simpleTextInput')),
      tags$h1("Output"),
      textOutput("simpleTextOutput")
    )
  )
}

server <- function(input, output, session) {
  output$simpleTextOutput <- renderText(input$simpleTextInput)
}

shinyApp(ui, server, enableBookmarking = "url")
