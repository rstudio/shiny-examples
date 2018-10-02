library(shiny)
library(ggplot2)
library(scales)
library(png)

# Data set with points on a grid
grid_data <- data.frame(
  x = rep(2^(1:20), 10),
  y = rep(10^(1:10), each = 20),
  brush_target = FALSE
)

grid_xmin <- 2 ^ 5.9
grid_xmax <- 2 ^ 12.1
grid_ymin <- 10 ^ 2.9
grid_ymax <- 10 ^ 7.1

grid_data$brush_target[grid_data$x >= grid_xmin & grid_data$x <= grid_xmax &
                       grid_data$y >= grid_ymin & grid_data$y <= grid_ymax] <- TRUE

# Dimensions of box in imageOutput
image_xmin <- 200
image_xmax <- 350
image_ymin <- 130
image_ymax <- 230

shinyApp(
  fluidPage(
    tags$head(tags$style("img { transform: scale(0.7, 0.8); padding: 30px; background-color: #eeaaaa; }")),
    h3("Testing instructions"),
    p('For each plot, brush over the rectangle. Each one should say "Pass".',
      'Then resize the browser window. Each one should still say "Pass".'),
    p("This application should be tested on both Retina and non-Retina displays."),

    h3("renderPlot"),
    plotOutput("plot1",brush = "plot1_brush"),
    uiOutput("plot1_brush_works"),

    hr(),
    h3("renderPlot with specified size"),
    plotOutput("plot2", brush = "plot2_brush"),
    uiOutput("plot2_brush_works"),

    hr(),
    h3("renderCachedPlot"),
    p("Note: there are two types of resizes for renderCachedPlot.",
      "For small changes in size, it will simply scale the image in the browser.",
      "For large changes in size, the server will render a new plot and send it to the browser.",
      "Both types of resizes should keep a passing status."),
    plotOutput("plot3", brush = "plot3_brush"),
    uiOutput("plot3_brush_works"),

    hr(),
    h3("imageOutput"),
    imageOutput("image", brush = "image_brush"),
    uiOutput("image_brush_works")
  ),
  function(input, output, session) {

    plot_grid_data <- function() {
      ggplot(grid_data, aes(x, y)) +
        geom_point() +
        annotate("rect", xmin = grid_xmin, xmax = grid_xmax, ymin = grid_ymin, ymax = grid_ymax,
          fill = "transparent", color = "black", linetype = "dashed") +
        scale_x_continuous(trans = log2_trans(),
          breaks = trans_breaks("log2", function(x) 2^x),
          labels = trans_format("log2", math_format(2^.x))) +
        scale_y_continuous(breaks = trans_breaks("log10", function(x) 10^x),
          labels = trans_format("log10", math_format(10^.x))) +
        coord_trans(y = "log10")
    }

    check_brush <- function(brush_info) {
      dt <- brushedPoints(grid_data, brush_info)

      # Check correct points are selected
      if (nrow(dt) == sum(grid_data$brush_target) && all(dt$brush_target)) {
        tags$h4(tags$span("Brush: Pass", style = "background-color: #7be092;"))
      } else {
        tags$h4(tags$span("Brush: Fail", style = "background-color: #e07b7b;"))
      }
    }


    output$plot1 <- renderPlot({
      plot_grid_data()
    })
    output$plot1_brush_works <- renderUI({
      check_brush(input$plot1_brush)
    })


    output$plot2 <- renderPlot({
      plot_grid_data()
    }, width = 500, height = 300)
    output$plot2_brush_works <- renderUI({
      check_brush(input$plot2_brush)
    })


    output$plot3 <- renderCachedPlot({
      plot_grid_data()
    }, cacheKeyExpr = grid_data)
    output$plot3_brush_works <- renderUI({
      check_brush(input$plot3_brush)
    })


    output$image <- renderImage({
      # Get width and height of image output
      width  <- session$clientData$output_image_width
      height <- session$clientData$output_image_height
      npixels <- width * height

      # Fill the pixels for R, G, B
      m <- matrix(1, nrow = height, ncol = width)
      # Add a gray box
      m[seq(image_ymin, image_ymax), seq(image_xmin, image_xmax)] <- 0.75

      # Convert the vector to an array with 3 planes
      img <- array(c(m, m, m), dim = c(height, width, 3))

      # Write it to a temporary file
      outfile <- tempfile(fileext = ".png")
      writePNG(img, target = outfile)

      # Return a list containing information about the image
      list(
        src = outfile,
        contentType = "image/png",
        width = width,
        height = height
      )
    })
    output$image_brush_works <- renderUI({
      b <- input$image_brush

      near <- function(a, b, threshold = 5) {
        abs(a - b) <= threshold
      }

      # Check that brush is close to box dimensions
      if (!is.null(b) &&
          near(image_xmin, b$xmin) && near(image_xmax, b$xmax) &&
          near(image_ymin, b$ymin) && near(image_ymax, b$ymax))
      {
        tags$h4(tags$span("Brush: Pass", style = "background-color: #7be092;"))
      } else {
        tags$h4(tags$span("Brush: Fail", style = "background-color: #e07b7b;"))
      }
    })
  }
)
