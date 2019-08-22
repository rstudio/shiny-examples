
# devtools::install_github("rstudio/shiny#2545")
# devtools::install_github("rstudio/shiny")

# options(shiny.minified = FALSE)



ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      actionButton("add", "DO NOT TOUCH!")
    ),
    mainPanel(
      tags$h1("Do not touch the tabs below"),
      "Original issue: ", tags$a(href="https://github.com/rstudio/shiny/issues/2116", "rstudio/shiny#2116"),tags$br(),
      "PR: ", tags$a(href="https://github.com/rstudio/shiny/pull/2545", "rstudio/shiny#2545"),tags$br(),
      tags$br(),
      "The javascript will show a passing or failing message in the sidebar when completed in < 10 seconds.",
      tags$br(),tags$br(),
      tags$div(id="progress"),
      tags$div(id="result"),
      tags$br(),tags$br(),
      tabsetPanel(id = "tabs",
        tabPanel(
          "Hello",
          tagList(
            "This is the hello tab. ",
            tags$span(class = "val", 0)
          )
        )
      )
    )
  ),
  includeScript("app.js")
)
server <- function(input, output, session) {
  n <- 0
  observeEvent(input$add, {
    appendTab(inputId = "tabs",
      {
        n <<- n + 1
        tabPanel(
          "Dynamic",
          tagList(
            "Content for dynamic tab ",
            tags$span(class = "val", n)
          )
        )
      }
    )
  })
}

shinyApp(ui, server)
