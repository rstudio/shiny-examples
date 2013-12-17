shinyUI(fluidPage(
  
  titlePanel("Hello Shiny!"),
  
  # put the side bar on the right
  sidebarLayout(position = "right",
    
    sidebarPanel(
      sliderInput("obs", "Number of observations:",  
                  min = 1, max = 1000, value = 500)
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
