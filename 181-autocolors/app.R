library(shiny)
library(ggplot2)
library(lattice)

shinyOptions(plot.autocolors = TRUE)

ui <- fluidPage(
  # TODO: maybe have input controls for this, but how to trigger redraw?
  tags$style(HTML("body{background-color: #6c757d; color: #fff}")),
  h3("ggplot2 Points"),
  plotOutput("points"),
  h3("ggplot2 Geoms"),
  plotOutput("text"),
  h3("ggplot2 Annotations"),
  plotOutput("annotations"),
  h3("lattice settings"),
  plotOutput("lattice"),
  h3("lattice auto key"),
  plotOutput("lattice2"),
  h3("Base scatterplot"),
  plotOutput("base_plot"),
  h3("Base histogram"),
  plotOutput("base_hist")
)

server <- function(input, output, session) {

  output$points <- renderPlot({
    sizes <- expand.grid(size = (0:3) * 2, stroke = (0:3) * 2)
    ggplot(sizes, aes(size, stroke, size = size, stroke = stroke)) +
      geom_abline(slope = -1, intercept = 6, colour = "white", size = 6) +
      geom_point(shape = 21, fill = "red") +
      scale_size_identity()
  })

  output$text <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) +
      geom_point(aes(size = cyl, color = factor(am))) +
      geom_label(aes(label = row.names(mtcars)), nudge_x = 5, nudge_y = 5) +
      geom_vline(xintercept = 10) +
      geom_hline(yintercept = 20) +
      facet_wrap(~vs) +
      labs(
        title = "mtcars",
        subtitle = "What a wonderful phrase",
        caption = "How boring"
      )
  })

  output$annotations <- renderPlot({
    ggplot(mtcars, aes(x = wt, y = mpg)) +
      geom_point() +
      annotate("text", x = 4, y = 25, label = "Some text") +
      annotate("text", x = 2:5, y = 25, label = "Some text") +
      annotate("rect", xmin = 3, xmax = 4.2, ymin = 12, ymax = 21, alpha = 0.5) +
      annotate("segment", x = 2.5, xend = 4, y = 15, yend = 25,
                 colour = "blue") + annotate("pointrange", x = 3.5, y = 20, ymin = 12, ymax = 28,
                 colour = "red", size = 1.5) +
      annotate("pointrange", x = 3.5, y = 20, ymin = 12, ymax = 28,
               colour = "red", size = 1.5) +
      annotate("text", x = 2:3, y = 20:21, label = c("my label", "label 2")) +
      annotate("text", x = 3, y = 35, label = "italic(R) ^ 2 == 0.75",
                 parse = TRUE) +
      annotate("text", x = 4, y = 45,
                 label = "paste(italic(R) ^ 2, \" = .75\")", parse = TRUE)
  })

  output$lattice <- renderPlot({
    show.settings()
  })

  output$lattice2 <- renderPlot({
    mtcars$transmission <- factor(mtcars$am, levels=c(0, 1),
                                  labels=c("Automatic", "Manual"))
    densityplot(~mpg, data=mtcars,
                group=transmission,
                main="MPG Distribution by Transmission Type",
                xlab="Miles per Gallon",
                auto.key=TRUE)
  })

  output$base_plot <- renderPlot({
    plot(iris$Sepal.Length, iris$Sepal.Width,
         col = iris$Species,
         main = "Sepal Length vs Width in Iris")
  })

  output$base_hist <- renderPlot({
    hist(iris$Sepal.Length)
  })

}

shinyApp(ui, server)

