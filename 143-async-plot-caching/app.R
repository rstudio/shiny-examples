library(shiny)
library(promises)
library(ggplot2)

ui <- fluidPage(
  h1("Caching async plots/keys"),
  p("Ensure that all eight plots appear."),
  hr(),
  fluidRow(
    column(6,
      h4("Sync base plot, sync cache key"),
      plotOutput("plotNN")
    ),
    column(6,
      h4("Async base plot, sync cache key"),
      plotOutput("plotYN")
    )
  ),
  fluidRow(
    column(6,
      h4("Sync base plot, Async cache key"),
      plotOutput("plotNY")
    ),
    column(6,
      h4("Async base plot, async cache key"),
      plotOutput("plotYY")
    )
  ),
  fluidRow(
    column(6,
      h4("Sync ggplot, sync cache key"),
      plotOutput("ggplotNN")
    ),
    column(6,
      h4("Async ggplot, sync cache key"),
      plotOutput("ggplotYN")
    )
  ),
  fluidRow(
    column(6,
      h4("Sync ggplot, Async cache key"),
      plotOutput("ggplotNY")
    ),
    column(6,
      h4("Async ggplot, async cache key"),
      plotOutput("ggplotYY")
    )
  )
)

server <- function(input, output, session) {
  syncPlot <- function() {
    plot(cars)
  }
  asyncPlot <- function() {
    promise_resolve(TRUE) %...>% {
      syncPlot()
    }
  }
  ggsyncPlot <- function() {
    ggplot(cars, aes(speed, dist)) + geom_point()
  }
  ggasyncPlot <- function() {
    promise_resolve(TRUE) %...>% {
      ggsyncPlot()
    }
  }
  syncKey <- function() {
    Sys.time()
  }
  asyncKey <- function() {
    promise_resolve(syncKey())
  }

  output$plotNN <- renderCachedPlot({
    syncPlot()
  }, cacheKeyExpr = syncKey())

  output$plotYN <- renderCachedPlot({
    asyncPlot()
  }, cacheKeyExpr = syncKey())

  output$plotNY <- renderCachedPlot({
    syncPlot()
  }, cacheKeyExpr = asyncKey())

  output$plotYY <- renderCachedPlot({
    asyncPlot()
  }, cacheKeyExpr = asyncKey())

  output$ggplotNN <- renderCachedPlot({
    ggsyncPlot()
  }, cacheKeyExpr = syncKey())

  output$ggplotYN <- renderCachedPlot({
    ggasyncPlot()
  }, cacheKeyExpr = syncKey())

  output$ggplotNY <- renderCachedPlot({
    ggsyncPlot()
  }, cacheKeyExpr = asyncKey())

  output$ggplotYY <- renderCachedPlot({
    ggasyncPlot()
  }, cacheKeyExpr = asyncKey())
}

shinyApp(ui, server)
