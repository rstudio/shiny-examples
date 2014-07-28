library(ggvis)

# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

shinyUI(fluidPage(
  titlePanel("Movie explorer"),
  fluidRow(
    column(3,
      wellPanel(
        h4("Filter"),
        sliderInput("reviews", "Minimum number of reviews on Rotten Tomatoes",
          10, 300, 80, step = 10),
        sliderInput("year", "Year released", 1940, 2014, value = c(1970, 2014)),
        sliderInput("oscars", "Minimum number of Oscar wins (all categories)",
          0, 4, 0, step = 1),
        sliderInput("boxoffice", "Dollars at Box Office (millions)",
          0, 800, c(0, 800), step = 1),
        selectInput("genre", "Genre (a movie can have multiple genres)",
          c("All", "Action", "Adventure", "Animation", "Biography", "Comedy",
            "Crime", "Documentary", "Drama", "Family", "Fantasy", "History",
            "Horror", "Music", "Musical", "Mystery", "Romance", "Sci-Fi",
            "Short", "Sport", "Thriller", "War", "Western")
        ),
        textInput("director", "Director name contains (e.g., Miyazaki)"),
        textInput("cast", "Cast names contains (e.g. Tom Hanks)")
      ),
      wellPanel(
        selectInput("xvar", "X-axis variable", axis_vars, selected = "Meter"),
        selectInput("yvar", "Y-axis variable", axis_vars, selected = "Reviews"),
        tags$small(paste0(
          "Note: The Tomato Meter is the proportion of positive reviews",
          " (as judged by the Rotten Tomatoes staff), and the Numeric rating is",
          " a normalized 1-10 score of those reviews which have star ratings",
          " (for example, 3 out of 4 stars)."
        ))
      )
    ),
    column(9,
      ggvisOutput("plot1"),
      wellPanel(
        span("Number of movies selected:",
          textOutput("n_movies")
        )
      )
    )
  )
))
