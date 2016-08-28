fluidPage(
    
  # Copy the line below to make a date selector 
  dateInput("date", label = h3("Date input"), value = "2014-01-01"),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
)
