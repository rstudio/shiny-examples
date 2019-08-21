library(shiny)

ui <- fluidPage(

  titlePanel("Hello Shiny!"),

   # NOTE THE TRAILING COMMA
  textOutput(outputId = "text"),
)

server <- function(input, output) {

  output$text <- renderText({
    "If you're seeing this, things are fine."
  })
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
