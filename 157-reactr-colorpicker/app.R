library(shiny)

capitalize <- function(s) {
  gsub("^(.)", perl = TRUE, replacement = '\\U\\1', s)
}

colorpickerInput <- function(inputId,
                             defaultColor = "#fff",
                             type = c(
                               "sketch",
                               "alpha",
                               "block",
                               "chrome",
                               "circle",
                               "compact",
                               "github",
                               "hue",
                               "material",
                               "photoshop",
                               "slider",
                               "swatches",
                               "twitter"
                             )) {
  reactR::createReactShinyInput(
    inputId,
    "colorpicker",
    htmltools::htmlDependency(
      name = "colorpicker-input",
      version = "1.0.0",
      src = file.path(getwd(), "js"),
      script = "colorpicker.js"
    ),
    defaultColor,
    list(type = paste0(capitalize(match.arg(type)), "Picker")),
    tags$div
  )
}

ui <- fluidPage(
  titlePanel("reactR Colorpicker Example"),
  tags$p("A colorpicker should appear below. You should be able to select colors and see their hex values appear in the text output."),
  colorpickerInput("textInput", type = "sketch"),
  textOutput("textOutput")
)

server <- function(input, output, session) {
  output$textOutput <- renderText({
    sprintf("You entered: %s", input$textInput)
  })
}

shinyApp(ui, server)
