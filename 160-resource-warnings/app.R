library(shiny)

addResourcePath("session", system.file(package = "httpuv"))
addResourcePath("images", system.file(package = "shiny"))

ui <- fluidPage(
  "You should see two warnings about resource paths in your R console.",
  img(src = "images/rstudio.png", style = "display:none")
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
