# Slightly adapted from http://rstudio.github.io/dygraphs/shiny.html
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
      dyAxis("y", label = "Monthly Deaths") %>%
      dyAnnotation("1983-08-1", text = "A", tooltip = "Local Min") %>%
      dyEvent("1982-06-01", "Summer 1982", labelLoc = "bottom", color="Coral") %>%
      dyRangeSelector(dateWindow = c("1981-01-01", "1984-01-01")) %>%
      dyOptions(drawGrid = input$showgrid, includeZero = TRUE)
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
