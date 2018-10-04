library(shiny)
library(promises)
library(future)
plan(multisession)

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
    "Verify that each row contains two identical outputs."
  ),
  fluidRow(
    column(2),
    column(5, h2("Sync")),
    column(5, h2("Async"))
  ),
  make_row(plotOutput, "plot", "Plot"),
  make_row(textOutput, "text", "Text"),
  make_row(verbatimTextOutput, "print", "Print"),
  make_row(verbatimTextOutput, "print2", "Print 2"),
  make_row(dataTableOutput, "datatable", "Data Table"),
  make_row(imageOutput, "image", "Image", height = "auto"),
  make_row(tableOutput, "table", "Table"),
  make_row(uiOutput, "ui", "UI")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(cars)
  })

  output$plota <- renderPlot({
    future({ Sys.sleep(1) }) %...>% {
      plot(cars)
    }
  })

  output$text <- renderText({
    "hello"
  })

  output$texta <- renderText({
    future({ Sys.sleep(1); "hello" })
  })

  output$print <- renderPrint({
    print("hello")
  })

  output$printa <- renderPrint({
    future({ Sys.sleep(1) }) %...>% { print("hello") }
  })

  output$print2 <- renderPrint({
    "hello"
  })

  output$print2a <- renderPrint({
    future({ Sys.sleep(1) }) %...>% { "hello" }
  })

  output$datatable <- renderDataTable({
    head(cars)
  })

  output$datatablea <- renderDataTable({
    future({ Sys.sleep(1); head(cars) })
  })

  output$image <- renderImage({
    path <- tempfile(fileext = ".gif")
    download.file("https://www.google.com/images/logo.gif", path, mode = "wb")
    list(src = path)
  }, deleteFile = TRUE)

  output$imagea <- renderImage({
    future({
      path <- tempfile(fileext = ".gif")
      download.file("https://www.google.com/images/logo.gif", path, mode = "wb")
      path
    }) %...>% {
      list(src = .)
    }
  }, deleteFile = TRUE)

  output$table <- renderTable({
    head(cars)
  })

  output$tablea <- renderTable({
    future({ Sys.sleep(1); head(cars) })
  })

  output$ui <- renderUI({
    h1("hello world")
  })

  output$uia <- renderUI({
    future({ Sys.sleep(1); h1("hello world") })
  })

}

shinyApp(ui, server)
