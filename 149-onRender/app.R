library(shiny)
library(plotly)
library(htmlwidgets)

ui <- fluidPage(
  plotlyOutput("p1", height = 200),
  plotlyOutput("p2", height = 200),
  plotlyOutput("p3", height = 200)
)

jsCode <- "
function(el) {
   var ann = {
     text: 'Test passed!',
     x: 0,
     y: 0,
     showarrow: false
   };
   Plotly.relayout(el.id, {annotations: [ann]});
}
"

server <- function(input, output, session) {

  p <- plotly_empty() %>%
    add_annotations(
      text = if (packageVersion("htmlwidgets") < "1.4") "Please install htmlwidgets v1.4 or higher and try again" else "Test did not pass :(",
      x = 0,
      y = 0,
      showarrow = FALSE
    )

  # function declarations work
  output$p1 <- renderPlotly({
    onRender(p, jsCode)
  })

  # expressions work
  output$p2 <- renderPlotly({
    onRender(p, paste0("(", jsCode, ")"))
  })

  # statements work
  output$p3 <- renderPlotly({
    onRender(p, paste0("(", jsCode, ");"))
  })
}

shinyApp(ui, server)
