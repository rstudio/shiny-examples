library(shiny)
library(mclust)

function(input, output, session) {
  
  # Create a spot where we can store additional
  # reactive values for this session
  val <- reactiveValues(x=NULL, y=NULL)    
  
  # Listen for clicks
  observe({
    # Initially will be empty
    if (is.null(input$clusterClick)){
      return()
    }
    
    isolate({
      val$x <- c(val$x, input$clusterClick$x)
      val$y <- c(val$y, input$clusterClick$y)
    })
  })
  
  # Count the number of points
  output$numPoints <- renderText({
    length(val$x)
  })
  
  # Clear the points on button click
  observe({
    if (input$clear > 0){
      val$x <- NULL
      val$y <- NULL
    }
  })
  
  # Generate the plot of the clustered points
  output$clusterPlot <- renderPlot({
    
    tryCatch({
      # Format the data as a matrix
      data <- matrix(c(val$x, val$y), ncol=2)
      
      # Try to cluster       
      if (length(val$x) <= 1){
        stop("We can't cluster less than 2 points")
      } 
      suppressWarnings({
        fit <- Mclust(data)
      })
      
      mclust2Dplot(data = data, what = "classification", 
                   classification = fit$classification, main = FALSE,
                   xlim=c(-2,2), ylim=c(-2,2))
    }, error=function(warn){
      # Otherwise just plot the points and instructions
      plot(val$x, val$y, xlim=c(-2, 2), ylim=c(-2, 2), xlab="", ylab="")
      text(0, 0, "Unable to create clusters.\nClick to add more points.")
    })
  })
}
