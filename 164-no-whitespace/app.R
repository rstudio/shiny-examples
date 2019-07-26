library(shiny)

# Define UI for app
ui <- fluidPage(

  # App title ----
  titlePanel("Hello Shiny!"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(
      tags$div("Click to learn more about '", tags$a(href="https://shiny.rstudio.com", "Shiny"), "'."),
      tags$hr(),
      tags$div("Click to learn more about '", tags$a(href="https://shiny.rstudio.com", "Shiny", .noWS="outside"), "'."),
      tags$hr(),
      helpText("The first link above doesn't specify a `.noWS` argument, so spacing is added around the link which isn't the ideal presentation since we want to enquote it. The second link sets `.noWS=\"outside\"` to squash the whitespace around the link.")
    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Histogram ----
      plotOutput(outputId = "distPlot")

    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {

  # Histogram of the Old Faithful Geyser Data ----
  output$distPlot <- renderPlot({

    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = 10)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")

    })

}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
