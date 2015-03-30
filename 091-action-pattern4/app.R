library(shiny)

ui <- fluidPage(
  actionButton("runif", "Uniform"),
  actionButton("reset", "Clear"), 
  hr(),
  plotOutput("plot")
)

server <- function(input, output){
  v <- reactiveValues(data = NULL)

  observeEvent(input$runif, {
    v$data <- runif(100)
  })

  observeEvent(input$reset, {
    v$data <- NULL
  })  

  output$plot <- renderPlot({
    if (is.null(v$data)) return()
    hist(v$data)
  })
}

shinyApp(ui, server)