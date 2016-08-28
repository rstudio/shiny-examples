fluidPage(
    
  # Copy the line below to make an action button
  actionButton("action", label = "Action"),
  
  hr(),
  fluidRow(column(2, verbatimTextOutput("value")))
  
)
