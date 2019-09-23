library(shiny)

options(shiny.jquery.version = NULL)

ui <- fluidPage(
  p("This test verifies the default jQuery version."),
  p("The number below is the jQuery version number. It should begin with a 3."),
  tags$script(HTML("
    document.write(jQuery.fn.jquery);
  "))
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
