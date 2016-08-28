fluidPage(
    
  # Copy the chunk below to make a group of checkboxes
  checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
    choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
    selected = 1),
  
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
)
