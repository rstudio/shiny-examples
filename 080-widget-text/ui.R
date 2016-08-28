fluidPage(
    
  # Copy the line below to make a text input box
  textInput("text", label = h3("Text input"), value = "Enter text..."),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
      
)
