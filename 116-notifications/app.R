shinyApp(
  ui = fluidPage(
    textInput("txt", "Content", "Text of message"),
    radioButtons("duration", "Seconds before fading out",
      choices = c("2", "5", "10", "Never"),
      inline = TRUE
    ),
    radioButtons("type", "Type",
      choices = c("default", "message", "warning", "error"),
      inline = TRUE
    ),
    checkboxInput("close", "Close button?", TRUE),
    actionButton("show", "Show"),
    actionButton("remove", "Remove most recent")
  ),
  server = function(input, output) {
    id <- NULL

    observeEvent(input$show, {
      if (input$duration == "Never")
        duration <- NA
      else 
        duration <- as.numeric(input$duration)

      type <- input$type
      if (is.null(type)) type <- NULL

      id <<- showNotification(
        input$txt,
        duration = duration, 
        closeButton = input$close,
        type = type
      )
    })

    observeEvent(input$remove, {
      removeNotification(req(id))
    })
  }
)
