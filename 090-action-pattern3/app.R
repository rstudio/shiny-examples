library(shiny)

ui <- fluidPage(
  actionButton("runif", "Uniform"),
  actionButton("rnorm", "Normal"), 
  hr(),
  plotOutput("plot")
)

server <- function(input, output){
  v <- reactiveValues(data = NULL)

  observeEvent(input$runif, {
    v$data <- runif(100)
  })

  observeEvent(input$rnorm, {
    v$data <- rnorm(100)
  })  

  output$plot <- renderPlot({
    if (is.null(v$data)) return()
    hist(v$data)
  })
}

shinyApp(ui, server)