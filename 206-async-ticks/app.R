library(shiny)
library(promises)
library(future)
plan(multiprocess)

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
  make_row(verbatimTextOutput, "print", "Print"),
  make_row(verbatimTextOutput, "print2", "Print 2"),
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

  output$plot <- renderPlot({
    expect_before_tick()
  })

  output$plota <- renderPlot({
    future({ Sys.sleep(1) }) %...>% {
      expect_after_tick()
    }
  })

  output$text <- renderText({
    expect_before_tick()
  })

  output$texta <- renderText({
    future({ Sys.sleep(1) }) %...>% {
      expect_after_tick()
    }
  })

  output$print <- renderPrint({
    expect_before_tick()
  })

  output$printa <- renderPrint({
    future({ Sys.sleep(1) }) %...>% {
      expect_after_tick()
    }
  })

  output$print2 <- renderPrint({
    expect_before_tick()
  })

  output$print2a <- renderPrint({
    future({ Sys.sleep(1) }) %...>% {
      expect_after_tick()
    }
  })

  output$datatable <- renderDataTable({
    expect_before_tick()
  })

  output$datatablea <- renderDataTable({
    future({ Sys.sleep(1) }) %...>% {
      expect_after_tick()
    }
  })

  output$image <- renderImage({
    expect_before_tick()
  }, deleteFile = TRUE)

  output$imagea <- renderImage({
    future({ Sys.sleep(1) }) %...>% {
      expect_after_tick()
    }
  }, deleteFile = TRUE)

  output$table <- renderTable({
    expect_before_tick()
  })

  output$tablea <- renderTable({
    future({ Sys.sleep(1) }) %...>% {
      expect_after_tick()
    }
  })

  output$ui <- renderUI({
    expect_before_tick()
  })

  output$uia <- renderUI({
    future({ Sys.sleep(1) }) %...>% {
      expect_after_tick()
    }
  })

}

shinyApp(ui, server)
