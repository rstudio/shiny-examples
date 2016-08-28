fluidPage(
    
  # Copy the line below to make a file upload manager
  fileInput("file", label = h3("File input")),
  
  hr(),
  fluidRow(column(4, verbatimTextOutput("value")))
  
)
