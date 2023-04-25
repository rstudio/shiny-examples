#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

load("movies.RData")

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Movie browser, 1970 to 2014", windowTitle = "Movies"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "type",
        label = "Title type:",
        choices = levels(movies$title_type),
        selected = "Feature Film"
      )
    ),
    mainPanel(
      navlistPanel(
        tabPanel("Plot", plotOutput("plot2")),
        tabPanel("Summary", tableOutput("summary2")),
        tabPanel("Data", DT::dataTableOutput("data2")),
        tabPanel(
          "Reference",
          tags$p(
            "There data were obtained from",
            tags$a("IMDB", href = "http://www.imdb.com/"), "and",
            tags$a("Rotten Tomatoes", href = "https://www.rottentomatoes.com/"), "."
          ),
          tags$p("The data represent", nrow(movies), "randomly sampled movies released between 1972 to 2014 in the United States.")
        )
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  file <- "https://github.com/rstudio-education/shiny-course/raw/main/movies.RData"
  destfile <- "movies.RData"
  
  download.file(file, destfile)
  
  load("movies.RData")
  
  movies_subset <- reactive({
    movies %>%
      filter(title_type %in% input$type)
  })
  
  movies_subset2 <- reactive({
    movies %>%
      filter(title_type %in% input$type)
  })
  
  output$plot2 <- renderPlot({
    ggplot(movies_subset(), aes(x = critics_score, y = audience_score, color = mpaa_rating)) +
      geom_point()
  })
  output$summary2 <- renderTable(
    {
      movies_subset2() %>%
        group_by(mpaa_rating) %>%
        summarise(
          mean_as = mean(audience_score), sd_as = sd(audience_score),
          mean_cs = mean(critics_score), sd_cs = sd(critics_score),
          n = n(), cor = cor(audience_score, critics_score)
        )
    },
    digits = 3
  )
  output$data2 <- DT::renderDataTable({
    movies_subset2() %>%
      DT::datatable(options = list(pageLength = 10), rownames = FALSE)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
