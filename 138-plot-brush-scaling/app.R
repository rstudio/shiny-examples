library(shiny)
library(ggplot2)

shinyApp(
  fluidPage(
    tags$head(tags$style("img { width: 200%; height: 75% }")),
    h1("Brush over the rectangle of three points at hp ≈ 60 & wt ≈ 2 to display in the table below"),
    plotOutput("plot", brush = "brush"),
    tableOutput("table"),
    uiOutput("works")
  ),
  function(input, output, session) {
    mtcars_data <- mtcars
    mtcars_data$brush_id <- seq_len(nrow(mtcars))

    output$plot <- renderPlot({
      ggplot(mtcars_data, aes(hp, mpg)) +
        geom_point() +
        geom_rect(mapping = aes(xmin = 64.5, xmax = 66.5, ymin = 26.5, ymax = 34.5), fill = "transparent", color = "black", linetype = "dashed") +
        scale_x_log10() +
        coord_trans(y = "log2")
    })

    output$table <- renderTable({
      brushedPoints(mtcars_data, input$brush)
    })


    output$works <- renderUI({
      dt <- brushedPoints(mtcars_data, input$brush)
      if (nrow(dt) == 3) {
        if (all(c(18, 20, 26) %in% dt$brush_id)) {
          return(
            tags$h1(tags$span("Worked!", style = "background-color: #7be092;"))
          )
        }
      }
      tags$h1(tags$span("Failed", style = "background-color: #e07b7b;"))
    })
  }
)
