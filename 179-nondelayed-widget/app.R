library(shiny)
library(leaflet)

ui <- fluidPage(
  p("This is similar to 178-delayed-widget, except the htmlwidget dependency is present right from the beginning."),
  p("Verify the following:"),
  tags$ol(
    tags$li("A 'Static render complete' alert appears."),
    tags$li("An 'onRender called' alert appears."),
    tags$li("The map appears, with background tiles and markers."),
  ),
  tagList(
    leafletOutput("map"),
    htmlwidgets::onStaticRenderComplete("alert('Static render complete');")
  )
)

server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet(quakes) %>%
      addTiles() %>%
      addMarkers() %>%
      htmlwidgets::onRender("function(el, x) { alert('onRender called'); }")
  })
}

shinyApp(ui, server)
