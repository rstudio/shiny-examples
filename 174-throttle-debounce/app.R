library(shiny)
library(magrittr)

ui <- fluidPage(
  fluidRow(
    column(12,
      h1("Throttle/debounce test app"),
      p("Click the button quickly. 'Unmetered' should update constantly. 'Throttle' should update every second. 'Debounce' should update only after you've stopped clicking for one second."),
      hr(),
      actionButton("click", "Increment")
    ),
    column(4,
      h3("Unmetered"),
      verbatimTextOutput("raw")
    ),
    column(4,
      h3("Throttle (1 second)"),
      verbatimTextOutput("throttle")
    ),
    column(4,
      h3("Debounce (1 second)"),
      verbatimTextOutput("debounce")
    )
  )
)

server <- function(input, output, session) {

  pos_raw <- reactive(input$click)
  pos_throttle <- pos_raw %>% throttle(1000)
  pos_debounce <- pos_raw %>% debounce(1000)

  output$raw <- renderText({
    pos_raw()
  })

  output$throttle <- renderText({
    pos_throttle()
  })

  output$debounce <- renderText({
    pos_debounce()
  })

}

shinyApp(ui, server)
