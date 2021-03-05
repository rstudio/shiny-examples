library(shiny)
library(shinyvalidate)
library(markdown)

ui <- fluidPage(
  textInput("name", "Name"),
  textInput("email", "Email"),
  textOutput("greeting")
)

server <- function(input, output, session) {

  # Create an InputValidator object
  iv <- InputValidator$new()
  
  # Add validation rules
  iv$add_rule("name", sv_required())
  iv$add_rule("email", sv_required())
  iv$add_rule("email", sv_email())
  
  # Start displaying errors in the UI
  iv$enable()
  
  output$greeting <- renderText({
    
    # Don't proceed if any input is invalid
    req(iv$is_valid())
    
    paste0("Nice to meet you, ", input$name, " <", input$email, ">!")
  })
}

shinyApp(ui, server)
