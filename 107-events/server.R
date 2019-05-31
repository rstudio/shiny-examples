function(input, output, session) {


  histColor <- reactive({
    input$color1
    input$color2
    sample(colors(), 1)
  })

  output$distPlot <- renderPlot({
    Sys.sleep(2)
    x    <- faithful[, 2]  # Old Faithful Geyser data
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = histColor(), border = 'white',
         main = input$title)
  })

  output$slider_info1 <- renderPrint({
    cat('The value of the slider input is', input$bins)
  })

  output$slider_info2 <- renderPrint({
    cat('The value of the slider input is', input$bins)
  })

  output$error_info <- renderPrint({
    stop('A bad error occurred!')
  })

  observe({
    updateTextInput(session, 'title', value = paste(input$bins, 'bins'))
  })

  observeEvent(input$message, {
    session$sendCustomMessage('special', list(a = rnorm(10), b = letters))
  })

  observeEvent(input$busy, {
    message('Shiny will be busy for 2 seconds')
    Sys.sleep(2)
  })

  observeEvent(input$swallow_event_button, {
    session$sendCustomMessage('swallow_fail', list(msg = "Fail"))
  })

  observeEvent(input$end, session$close())

}
