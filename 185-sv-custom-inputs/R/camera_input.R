camera_input <- function(inputId, label, button_label = "Take photo", width = 400, height = 300) {
  tagList(
    div(id = inputId, class = "shiny-camera-input",
      style = htmltools::css(
        width = htmltools::validateCssUnit(width),
        height = htmltools::validateCssUnit(height)
      ),
      
      tags$div(class = "curtain", icon("camera")),
      tags$video(autoplay = NA),
      tags$button(class = "btn btn-default btn-xs take",
        icon("camera"),
        "Take photo"
      ),
      tags$output(
        tags$img()
      ),
      tags$button(class = "btn btn-default btn-xs retake",
        icon("refresh"),
        "Retake"
      ),
      tags$canvas(),
      tags$span(class = "feedback-message")
    ),
    singleton(tags$head(
      tags$script(src = "camera_input.js"),
      tags$link(rel = "stylesheet", type = "text/css", href = "camera_input.css")
    ))
  )
}

shiny::registerInputHandler("camera-datauri", function(value, session, name) {
  if (is.null(value)) {
    return(NULL)
  }
  pattern <- "^data:image/png;base64,"
  if (!grepl(pattern, value)) {
    warning("Invalid camera data URI detected for input ", name, "; returning NULL instead")
    return(NULL)
  }
  data <- sub(pattern, "", value)
  base64enc::base64decode(data)
}, force = TRUE)
