library(shiny)

addResourcePath("session", system.file(package = "httpuv"))
addResourcePath("images", system.file(package = "shiny"))

onStop(function() {
  removeResourcePath("session")
  removeResourcePath("images")
})

ui <- fluidPage(
  "You should see two warnings about resource paths in your R console.",
  # This image is here to ensure that addResourcePath("images", ...)
  # throws a warning when your app has a www/images directory.
  img(src = "images/rstudio.png", style = "display:none")
)

server <- function(input, output, session) {

}

shinyApp(ui, server)


