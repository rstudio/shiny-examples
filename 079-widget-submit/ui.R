fluidPage(
    
  numericInput("num", label = "Make changes", value = 1),
  
  # Copy the line below to place a submit into the UI.
  submitButton("Apply Changes"),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
)
