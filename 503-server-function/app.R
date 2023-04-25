# Hello Shiny: Server function
# Shiny app
# Practice: Matching inputs and outputs

library(shiny)

ui <- fluidPage(
  
  textInput(
    inputId = "custom_text",
    label = "Input some text here:"
  ),
  
  strong("Text is shown below:"),
  
  textOutput(outputId = "user_text")
  
)

server <- function(input, output, session){
  
  output$user_text <- renderText({ input$custom_text })
  
}

shinyApp(ui = ui, server = server)