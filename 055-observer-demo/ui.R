shinyUI(fluidPage(
  titlePanel("Observer demo"),
  fluidRow(
    column(4, wellPanel(
      sliderInput("n", "N:",
                  min = 10, max = 1000, value = 200, step = 10)
    )),
    column(8,
      verbatimTextOutput("text"),
      br(),
      br(),
      p("In this example, what's visible in the client isn't",
        "what's interesting. The server is writing to a log",
        "file each time the slider value changes.")
    )
  )
))
