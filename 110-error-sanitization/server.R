library(datasets)

function(input, output) {
  ## for the sidebarPanel
  observe({
    if (as.logical(input$sanitize) == TRUE) {
      options(shiny.sanitize.errors = TRUE)
    } else {
      options(shiny.sanitize.errors = FALSE)
    }
  })
  
  output$code <- renderText({ 
    paste0("<code>options(shiny.sanitize.errors = ", 
           as.logical(input$sanitize), ")</code>")
  })
  
  ## for the "Basic Usage" tab
  output$intentionalError <- renderText({
    input$sanitize
    stop('top secret info')
  })
  
  output$accidentalError <- renderText({
    input$sanitize
    n <- input$nTab1
    return(if (is.numeric(n)) n*100 else as.character(n)*100)
  })
  
  ## for the "Using safeError()" tab
  output$safeErrorIntentionalError <- renderText({
    input$sanitize
    stop(safeError('the user should see this no matter what'))
  })
  
  output$safeErrorAccidentalError <- renderText({
    input$sanitize
    n <- input$nTab2
    # do the checks you need (in this case: is it multipliable?)
    return(tryCatch(if (is.numeric(n)) n*100 else as.character(n)*100,
                    error = function(e) stop(safeError(e)) ))
  })
  
  observeEvent(input$show, {
    showNotification(
      HTML("The attentive reader will notice that the actual code",
           "used in <code>server.R</code> is a little more",
           "complicated than the one above. This is because R is",
           "slightly inconsistent when it comes to erroring out if",
           "binary operators are involved. In particular,", 
           "<code>NA * 100</code> returns <code>NA</code>, whereas",
           "<code>as.character(NA) * 100</code> throws an error",
           "(even though <code>is.na(as.character(NA))</code>", 
           "returns <code>TRUE</code>).<br>So, for ease of", 
           "readability, the code above just assumes that the",
           "<code>*</code> operator will always throw an error",
           "when one of the arguments is not strictly a number. But",
           "to actually make this happen, the code in",
           "<code>server.R</code> needs to coerce non-numeric",
           "arguments to character ones."), 
      duration = NULL, type = "message")
  })
  
  ## for the "Other errors" tab
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  output$tab <- renderTable({ head(datasetInput(), n = 6) })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$dataset, ".csv", sep="") },
    content = function(file) { 
      safe <- as.logical(input$safe)
      f <- if (safe) function(e) stop(safeError(e)) else stop
      write.csv(tryCatch(datasetInpute(), error = f)) 
    }
  )
}
