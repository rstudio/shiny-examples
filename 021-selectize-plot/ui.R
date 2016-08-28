fluidPage(
  title = 'Create plots in selectize input',
  fluidRow(
    column(
      5,
      plotOutput('parcoord'),
      hr(),
      selectizeInput('state', label = NULL, choices = NULL, options = list(
        placeholder = 'Type a state name, e.g. Iowa', maxOptions = 5)
      )
    ),
    column(
      7,
      DT::dataTableOutput('rawdata')
    )
  )
)
