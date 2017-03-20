# Copied from http://rstudio.github.io/dygraphs/shiny.html
library(dygraphs)
library(datasets)

shinyServer(function(input, output) {

  predicted <- reactive({
    hw <- HoltWinters(ldeaths)
    predict(hw, n.ahead = input$months,
            prediction.interval = TRUE,
            level = as.numeric(input$interval))
  })

  output$dygraph <- renderDygraph({
    dygraph(predicted(), main = "Predicted Deaths/Month") %>%
      dySeries(c("lwr", "fit", "upr"), label = "Deaths") %>%
      dyOptions(drawGrid = input$showgrid)
  })

  output$from <- renderText({
    strftime(req(input$dygraph_date_window[[1]]), "%d %b %Y")
  })

  output$to <- renderText({
    strftime(req(input$dygraph_date_window[[2]]), "%d %b %Y")
  })

  output$clicked <- renderText({
    strftime(req(input$dygraph_click$x), "%d %b %Y")
  })

  output$point <- renderText({
    paste0('X = ', strftime(req(input$dygraph_click$x_closest_point), "%d %b %Y"),
         '; Y = ', req(input$dygraph_click$y_closest_point))
  })
})
