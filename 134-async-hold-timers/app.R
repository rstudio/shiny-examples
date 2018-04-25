library(shiny)
library(promises)

wait <- function(secs) {
  force(secs)
  promise(~{later::later(~resolve(TRUE), secs)})
}

ui <- fluidPage(
  h2("Verify timers don't run until async tasks are complete"),
  "If this app runs for about 10 seconds without killing the session, that's success!"
)

server <- function(input, output, session) {
  timer <- reactiveTimer(500)
  
  in_task <- FALSE

  observe({
    invalidateLater(500)
    if (in_task) {
      stop("invalidateLater fired while async observer was active!")
    }
  }, priority = 1)
  
  observe({
    timer()
    if (in_task) {
      stop("reactiveTimer fired while async observer was active!")
    }
  }, priority = 1)
  
  observe({
    timer()
    in_task <<- TRUE
    wait(1300) %...>% {
      in_task <<- FALSE
    }
  })
}

shinyApp(ui, server)

