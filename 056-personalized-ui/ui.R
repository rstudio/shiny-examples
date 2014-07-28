library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Sales Reports"),
    
    # Dislpay the subtitle computed on the server
    fluidRow(div(class="span12", h3(textOutput("subtitle")))),
    
    # Show the plot of sales
    fluidRow(div(class="span12", plotOutput("salesPlot"))),
    
    # Show the datatable of all sales
    fluidRow(div(class="span12", dataTableOutput("salesTbl")))
  )
)
