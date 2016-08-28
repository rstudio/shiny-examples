basicPage(
  h4(
    "The time is ",
    # We give textOutput a span container to make it appear
    # right in the h4, without starting a new line.
    textOutput("currentTime", container = span)
  ),
  selectInput("interval", "Update every:", c(
    "5 seconds" = "5000",
    "1 second" = "1000",
    "0.5 second" = "500"
  ), selected = 1000, selectize = FALSE)
)
