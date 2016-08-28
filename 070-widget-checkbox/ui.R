fluidPage(
    
  # Copy the line below to make a checkbox
  checkboxInput("checkbox", label = "Choice A", value = TRUE),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
)
