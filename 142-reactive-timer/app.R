library(shiny)

ui <- fluidPage(
  h2("reactiveTimer test"),
  p("This test exercises two reactiveTimers. One is global, one is per-session."),

  fluidRow(
    column(2, strong("Global:"), textOutput("global_counter", inline = TRUE)),
    column(2, strong("Session:"), textOutput("session_counter", inline = TRUE))
  ),

  h4(style = "margin-top: 40px", "Test 1"),
  p(
    "Ensure that the two numbers count upwards by one, both in the browser and in the console.",
    br(),
    "(It's OK if the counting is not perfectly synchronized.)"
  ),

  h4(style = "margin-top: 40px", "Test 2"),
  p("Push this button and ensure that the web and console counters pause for 5 seconds, then resume."),
  actionButton("busy_sync", "Be busy for 5 seconds (sync)"),

  h4(style = "margin-top: 40px", "Test 3"),
  p(
    "Push this button; both web counters should pause for 5 seconds, then jump ahead by 5. ",
    "The Global web counter will appear faded. ",
    "In the console, Glob should continue unabated, while Sess pauses for 5 seconds, then jumps ahead by 5."
  ),
  actionButton("busy_async", "Be busy for 5 seconds (async)")
)

global_timer <- reactiveTimer(1000)

server <- function(input, output, session) {
  session_timer <- reactiveTimer(1000)

  global_counter_i <- 0L
  global_counter <- reactive({
    global_timer()
    on.exit(global_counter_i <<- global_counter_i + 1L)

    global_counter_i
  })

  session_counter_i <- 0L
  session_counter <- reactive({
    session_timer()
    on.exit(session_counter_i <<- session_counter_i + 1L)

    session_counter_i
  })

  output$global_counter <- renderText(global_counter())
  output$session_counter <- renderText(session_counter())

  observe({
    message("Glob: ", global_counter())
  })
  observe({
    message("Sess: ", session_counter())
  })

  observeEvent(input$busy_sync, {
    Sys.sleep(5)
  })

  observeEvent(input$busy_async, {
    promises::promise(~{later::later(~resolve(NULL), 5)})
  })
}

shinyApp(ui, server)
