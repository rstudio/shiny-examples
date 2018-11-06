library(shiny)
library(promises)
library(future)
plan(multiprocess)

testForMissingRenderFunctions <- function() {
  # If we add any render functions, they should be added to this test app. This test
  # will make it obvious if we forget.

  knownRenderFunctions <- c(
    # Test cases below
    "renderDataTable",
    "renderImage",
    "renderPlot",
    "renderPrint",
    "renderTable",
    "renderText",
    "renderUI",

    # Ignored
    "renderPage",
    "renderReactLog"
  )

  actualRenderFunctions <- grep("^render", ls(asNamespace("shiny")), value = TRUE)
  unknownRenderFunctions <- setdiff(actualRenderFunctions, knownRenderFunctions)
  if (length(unknownRenderFunctions) > 0) {
    # If you hit this error, add a test case to the app for the newly introduced render
    # function, and add the render function name to `knownRenderFunctions` above. If the
    # error isn't an actual output rendering function, then add it to the "ignored"
    # section.
    stop("Unknown render function(s): ", paste(unknownRenderFunctions, collapse = ", "))
  }
}

make_row <- function(func, base_id, label, ...) {
  tagList(
    fluidRow(
      column(12, hr())
    ),
    fluidRow(
      column(2,
        h4(label)
      ),
      column(5,
        func(base_id, ...)
      ),
      column(5,
        func(paste0(base_id, "a"), ...)
      )
    ),
    br()
  )
}

ui <- fluidPage(
  h2("Current tick"),
  tags$p(
    "This app tests whether all render functions execute synchronous user code within the current tick.",
    br(),
    "It also tests whether, conversely, all render functions execute async callbacks after the current tick is over. ",
    "(This is probably not possible to affect from the render function level, as it's a property of the promises package, ",
    "but I'm including these cases here for symmetry.)"
  ),
  tags$p(
    tags$strong("Instructions:"),
    "Verify that each row says 'OK' (no errors)."
  ),
  fluidRow(
    column(2),
    column(5, h2("Sync")),
    column(5, h2("Async"))
  ),
  make_row(function(...) plotOutput(..., height = 10), "plot", "Plot"),
  make_row(textOutput, "text", "Text"),
  make_row(textOutput, "print", "Print"),
  make_row(dataTableOutput, "datatable", "Data Table"),
  make_row(imageOutput, "image", "Image", height = "auto"),
  make_row(tableOutput, "table", "Table"),
  make_row(uiOutput, "ui", "UI")
)

server <- function(input, output, session) {
  state <- "before"
  later::later(function() {
    state <<- "after"
  })

  p <- promises::promise(~resolve(TRUE))

  expect_before_tick <- function() {
    if (state != "before") {
      stop("'before' expected!")
    }
    validate(need(FALSE, "OK"))
  }

  expect_after_tick <- function() {
    if (state != "after") {
      stop("'after' expected!")
    }
    validate(need(FALSE, "OK"))
  }

  # explicit width/height to prevent error on browser resize
  output$plot <- renderPlot({
    expect_before_tick()
  }, width = 100, height = 100)

  output$plota <- renderPlot({
    p %...>% { expect_after_tick() }
  })

  output$text <- renderText({
    expect_before_tick()
  })

  output$texta <- renderText({
    p %...>% { expect_after_tick() }
  })

  output$print <- renderPrint({
    expect_before_tick()
  })

  output$printa <- renderPrint({
    p %...>% { expect_after_tick() }
  })

  output$datatable <- renderDataTable({
    expect_before_tick()
  })

  output$datatablea <- renderDataTable({
    p %...>% { expect_after_tick() }
  })

  output$image <- renderImage({
    expect_before_tick()
  }, deleteFile = TRUE)

  output$imagea <- renderImage({
    p %...>% { expect_after_tick() }
  }, deleteFile = TRUE)

  output$table <- renderTable({
    expect_before_tick()
  })

  output$tablea <- renderTable({
    p %...>% { expect_after_tick() }
  })

  output$ui <- renderUI({
    expect_before_tick()
  })

  output$uia <- renderUI({
    p %...>% { expect_after_tick() }
  })

}

shinyApp(ui, server)
