library(shiny)
library(sassr)
library(colourpicker)

input_scss <- "new-style.scss"
output_css <- "new-style.css"

style_list <- list(
  `$color` = "#FFFFFF"
)

compile_sass(input_scss, output = output_css)

ui <- fluidPage(
  headerPanel("New Application"),

  sidebarPanel(
    colourInput("color", "Background Color", value = 'white',
                showColour = "text")
  ),

  mainPanel(
    plotOutput("distPlot")
  ),

  uiOutput("css")
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(500))
  })

  output$css <- renderUI({
    style_list$`$color` <- input$color

    write(
      paste0(names(style_list), ": ", style_list, ";", collapse = '\n'),
      "_variables.scss"
    )

    compile_sass(input_scss, output = output_css)
    includeCSS(output_css)
  })
}

shinyApp(ui, server)
