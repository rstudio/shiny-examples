library(shiny)

shinyUI(navbarPage(
  title = 'DataTable Options',
  tabPanel('Display length',     dataTableOutput('ex1')),
  tabPanel('Length menu',        dataTableOutput('ex2')),
  tabPanel('No pagination',      dataTableOutput('ex3')),
  tabPanel('No filtering',       dataTableOutput('ex4')),
  tabPanel('Individual filters', dataTableOutput('ex5')),
  tabPanel('Function callback',  dataTableOutput('ex6'))
))
