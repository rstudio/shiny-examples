library(shiny)
library(promises)
library(future)
plan(multicore)
library(ggplot2)

ui <- fluidPage(
  tags$style("p { max-width: 600px; }"),
  h2("Measuring async overhead"),
  p("This app measures the amount of time it takes a trivial async renderText
     output to run, in both success and failure cases. Click the buttons below
     to measure elapsed time."),
  p("The worst-case scenario is clicking Failure with deepstacktrace checked. On
     a 2018 MacBook Pro, regularly getting times over 50ms should be considered
     an issue."),
  p("Very occasional spikes--or a spike on the first click after launch--are to
     be expected, due to warmup or garbage collection, though these should still
     be will under 100ms."),
  hr(),
  checkboxInput("deepstacktrace", "Deep stack traces enabled?", getOption("shiny.deepstacktrace", FALSE)),
  textOutput("summary"),
  actionButton("success", "Benchmark success"),
  actionButton("failure", "Benchmark failure"),
  textOutput("time")
)

server <- function(input, output, session) {
  mode <- reactiveVal()
  elapsed <- reactiveVal()
  
  observeEvent(input$deepstacktrace, {
    options(shiny.deepstacktrace = input$deepstacktrace)
  })
  
  output$foo1 <- renderText({
    req(input$success)
    
    mode("Success")
    start_time <- Sys.time()
    promise_resolve(TRUE) %...>%
      identity %>%
      finally(~{elapsed(Sys.time() - start_time)})
  })
  outputOptions(output, "foo1", suspendWhenHidden = FALSE)
  
  output$foo2 <- renderText({
    req(input$failure)
    
    mode("Failure")
    start_time <- Sys.time()
    promise_resolve("boom") %...>%
      stop %>%
      finally(~{elapsed(Sys.time() - start_time)})
  })
  outputOptions(output, "foo2", suspendWhenHidden = FALSE)
  
  output$time <- renderPrint({
    req(elapsed())
    isolate({
      msg <- paste(mode(), "in", format(elapsed()))
      message(msg)
      cat(msg)
    })
  })
}

shinyApp(ui, server)

