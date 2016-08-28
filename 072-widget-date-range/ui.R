fluidPage(
    
  # Copy the line below to make a date range selector
  dateRangeInput("dates", label = h3("Date range")),

  hr(),
  fluidRow(column(4, verbatimTextOutput("value")))
  
)
