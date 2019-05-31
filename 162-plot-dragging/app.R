# Generate a png for renderImage
image_file <- tempfile(fileext='.png')
png(image_file, width=250, height=250)
hist(rnorm(1000))
dev.off()
onStop(function() {
  unlink(image_file)
})


shinyApp(
  ui = fluidPage(
    p("The plot below doesn't have any interactions. It should be draggable."),
    plotOutput("plot_no_interact", height = 250, width = 250),
    
    p("The plot below allows click interactions. It should NOT be draggable."),
    plotOutput("plot_click", height = 250, width = 250, click = "click"),

    p("The plot below allows hover interactions. It should NOT be draggable."),
    plotOutput("plot_hover", height = 250, width = 250, hover = "hover"),

    p("The plot below allows brush interactions. It should NOT be draggable (dragging will draw a brush, not drag the image)."),
    plotOutput("plot_brush", height = 250, width = 250, brush = "brush"),

    p("The plot below allows click and brush interactions. It should NOT be draggable."),
    plotOutput("plot_click_brush", height = 250, width = 250, click = "click2", brush = "brush2"),

    p("The image below doesn't have any interactions. It should be draggable."),
    plotOutput("image_no_interact", height = 250, width = 250),

    p("The image below allows click interactions. It should NOT be draggable."),
    plotOutput("image_click", height = 250, width = 250, click = "click"),

    p("The image below allows brush interactions. It should NOT be draggable."),
    plotOutput("image_brush", height = 250, width = 250, brush = "brush")

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

    output$image_no_interact <- renderImage({
      list(src = image_file)
    }, deleteFile = FALSE)

    output$image_click <- renderImage({
      list(src = image_file)
    }, deleteFile = FALSE)

    output$image_brush <- renderImage({
      list(src = image_file)
    }, deleteFile = FALSE)
  }
)
