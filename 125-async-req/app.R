library(shiny)
library(promises)
library(future)
plan(multiprocess)

ui <- fluidPage(
  tags$style(
    "td, th { border: 1px solid #AAA; padding: 6px; }"
  ),
  h1("Test req, req(cancelOutput=TRUE), and validate/need with async"),
  actionButton("boom", "SELF DESTRUCT", class = "btn-danger"),
  p(),
  withTags(
    table(
      tr(
        td(),
        th("sync"),
        th("async")
      ),
      tr(
        th("req"),
        td(textOutput("req")),
        td(textOutput("req_async"))
      ),
      tr(
        th("req(cancelOutput)"),
        td(textOutput("cancelOutput")),
        td(textOutput("cancelOutput_async"))
      ),
      tr(
        th("validate/need"),
        td(textOutput("validateNeed")),
        td(textOutput("validateNeed_async"))
      )
    )
  )
)

server <- function(input, output, session) {
  output$req <- renderText({
    req(!isTruthy(input$boom))
    "After self destruct, this text should disappear"
  })
  output$cancelOutput <- renderText({
    req(!isTruthy(input$boom), cancelOutput = TRUE)
    "After self destruct, this text should remain"
  })
  output$validateNeed <- renderText({
    validate(need(!isTruthy(input$boom), "Self destructed"))
    "After self destruct, this text should be replaced by a grey validation message"
  })

  p <- future({ Sys.sleep(1) })

  output$req_async <- renderText({
    p %...>% {req(!isTruthy(input$boom))} %...>%
    {"After self destruct, this text should disappear"}
  })
  output$cancelOutput_async <- renderText({
    p %...>% {req(!isTruthy(input$boom), cancelOutput = TRUE)} %...>%
    {"After self destruct, this text should remain"}
  })
  output$validateNeed_async <- renderText({
    p %...>% {validate(need(!isTruthy(input$boom), "Self destructed"))} %...>%
    {"After self destruct, this text should be replaced by a grey validation message"}
  })
}

shinyApp(ui, server)
