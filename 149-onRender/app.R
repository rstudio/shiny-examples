library(shiny)
library(plotly)
library(htmlwidgets)

if (packageVersion("htmlwidgets") < "0.14") {
  warning("This test assumes you have htmlwidgets v0.14 or higher")
}

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
      text = "Test did not pass :(",
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
