function(input, output) {
  output$summary <- renderText({
    # Simply accessing input$goButton here makes this reactive
    # object take a dependency on it. That means when
    # input$goButton changes, this code will re-execute.
    input$goButton

    # input$text is accessed here, so this reactive object will
    # take a dependency on it. However, input$ is inside of
    # isolate(), so this reactive object will NOT take a
    # dependency on it; changes to input$n will therefore not
    # trigger re-execution.
    paste0('input$text is "', input$text,
      '", and input$n is ', isolate(input$n))
  })


  # In the code above, the call to isolate() is used inline in
  # a function call. However, isolate can take any expression,
  # as shown in the code below.
  output$summary2 <- renderText({
    input$goButton

    str <- paste0('input$text is "', input$text, '"')

    # Any sort of expression can go in isolate()
    isolate({
      str <- paste0(str, ', and input$n is ')
      paste0(str, isolate(input$n))
    })
  })

}
