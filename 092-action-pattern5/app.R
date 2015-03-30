library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(id = "tabset",
        tabPanel("Uniform",
          numericInput("unifCount", "Count", 100),
          sliderInput("unifRange", "Range", min = -100, max = 100, value = c(-10, 10))
        ),
        tabPanel("Normal",
          numericInput("normCount", "Count", 100),
          numericInput("normMean", "Mean", 0),
          numericInput("normSd", "Std Dev", 1)
        )
      ),
      actionButton("go", "Plot")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output){
  v <- reactiveValues(doPlot = FALSE)

  observeEvent(input$go, {
    # 0 will be coerced to FALSE
    # 1+ will be coerced to TRUE
    v$doPlot <- input$go
  })

  observeEvent(input$tabset, {
    v$doPlot <- FALSE
  })  

  output$plot <- renderPlot({
    if (v$doPlot == FALSE) return()

    isolate({
      data <- if (input$tabset == "Uniform") {
        runif(input$unifCount, input$unifRange[1], input$unifRange[2])
      } else {
        rnorm(input$normCount, input$normMean, input$normSd)
      }
      
      hist(data)
    })
  })
}

shinyApp(ui, server)