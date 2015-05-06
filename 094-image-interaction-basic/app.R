library(png)

ui <- fluidPage(
  # Some custom CSS for a smaller font for preformatted text
  tags$head(
    tags$style(HTML("
      pre, table.table {
        font-size: smaller;
      }
    "))
  ),

  fluidRow(
    column(width = 4),
    column(width = 4,
      br(),
      # In a imageOutput, passing values for click, dblclick, hover, or brush
      # will enable those interactions.
      imageOutput("image1", height = 350,
        # Equivalent to: click = clickOpts(id = "image_click")
        click = "image_click",
        dblclick = dblclickOpts(
          id = "image_dblclick"
        ),
        hover = hoverOpts(
          id = "image_hover"
        ),
        brush = brushOpts(
          id = "image_brush"
        )
      ),
      br()
    )
  ),
  fluidRow(
    column(width = 3,
      verbatimTextOutput("click_info")
    ),
    column(width = 3,
      verbatimTextOutput("dblclick_info")
    ),
    column(width = 3,
      verbatimTextOutput("hover_info")
    ),
    column(width = 3,
      verbatimTextOutput("brush_info")
    )
  )
)


server <- function(input, output, session) {

  # Generate an image with black lines every 10 pixels
  output$image1 <- renderImage({
    # Get width and height of image output
    width  <- session$clientData$output_image1_width
    height <- session$clientData$output_image1_height
    npixels <- width * height

    # Fill the pixels for R, G, B
    m <- matrix(1, nrow = height, ncol = width)
    # Add gray vertical and horizontal lines every 10 pixels
    m[seq_len(ceiling(height/10)) * 10 - 9, ] <- 0.75
    m[, seq_len(ceiling(width/10)) * 10 - 9]  <- 0.75

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
      height = height,
      alt = "This is alternate text"
    )
  })

  output$click_info <- renderPrint({
    cat("input$image_click:\n")
    str(input$image_click)
  })
  output$hover_info <- renderPrint({
    cat("input$image_hover:\n")
    str(input$image_hover)
  })
  output$dblclick_info <- renderPrint({
    cat("input$image_dblclick:\n")
    str(input$image_dblclick)
  })
  output$brush_info <- renderPrint({
    cat("input$image_brush:\n")
    str(input$image_brush)
  })

}


shinyApp(ui, server)
