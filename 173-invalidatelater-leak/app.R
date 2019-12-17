library(shiny)
library(pryr)

# It's possible for this test to fail when reactlog is enabled
op <- options(shiny.reactlog = FALSE)
onStop(function() {
  options(op)
})

ui <- fluidPage(
  p("This application tests if", code("invalidateLater"),
    "causes significant memory leakage. (",
    a("#2555", href = "https://github.com/rstudio/shiny/pull/2555", .noWS = "outside"),
    ")"
  ),
  p("After five iterations it will print out whether it passed or failed."),
  plotOutput("hist1"),
  uiOutput("Memory")
)

server <- function(input, output, session) {
  i <- 0
  last_mem <- mem_used()

  output$hist1 <- renderPlot({
    invalidateLater(500)
    plot(c(1:100))
  })

  output$Memory <- renderUI({
    invalidateLater(500)
    cur_mem <- mem_used()
    on.exit({
      i <<- i + 1
      last_mem <<- cur_mem
    })
    increase <- cur_mem - last_mem

    status <- ""
    if (i >= 5) {
      status <- if (increase <= 512) p(style = "color:green;", "Pass!")
                else                 p(style = "color:green;", "Fail: Leaking too much memory!")
    }

    div(
      pre(
        paste0(
          "\nIteration:    ", i, "\n",
          "Memory usage: ", cur_mem, "\n",
          "Increase:     ", increase, "\n"
        )
      ),
      status
    )

  })
}

shinyApp(ui,server)
