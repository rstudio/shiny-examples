library(shiny)
library(leaflet)

ui <- fluidPage(
  p("This app checks whether htmlwidgets can be loaded if the htmlwidgets dependency isn't part of the initial page load. ",
    "See ",
    a(href = "https://github.com/ramnathv/htmlwidgets/issues/349", "htmlwidgets#349"),
    " for more details."
  ),
  p("Verify the following:"),
  tags$ol(
    tags$li("A 'Static render complete' alert DOES NOT appear."),
    tags$li("An 'onRender called' alert appears."),
    tags$li("The map appears, with background tiles and markers."),
  ),
  uiOutput("ui"),
)

server <- function(input, output, session) {
  output$ui <- renderUI({
    tagList(
      leafletOutput("map"),
      htmlwidgets::onStaticRenderComplete("alert('Static render complete');")
    )
  })
  
  output$map <- renderLeaflet({
    leaflet(quakes) %>%
      addTiles() %>%
      addMarkers() %>%
      htmlwidgets::onRender("function(el, x) { alert('onRender called'); }")
  })
}

shinyApp(ui, server)
