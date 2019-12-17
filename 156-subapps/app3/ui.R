library(leaflet)

tagList(
  leaflet(width="100%", height="100%") %>% addTiles(),
  tags$style("html, body { width: 100%; height: 100%; }")
)
