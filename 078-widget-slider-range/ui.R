fluidPage(
    
  # Copy the line below to make a slider bar with a range
  sliderInput("slider2", label = h3("Slider Range"), min = 0, max = 100, 
    value = c(25, 75)),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
    
)
