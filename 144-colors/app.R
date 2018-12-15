library(shiny)
library(scales)
library(leaflet)
library(rlang)

countries <- readRDS("countries.rds")
set.seed(100)
countries$category <- factor(sample.int(5L, nrow(countries), TRUE))

mapOutput <- function(id, ...) {
  ns <- NS(id)
  column(6,
    leafletOutput(ns("map"), ..., height = 300),
    verbatimTextOutput(ns("code"))
  )
}

map <- function(input, output, session, colorExpr, values) {
  output$code <- renderPrint({
    get_expr(colorExpr())
  }, width = 40)

  output$map <- renderLeaflet({
    colorFunc <- eval_tidy(colorExpr())
    leaflet(countries) %>%
      addPolygons(stroke = FALSE, smoothFactor = 0.2, fillOpacity = 1,
        color = ~colorFunc(values)) %>%
      addLegend(pal = colorFunc, values = ~values, opacity = 1, position = "bottomleft")
  })
}

ui <- fluidPage(
  tags$style("pre { font-size: 11px; border-radius: 0; border-top: none; }"),
  sidebarLayout(
    sidebarPanel(width = 2,
      selectInput("palette", "Color palette",
        list(
          Viridis = c(
            "viridis",
            "magma"
          ),
          "Brewer - Sequential" = c(
            "Blues", "Reds", "Greens",
            "Yellow-Orange-Red" = "YlOrRd"
          ),
          "Brewer - Diverging" = c(
            "Spectral",
            "Red-Blue" = "RdBu"

          ),
          "Brewer - Qualitative" = c(
            "Accent", "Dark2", "Paired"
          )
        )
      ),
      checkboxInput("reverse", "Reverse palette", FALSE),
      numericInput("bins", "Bin count", 5)
    ),
    mainPanel(width = 10,
      fluidRow(
        mapOutput("one"),
        mapOutput("two")
      ),
      fluidRow(
        mapOutput("three"),
        mapOutput("four")
      )
    )
  )
)

server <- function(input, output, session) {
  colmap = list(
    one = reactive(quo(col_numeric(!!input$palette, countries$gdp_md_est, reverse = !!input$reverse))),
    two = reactive(quo(col_bin(!!input$palette, countries$gdp_md_est, !!input$bins, pretty = FALSE, reverse = !!input$reverse))),
    three = reactive(quo(col_quantile(!!input$palette, countries$gdp_md_est, !!input$bins, reverse = !!input$reverse))),
    four = reactive(quo(col_factor(!!input$palette, countries$category, reverse = !!input$reverse)))
  )  

  callModule(map, "one", colmap$one, countries$gdp_md_est)
  callModule(map, "two", colmap$two, countries$gdp_md_est)
  callModule(map, "three", colmap$three, countries$gdp_md_est)
  callModule(map, "four", colmap$four, countries$category)
}

shinyApp(ui, server)

