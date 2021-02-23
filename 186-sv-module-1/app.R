library(shiny)
library(shinyvalidate)

# Module UI
contact_us_ui <- function(id) {
  ns <- NS(id)
  actionButton(ns("contact_us"), "Contact Us", class = "btn-sm")
}

# Module server
contact_us <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    iv <- InputValidator$new()
    
    iv$add_rule("email", sv_required())
    iv$add_rule("email", sv_email())
    
    iv$add_rule("message", sv_required())
    iv$add_rule("message",
      ~ if (nchar(.) > 140) paste("Maximum length exceeded by", nchar(.) - 140))
    
    observeEvent(input$contact_us, {
      showModal(
        modalDialog(size = "s", easyClose = FALSE, title = "Contact Us",
          footer = NULL,
          tagList(
            textInput(ns("email"), "Your email"),
            textAreaInput(ns("message"), "Message", rows = 4),
            helpText("Maximum 140 characters"),
            div(class = "text-right",
              actionButton(ns("cancel"), "Cancel"),
              actionButton(ns("send"), "Send email", class = "btn-primary")
            )
          )
        )
      )
    })
    
    close <- function() {
      removeModal()
      iv$disable()
    }
    
    observeEvent(input$send, {
      iv$enable()
      if (iv$is_valid()) {
        close()
        showNotification("Message sent (not really)", type = "message")
      }
    }, ignoreInit = TRUE)
    
    observeEvent(input$cancel, {
      close()
    }, ignoreInit = TRUE)
  })
}

ui <- fluidPage(style = "padding-top: 12px; padding-bottom: 120px;",
  contact_us_ui("contact")
)

server <- function(input, output, session) {
  contact_us("contact")
}

shinyApp(ui, server)
