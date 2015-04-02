
library(shiny)

shinyUI(
  fluidPage(
    # Setup the page title
    tagList(tags$head(tags$title("Airline Delays")), h1(textOutput("title"))),    
    
    sidebarLayout(
      sidebarPanel(
        uiOutput("userPanel"),
        hr(),
        sliderInput("days", "Prior days to include:", 1, 30, 7, 1),
        hr(),        
        helpText("The graph on the right shows a boxplot of the departure " ,
                 "delays for the airline(s) your username is allowed to view.")
      ),
      mainPanel(
        plotOutput("box")
      )
    )
  )
)
