library(shiny)

# Define UI for app
ui <- fluidPage(
  # App title ----
  titlePanel("Suppress Whitespace!"),

  tags$div(id="first", "Click to learn more about '", tags$a(href="https://shiny.rstudio.com", "Shiny"), "'."),
  tags$div(id="firstOutcome", class="alert alert-info"),
  tags$hr(),
  tags$div(id="second", "Click to learn more about '", tags$a(href="https://shiny.rstudio.com", "Shiny", .noWS="outside"), "'."),
  tags$div(id="secondOutcome", class="alert alert-info"),
  tags$hr(),
  helpText("The first link above doesn't specify a `.noWS` argument, so spacing is added around the link which isn't the ideal presentation since we want to enquote it. The second link sets `.noWS=\"outside\"` to squash the whitespace around the link."),
  tags$script("
// Some JavaScript to help automate testing
function testWhitespace(inputId, outputId){
  var output = $('#' + outputId);
  if (/'Shiny'/.test($('#' + inputId).text())){
    output.text('No whitespace detected ^');
  } else {
    output.text('Whitespace detected ^');
  }
}
testWhitespace('first', 'firstOutcome');
testWhitespace('second', 'secondOutcome');
")
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {


}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
