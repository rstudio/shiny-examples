function(input, output, session) {

  # note we use the syntax input[['foo']] instead of input$foo, because we have
  # to construct the id as a character string, then use it to access the value;
  # same thing applies to the output object below
  output$a_out <- renderPrint({
    res <- lapply(1:5, function(i) input[[paste0('a', i)]])
    str(setNames(res, paste0('a', 1:5)))
  })

  lapply(1:10, function(i) {
    output[[paste0('b', i)]] <- renderUI({
      strong(paste0('Hi, this is output B#', i))
    })
  })
}
