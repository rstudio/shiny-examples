library(shiny)
library(plotly)
library(htmlwidgets)

ui <- fluidPage(
  plotlyOutput("p1", height = 200),
  plotlyOutput("p2", height = 200),
  plotlyOutput("p3", height = 200),
  plotlyOutput("p4", height = 200),
  plotlyOutput("p5", height = 200),
  plotlyOutput("p6", height = 200)
)

no_name <- "
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

named <- "
function myFun(el) {
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
      text = if (packageVersion("htmlwidgets") <= "1.5.1") "Please upgrade htmlwidgets" else "Test did not pass :(",
      x = 0,
      y = 0,
      showarrow = FALSE
    ) %>%
    config(displayModeBar = FALSE)

  output$p1 <- renderPlotly({
    onRender(p, no_name)
  })

  output$p2 <- renderPlotly({
    onRender(p, paste0("(", no_name, ")"))
  })

  output$p3 <- renderPlotly({
    onRender(p, paste0("(", no_name, ");"))
  })

  output$p4 <- renderPlotly({
    onRender(p, named)
  })

  output$p5 <- renderPlotly({
    onRender(p, paste0("(", named, ")"))
  })

  output$p6 <- renderPlotly({
    onRender(p, paste0("(", named, ");"))
  })
}

shinyApp(ui, server)
