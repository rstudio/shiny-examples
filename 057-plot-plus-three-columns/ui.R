library(ggplot2)

dataset <- diamonds

fluidPage(

  title = "Diamonds Explorer",
  
  plotOutput('plot'),
  
  hr(),

  fluidRow(
    column(3,
      h4("Diamonds Explorer"),
      sliderInput('sampleSize', 'Sample Size', 
                  min=1, max=nrow(dataset),
                  value=min(1000, nrow(dataset)), 
                  step=500, round=0),
      br(),
      checkboxInput('jitter', 'Jitter'),
      checkboxInput('smooth', 'Smooth')
    ),
    column(4, offset = 1,
      selectInput('x', 'X', names(dataset)),
      selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
      selectInput('color', 'Color', c('None', names(dataset)))
    ),
    column(4,
      selectInput('facet_row', 'Facet Row',
        c(None='.', names(diamonds[sapply(diamonds, is.factor)]))),
      selectInput('facet_col', 'Facet Column',
        c(None='.', names(diamonds[sapply(diamonds, is.factor)])))
    )
  )
)