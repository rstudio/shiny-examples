library(ggplot2)
library(shiny)
sun <- readRDS("sunshine.RDS")

# ui ---------------------------------------------------------------------------

ui <- fluidPage(
  tags$head(includeHTML(("google-analytics.html"))),
  includeCSS("cerulean.css"),

  titlePanel("Sunlight in the US"),

  helpText("Use this Shiny app to explore the distribution of sunlight in
             the United States. The map can display three variables by state."),

  br(),

  selectInput("var", "Display",
    choices = c(
      "Percent of time sunny" = "sun_percent",
      "Annual hours of sunshine" = "total_hours",
      "Annual clear days" = "clear_days"
    )
    ),

  actionButton("update_plot", "Update Plot"),

  br(),

  plotOutput("map", width = "90%")
)

# server -----------------------------------------------------------------------

server <- function(input, output) {
  high <- reactive({
    switch(input$var,
      "sun_percent" = "yellow",
      "total_hours" = "yellow",
      "clear_days" = "whitesmoke"
    )
  })

  low <- reactive({
    switch(input$var,
      "sun_percent" = "darkorange1",
      "total_hours" = "steelblue",
      "clear_days" = "steelblue"
    )
  })

  updated_plot <- eventReactive(input$update_plot, {
    ggplot(sun, aes(long, lat, group = group)) +
      geom_polygon(aes_string(fill = input$var), color = "white") +
      scale_fill_gradient(input$var, low = low(), high = high()) +
      theme_minimal() +
      labs(x = "", y = "")
  },
  ignoreNULL = FALSE)

  output$map <- renderPlot({
    updated_plot()
  })
}

# shiny app --------------------------------------------------------------------

shinyApp(ui, server)
