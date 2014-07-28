# This function generates the client-side HTML for a URL input
urlInput <- function(inputId, label, value = "") {
  tagList(
    # This makes web page load the JS file in the HTML head.
    # The call to singleton ensures it's only included once
    # in a page.
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(src = "url-input-binding.js")
      )
    ),
    shiny::tags$label(label, `for` = inputId),
    shiny::tags$input(id = inputId, type = "url", value = value)
  )
}


# Send an update message to a URL input on the client.
# This update message can change the value and/or label.
updateUrlInput <- function(session, inputId,
                           label = NULL, value = NULL) {

  message <- dropNulls(list(label = label, value = value))
  session$sendInputMessage(inputId, message)
}


# Given a vector or list, drop all the NULL items in it
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE=logical(1))]
}
