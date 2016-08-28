fluidPage(
  titlePanel("reactivePoll and reactiveFileReader"),
  fluidRow(
    column(12,
      p("This app has a log file which is appended to",
        "every second.")
    )
  ),
  fluidRow(
    column(6, wellPanel(
      "This side uses a reactiveFileReader, which is monitoring",
      "the log file for changes every 0.5 seconds.",
      verbatimTextOutput("fileReaderText")
    )),

    column(6, wellPanel(
      "This side uses a reactivePoll, which is monitoring",
      "the log file for changes every 4 seconds.",
      verbatimTextOutput("pollText")
    ))
  )
)
