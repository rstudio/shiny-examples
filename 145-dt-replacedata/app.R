library(shiny)
library(DT)

dtmod_ui <- function(id) {
  ns <- NS(id)

  tagList(
    DTOutput(ns("table")),
    p(),
    actionButton(ns("inc"), "Increment")
  )
}

dtmod <- function(input, output, session) {
  x <- reactiveVal(0L)

  output$table <- renderDT({
    DT::datatable(data.frame(value = isolate(x())), rownames = FALSE, options = list(dom = "t", ordering = FALSE))
  })

  observeEvent(input$inc, {
    x(x() + 1L)
  })

  observeEvent(x(), {
    replaceData(dataTableProxy("table"), x())
  })
}

ui <- fluidPage(
  h3("Test DT::replaceData with Shiny modules (rstudio/DT#626)"),
  p("Make sure each Increment button updates (only) the corresponding value"),
  fluidRow(
    column(3,
      h5("Non-module"),
      dtmod_ui(NULL)
    ),
    column(3,
      h5("Module"),
      dtmod_ui("one")
    )
  )
)

server <- function(input, output, session) {
  # Call the module in an un-modular way
  dtmod(input, output, session)

  # Regular module invocation
  callModule(dtmod, "one")
}

shinyApp(ui, server)

