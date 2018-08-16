library(shiny)
library(sassr)
library(colourpicker)

input_scss <- "new-style.scss"
output_css <- "new-style.css"

style_list <- list(
  `$color` = "#FFFFFF",
  `$width` = "100"
)

compile_sass(input_scss, output = output_css)

ui <- fluidPage(
  headerPanel("New Application"),

  sidebarPanel(
    sliderInput("width", "Image Percent of Screen",
                min = 1, max = 100, value = 100),
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
    style_list$`$width` <- input$width

    write(
      paste0(names(style_list), ": ", style_list, ";", collapse = '\n'),
      "_variables.scss"
    )

    compile_sass(input_scss, output = output_css)
    includeCSS(output_css)
  })
}

shinyApp(ui, server)
