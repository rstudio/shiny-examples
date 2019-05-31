shinyApp(
  ui = fluidPage(
    p("The plot below doesn't have any interactions. It should be draggable."),
    plotOutput("plot_no_interact", height = 250, width = 250),
    
    p("The plot below allows click interactions. It should not be draggable."),
    plotOutput("plot_click", height = 250, width = 250, click = "click"),

    p("The plot below allows hover interactions. It should not be draggable."),
    plotOutput("plot_hover", height = 250, width = 250, hover = "hover"),

    p("The plot below allows brush interactions. It should not be draggable (dragging will draw a brush, not drag the image)."),
    plotOutput("plot_brush", height = 250, width = 250, brush = "brush"),

    p("The plot below allows click and brush interactions. It should not be draggable."),
    plotOutput("plot_click_brush", height = 250, width = 250, click = "click2", brush = "brush2")

  ),
  server = function(input, output) {
    output$plot_no_interact <- renderPlot({
      plot(cars)
    })
    output$plot_click <- renderPlot({
      plot(cars)
    })
    output$plot_hover <- renderPlot({
      plot(cars)
    })
    output$plot_brush <- renderPlot({
      plot(cars)
    })
    output$plot_click_brush <- renderPlot({
      plot(cars)
    })
  }
)
