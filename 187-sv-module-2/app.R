library(shiny)
library(shinyvalidate)

# Module UI
email_ui <- function(id, label = "Email", value = NULL) {
  ns <- NS(id)
  textInput(ns("email_address"), label = label, value = value)
}

# Module server
email <- function(id, required = TRUE) {
  moduleServer(id, function(input, output, session) {
    
    # Create and populate InputValidator object
    iv <- InputValidator$new()
    if (required) {
      iv$add_rule("email_address", sv_required())
    }
    iv$add_rule("email_address", sv_email())

    # Allow caller to reset the input
    reset <- function() {
      updateTextInput(session, "email_address", value = "")
    }

    # Return value accessor, InputValidator, and reset function to the caller
    list(
      value = reactive(input$email_address),
      iv = iv,
      reset = reset
    )
  })
}

# App UI
ui <- fluidPage(
  email_ui("email", "Email address")
)

# App server
server <- function(input, output, session) {
  email_result <- email("email")
  email_result$iv$enable()
}

shinyApp(ui, server)
