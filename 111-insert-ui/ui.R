library(shiny)

fluidPage( 
  actionButton('insertBtn', 'Insert'), 
  actionButton('removeBtn', 'Remove'), 
  tags$div(id = 'placeholder') 
)
