library(shiny)

op <- options(digits.secs = 3)
onStop(function() {
  options(op)
})

testCaseUI <- function(expectation, explanation, code) {
  tagList(
    hr(),
    pre(code),
    p(
      strong(expectation),
      br(),
      explanation
    ),
    tags$button(
      class = "btn btn-default",
      onclick = code,
      "Run"
    )
  )
}

ui <- fluidPage(
  h2("Test cases for setInputValue priorities"),
  div(style = "max-width: 600px",
      testCaseUI(
        "Clicking the button should print a console message, but only the first time it's clicked.",
        "All subsequent calls are deduplicated.",
        "Shiny.setInputValue('one', 1);"
      ),
      testCaseUI(
        "Clicking the button should print a console message, every time.",
        "Events are never subject to deduplication.",
        "Shiny.setInputValue('two', 2, {priority: 'event'});"
      ),
      testCaseUI(
        "Clicking the button should print two console messages, every time.",
        "Events are not coalesced.",
        "Shiny.setInputValue('three', 3, {priority: 'event'});\nShiny.setInputValue('three', 3, {priority: 'event'});"
      ),
      testCaseUI(
        "Clicking the button should print one console message, every time.",
        "On the first click, the first (non-event) call coalesces into the second call; on subsequent clicks, it's ignored due to deduplication.",
        "Shiny.setInputValue('four', 4);\nShiny.setInputValue('four', 4, {priority: 'event'});"
      ),
      testCaseUI(
        "Clicking the button should print one console message, every time.",
        "The second (non-event) call is ignored due to deduplication.",
        "Shiny.setInputValue('five', 5, {priority: 'event'});\nShiny.setInputValue('five', 5);"
      ),
      testCaseUI(
        "Clicking the button should print one console message, every time.",
        "The first (non-event) call coalesces into the second call.",
        "Shiny.setInputValue('six', '6a');\nShiny.setInputValue('six', '6b', {priority: 'event'});"
      ),
      testCaseUI(
        "Clicking the button should print two console messages, every time.",
        "Because the event call happens first, the second call is not coalesced.",
        "Shiny.setInputValue('seven', '7a', {priority: 'event'});\nShiny.setInputValue('seven', '7b');"
      )
  )
)

server <- function(input, output, session) {
  lapply(c("one", "two", "three", "four", "five", "six", "seven"), function(i) {
    observeEvent(input[[i]], {
      message("[", Sys.time(), "] ", i, ": ", input[[i]])
    })
  })
}

shinyApp(ui, server)
