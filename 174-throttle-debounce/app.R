library(shiny)
library(magrittr)

ui <- fluidPage(
  tags$script(HTML("window.onmousemove = e => { if (Shiny) { Shiny.setInputValue('mousepos', {x: e.clientX, y: e.clientY}); } };")),
  fluidRow(
    column(12,
      h1("Throttle/debounce test app"),
      p("Move the mouse around the page. 'Unmetered' should update constantly. 'Throttle' should update every second. 'Debounce' should update only after you've stopped moving the mouse for a second.")
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

  pos_raw <- reactive(req(input$mousepos))
  pos_throttle <- pos_raw %>% throttle(1000)
  pos_debounce <- pos_raw %>% debounce(1000)

  output$raw <- renderPrint({
    pos_raw()
  })

  output$throttle <- renderPrint({
    pos_throttle()
  })

  output$debounce <- renderPrint({
    pos_debounce()
  })

}

shinyApp(ui, server)
