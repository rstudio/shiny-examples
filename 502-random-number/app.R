#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for the app
ui <- fluidPage(
  titlePanel("Random number generator"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "digit_type", "Number of digits:",
        c("any", "selected")
      ),
      conditionalPanel(
        condition = "input.digit_type == 'selected'",
        sliderInput("digit_count", "How many digits?",
                    min = 1, max = 10, value = 4
        )
      ),
      actionButton("go", "Generate new random number"),
      width = 5
    ),
    mainPanel(
      br(),
      "Your random number is",
      h4(textOutput("random_number")),
      width = 7
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$random_number <- renderText({
    input$go
    raw <- runif(1)
    digits <- if (input$digit_type == "any") {
      sample(1:10, size = 1)
    } else {
      input$digit_count
    }
    round(raw * 10^digits)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
