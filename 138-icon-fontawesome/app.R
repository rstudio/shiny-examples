library(shiny)

fa4icons <- c(
  "scissors",
  "slack",
  "arrow-left",
  "eur",
  "barcode"
)

fa5icons <- c(
  "chart-line",
  "socks",
  "bullhorn",
  "lightbulb",
  "wifi"
)

fabicons <- c(
  "500px",
  "app-store-ios",
  "amazon",
  "btc",
  "github-alt"
)

showIcons <- function(icons) {
  tags$table(
    tags$tr(style = "border-bottom: 1px solid black", tags$th("Name"), tags$th("Icon")),
    lapply(icons, function(name) {
      tags$tr(
        tags$td(style = "padding-right: 3em;", name),
        tags$td(icon(name))
      )
    })
  )
}

ui <- fluidPage(
  tags$h2("FontAwesome 4 icons"),
  p("The following icons are from the FontAwesome 4 set. They should display properly below."),
  showIcons(fa4icons),
  tags$h2("FontAwesome 5 icons"),
  p("The following icons are from the FontAwesome 5 set. They should display properly below."),
  showIcons(fa5icons),
  tags$h2("FontAwesome 5 brand icons"),
  p("The following icons are from the FontAwesome 5 brand set. They should display properly below."),
  showIcons(fabicons)
)

shinyApp(ui, function(input, output, session) {})
