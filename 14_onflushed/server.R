shinyServer(function(input, output, session) {

  values <- reactiveValues(starting = TRUE)

  session$onFlushed(function() {
    values$starting <- FALSE
  })
  
  output$fast <- renderText({ "This happens right away" })
  output$slow <- renderText({
    if (values$starting) return()
    Sys.sleep(5)  # pretend this is time-consuming
    "This happens later"
  })

})
