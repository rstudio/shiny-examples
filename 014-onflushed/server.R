function(input, output, session) {

  values <- reactiveValues(starting = TRUE)

  session$onFlushed(function() {
    values$starting <- FALSE
  })
  
  output$fast <- renderText({ "This happens right away" })
  output$slow <- renderText({
    if (values$starting) {
      invalidateLater(0, session)
      return("Please wait for 5 seconds")
    }
    Sys.sleep(5)  # pretend this is time-consuming
    "This happens later"
  })
  output$slow_plot <- renderPlot({
    if (values$starting) {
      invalidateLater(0, session)
      return(plot(cars, main = "Please wait for a while"))
    }
    plot(rnorm(100000), main = "A slow plot")
  })

}
