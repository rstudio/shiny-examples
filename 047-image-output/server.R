library(png) # For writePNG function

# Return a matrix with 2d guassian distribution
gauss2d <- function(x, y, r = 0.15) {
  exp(
    -((x - 0.5)^2 + (y - 0.5)^2) /
    (2 * r^2)
  )
}

function(input, output, session) {

  # image1 creates a new PNG file each time Radius changes
  output$image1 <- renderImage({
    # Get width and height of image1
    width  <- session$clientData$output_image1_width
    height <- session$clientData$output_image1_height

    # A temp file to save the output.
    # This file will be automatically removed later by
    # renderImage, because of the deleteFile=TRUE argument.
    outfile <- tempfile(fileext = ".png")

    # Generate the image and write it to file
    x <- matrix(rep((0:(width-1))/(width-1), height), height,
                byrow = TRUE)
    y <- matrix(rep((0:(height-1))/(height-1), width), height)
    pic <- gauss2d(x, y, input$r)
    writePNG(pic, target = outfile)

    # Return a list containing information about the image
    list(src = outfile,
         contentType = "image/png",
         width = width,
         height = height,
         alt = "This is alternate text")

  }, deleteFile = TRUE)


  # image2 sends pre-rendered images
  output$image2 <- renderImage({
    if (is.null(input$picture))
      return(NULL)

    if (input$picture == "face") {
      return(list(
        src = "images/face.png",
        contentType = "image/png",
        alt = "Face"
      ))
    } else if (input$picture == "chainring") {
      return(list(
        src = "images/chainring.jpg",
        filetype = "image/jpeg",
        alt = "This is a chainring"
      ))
    }

  }, deleteFile = FALSE)
}
