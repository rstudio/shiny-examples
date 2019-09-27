library(shiny)

options(shiny.jquery.version = 1)
onStop(function() {
  options(shiny.jquery.version = NULL)
})

ui <- fluidPage(
  p(HTML("This test verifies that app authors can opt into using jQuery 1 using <code>options(shiny.jquery.version)</code>.")),
  p("The number below is the jQuery version number. It should begin with a 1."),
  tags$script(HTML("
    document.write(jQuery.fn.jquery);
  "))
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
