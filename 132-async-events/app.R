library(shiny)
library(promises)

ui <- fluidPage(
  h2("eventReactive with async event:"),

  radioButtons("type", "Type of event", c(
    "Success" = "success",
    "Silent error (i.e. req(FALSE))" = "silent",
    "Validation error" = "validation",
    "Error" = "error"
  )),

  hr(),

  p("Choose each of the choices above, and verify that the two outputs below always look identical."),

  fluidRow(
    column(3,
      h3("Synchronous"),
      textOutput("sync_output")
    ),
    column(3,
      h3("Asynchronous"),
      textOutput("async_output")
    )
  ),

  br(),
  br(),
  br(),
  br(),

  h2("observeEvent with async event:"),

  p("Try all of these buttons, and confirm that they exhibit the expected behavior."),

  p(
    actionButton("success", "Success"),
    "After a one second delay, you should see a success message printed at the R console"
  ),
  p(
    actionButton("silent", "Silent error (i.e. req(FALSE))"),
    "Should have no effect"
  ),
  p(
    actionButton("validation", "Validation error"),
    "Should have no effect"
  ),
  p(
    actionButton("error", "Error"),
    "The session should be disconnected and an error printed at the console"
  )
)

server <- function(input, output, session) {
  root <- eventReactive(input$type, {
    switch(input$type,
      success = TRUE,
      error = stop("error!"),
      silent = req(FALSE),
      validation = validate(need(FALSE, "Validation error"))
    )
  })

  sync_er <- eventReactive(root(), {
    "normal value"
  })

  async_er <- eventReactive(promise_resolve(TRUE) %...>% {root()}, {
    "normal value"
  })

  output$sync_output <- renderText({
    sync_er()
  })

  output$async_output <- renderText({
    async_er()
  })

  delay <- function(expr) {
    promise(function(resolve, reject) {
      later::later(~resolve(TRUE), 1)
    }) %...>% { force(expr) }
  }

  observeEvent({req(input$success); delay(input$success)}, {
    message("Success!")
  })

  observeEvent({req(input$error); delay(stop("boom"))}, {
    message("Shouldn't have gotten here")
  })

  observeEvent({req(input$silent); delay(req(FALSE))}, {
    message("Shouldn't have gotten here")
  })

  observeEvent({req(input$validation); delay(validate(need(FALSE, "validation error")))}, {
    message("Shouldn't have gotten here")
  })
}

shinyApp(ui, server)
