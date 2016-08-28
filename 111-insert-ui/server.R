function(input, output) {
  
  ## keep track of elements inserted and not yet removed
  inserted <- c()
  
  observeEvent(input$insertBtn, {
    btn <- input$insertBtn
    id <- paste0('txt', btn)
    insertUI(
      selector = '#placeholder',
      ## wrap element in a div with id for ease of removal
      ui = tags$div(
        tags$p(paste('Element number', btn)), 
        id = id
        )
    )
    inserted <<- c(id, inserted)
  })
  
  observeEvent(input$removeBtn, {
    removeUI(
      ## pass in appropriate div id
      selector = paste0('#', inserted[length(inserted)])
    )
    inserted <<- inserted[-length(inserted)]
  })
  
}
