library(shiny)
library(promises)
library(future)
plan(multiprocess)

ui <- fluidPage(
  h1("Test async flush"),
  p("When the Go button is pressed:"),
  tags$ul(
    tags$li("The plot should take 3 seconds to appear/update (it should not be faster than that)"),
    tags$li("The R console should have BEGIN and END lines not interrupted by any other messages"),
    tags$li(
      "The R console should include ",
      tags$code("onFlush[ed](once=[TRUE|FALSE])"),
      " lines (4 in all) immediately after END"
    )
  ),
  hr(),
  actionButton("go", "Go"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    req(input$go)
    plot(rnorm(10))
  })

  observeEvent(input$go, {
    session$onFlushed(function() {
      message("onFlushed(once=TRUE)")
    })
    session$onFlush(function() {
      message("onFlush(once=TRUE)")
    })

    message("BEGIN")
    future(Sys.sleep(3)) %...>%
      { message("END") }
  })

  session$onFlush(function() {
    message("onFlush(once=FALSE)")
  }, once = FALSE)
  session$onFlushed(function() {
    message("onFlushed(once=FALSE)")
  }, once = FALSE)
}

shinyApp(ui, server)
