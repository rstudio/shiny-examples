library(shiny)
library(shinyvalidate)
library(markdown)

ui <- fluidPage(
  textInput("name", "Name: *"),
  textInput("email", "Email:"),
  checkboxGroupInput("topics", "Topics (choose two or more): *", choices = c(
    "Statistics",
    "Machine learning",
    "Visualization",
    "Programming"
  )),
  checkboxInput("accept_terms", strong("I accept the terms and conditions *")),
  helpText("* Required fields"),
  p(
    actionButton("submit", "Submit", class = "btn-primary"),
    actionButton("reset", "Reset")
  )
)

server <- function(input, output, session) {
  iv <- InputValidator$new()
  iv$add_rule("name", sv_required())
  iv$add_rule("email", sv_required())
  iv$add_rule("email", sv_email())
  iv$add_rule("topics", ~ if (length(.) < 2) "Please choose two or more topics")
  iv$add_rule("accept_terms", sv_required())
  iv$add_rule("accept_terms", ~ if (!isTRUE(.)) "The terms and conditions must be accepted in order to proceed")
  
  observeEvent(input$submit, {
    if (iv$is_valid()) {
      reset_form()
      removeNotification("submit_message")
      showModal(
        modalDialog(title = "Thank you",
          "Your submission has been accepted!",
          size = "s", fade = FALSE
        )
      )
    } else {
      iv$enable() # Start showing validation feedback
      showNotification(
        "Please correct the errors in the form and try again",
        id = "submit_message", type = "error")
    }
  })
  
  observeEvent(input$reset, {
    reset_form()
  })
  
  reset_form <- function() {
    iv$disable()
    removeNotification("submit_message")
    updateTextInput(session, "name", value = "")
    updateTextInput(session, "email", value = "")
    updateCheckboxGroupInput(session, "topics", selected = character(0))
    updateCheckboxInput(session, "accept_terms", value = FALSE)
  }
}

shinyApp(ui, server)
