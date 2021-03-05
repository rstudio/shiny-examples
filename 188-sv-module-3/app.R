library(shiny)
library(shinyvalidate)

#' A Shiny module UI function that pairs with password_input().
#' 
#' @param id Module instance ID. The same value must be passed to the matching
#'   password_input() call.
#' @param value The default value.
password_input_ui <- function(id, value = NULL) {
  ns <- NS(id)
  
  tagList(
    passwordInput(ns("pw1"), "Password", value = value),
    passwordInput(ns("pw2"), "Password (confirm)", value = value)
  )
}

#' A Shiny module server function that pairs with password_input_ui().
#' 
#' Includes
#' 
#' @param id Module instance ID. The same value must be passed to the matching
#'   password_input_ui() call.
#' @param required If `TRUE` (the default), the returned validator will include
#'   a rule that ensures a password is provided.
#' @param password_rule Optional validation function or formula that can impose
#'   further validation rules on the password. Like all validation functions and
#'   formulas, the return value should be either a string describing an error,
#'   or `NULL` if the input value is acceptable.
password_input <- function(id, required = TRUE, password_rule = NULL) {
  moduleServer(id, function(input, output, session) {
    iv <- InputValidator$new()
    if (isTRUE(required)) {
      iv$add_rule("pw1", sv_required())
    }
    iv$add_rule("pw2", ~ if (!identical(., input$pw1)) "Passwords do not match")
    
    # Add custom rule passed in by caller
    if (!is.null(password_rule)) {
      iv$add_rule("pw1", password_rule)
    }
    
    list(
      value = reactive({
        if (iv$is_valid()) {
          input$pw1
        }
      }),
      reset = function() {
        updateTextInput(session, "pw1", value = "")
        updateTextInput(session, "pw2", value = "")
      },
      iv = iv
    )
  })
}

ui <- fluidPage(
  password_input_ui("password"),
  actionButton("continue", "Continue")
)

server <- function(input, output, session) {
  # Initialize the module, passing custom validation logic via password_rule
  password_result <- password_input("password", password_rule = function(pw) {
    if (!grepl("[0-9]", pw) || !grepl("[A-Z]", pw)) {
      "Must include a number and an upper-case character"
    } else if (nchar(pw) < 8) {
      "Must be at least 8 characters"
    }
  })
  
  iv <- InputValidator$new()
  iv$add_validator(password_result$iv)
  iv$enable()
  
  observeEvent(input$continue, {
    if (iv$is_valid()) {
      showModal(modalDialog(
        "Success, password hash is ",
        tags$code(digest::digest(password_result$value(), "sha256"))
      ))
      password_result$reset()
    }
  })
}

shinyApp(ui, server)
