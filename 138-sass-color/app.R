library(shiny)
library(sass)
library(colourpicker)

input_scss <- "new-style.scss"
output_css <- "new-style.css"

style_list <- list(
  `$color` = "#FFFFFF"
)

sass(input_scss, output = output_css)

ui <- fluidPage(
  headerPanel("Sass Example"),

  sidebarPanel(
    colourInput("color", "Background Color", value = 'white',
                showColour = "text")
  ),

  mainPanel(
    plotOutput("distPlot"),
    br()
  ),

  column(6, verbatimTextOutput("scss")),
  column(6, verbatimTextOutput("css")),

  uiOutput("bgcolor")
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(500))
  })

  variables <- reactive({
    style_list$`$color` <- input$color
    style_list$`$width` <- input$width
    paste0(names(style_list), ": ", style_list, ";", collapse = '\n')
  })

  compiled_css <- reactive({
    write(variables(), "_variables.scss")
    sass(input_scss, output = output_css)
  })

  output$bgcolor <- renderUI({
    compiled_css()
    includeCSS(output_css)
  })

  output$scss <- renderText({
    scss <- paste0(readLines("new-style.scss"), collapse = '\n')
    paste0("/* _variables.scss */\n", variables(), "\n\n",
           "/* new-style.scss */\n", scss)
  })

  output$css <- renderText({
    paste0("/* new-style.css */\n", compiled_css())
  })
}

shinyApp(ui, server)
