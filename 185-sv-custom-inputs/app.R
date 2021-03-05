library(shiny)
library(shinyvalidate)

ui <- fluidPage(
  div(id = "form",
    radioButtons("type", "Profile image type", choices = c(
      "Take selfie" = "selfie",
      "Upload image file" = "upload",
      "Gravatar" = "gravatar"
    )),
    conditionalPanel("input.type === 'selfie'",
      camera_input("selfie", "Take a selfie")
    ),
    conditionalPanel("input.type === 'upload'",
      fileInput("upload", NULL, accept = c("image/jpeg", "image/png")),
      uiOutput("upload_preview", container = tags$p)
    ),
    conditionalPanel("input.type === 'gravatar'",
      textInput("email", "Email address"),
      uiOutput("gravatar_preview", container = tags$p)
    ),
    actionButton("submit", "Submit", class = "btn-primary")
  )
)

server <- function(input, output, session) {
  iv <- InputValidator$new()
  
  selfie_iv <- InputValidator$new()
  selfie_iv$add_rule("selfie",
    sv_required("Click the 'Take photo' button before submitting"))
  selfie_iv$condition(~ input$type == "selfie")
  iv$add_validator(selfie_iv)
  
  upload_iv <- InputValidator$new()
  upload_iv$add_rule("upload", sv_required("Please choose a file"))
  upload_iv$add_rule("upload", function(upload) {
    if (!tools::file_ext(upload$name) %in% c("jpg", "jpeg", "png")) {
      "A JPEG or PNG file is required"
    }
  })
  upload_iv$condition(~ input$type == "upload")
  iv$add_validator(upload_iv)
  
  gravatar_iv <- InputValidator$new()
  gravatar_iv$add_rule("email", sv_required())
  gravatar_iv$add_rule("email", sv_email())
  gravatar_iv$condition(~ input$type == "gravatar")
  iv$add_validator(gravatar_iv)
  
  output$upload_preview <- renderUI({
    req(input$upload)
    req(nrow(input$upload) == 1)
    req(tools::file_ext(input$upload$name) %in% c("jpg", "jpeg", "png"))
    
    uri <- base64enc::dataURI(file = input$upload$datapath,
      mime = input$upload$type)
    tags$img(src = uri, style = htmltools::css(max_width = "300px", max_height = "300px"))
  })
  
  output$gravatar_preview <- renderUI({
    req(gravatar_iv$is_valid())
    
    email <- gsub("^\\s*(.*?)\\s*$", "\\1", input$email)
    email <- tolower(email)
    hash <- digest::digest(email, algo = "md5", serialize = FALSE)
    url <- paste0("https://www.gravatar.com/avatar/", hash)

    tags$img(src = url, alt = "Gravatar image")
  })
  
  observeEvent(input$submit, {
    if (iv$is_valid()) {
      removeUI("#form")
      insertUI(".container-fluid", "beforeEnd", "Thank you for your submission!")
      
      # input$selfie contains raw png data, suitable for png::readPNG()
    } else {
      iv$enable() # Start showing validation feedback
    }
  })
}

shinyApp(ui, server)
