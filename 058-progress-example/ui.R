library(shinyIncubator)

shinyUI(fluidPage(
  # progressInit() must be called somewhere in the UI in order
  # for the progress UI to actually appear
  progressInit(),
  h1("Progress demo"),
  sidebarLayout(
    sidebarPanel(
      "This is a demonstration of the progress indicator ",
      "from the",
      a(href="https://github.com/rstudio/shiny-incubator",
        "shiny-incubator"),
      "package.",
      hr(),
      actionButton("go", "Run")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
))