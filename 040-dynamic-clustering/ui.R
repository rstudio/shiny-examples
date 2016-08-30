library(shiny)

# Create a bootstrap fluid layout
fluidPage(
  
  # Add a title
  titlePanel("Dynamic Clustering in Shiny"),
  
  # Add a row for the main content
  fluidRow(
    
    # Create a space for the plot output
    plotOutput(
        "clusterPlot", "100%", "500px", click="clusterClick"
    )
  ),
  
  # Create a row for additional information
  fluidRow(
    # Take up 2/3 of the width with this element  
    mainPanel("Points: ", verbatimTextOutput("numPoints")),
    
    # And the remaining 1/3 with this one
    sidebarPanel(actionButton("clear", "Clear Points"))
  )    
)
