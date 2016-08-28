fluidPage(
  titlePanel("isolate example"),
  fluidRow(
    column(4, wellPanel(
      sliderInput("n", "n (isolated):",
                  min = 10, max = 1000, value = 200, step = 10),

      textInput("text", "text (not isolated):", "input text"),

      br(),
      actionButton("goButton", "Go!")
    )),
    column(8,
      h4("summary"),
      textOutput("summary"),
      h4("summary2"),
      textOutput("summary2")
    )
  )
)
