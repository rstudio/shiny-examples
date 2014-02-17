library(shiny)

states <- setNames(state.abb, state.name)
shinyUI(fluidPage(
  titlePanel('Selectize examples'),
  sidebarLayout(sidebarPanel(
    selectInput('e0', '0. An ordinary select input', choices = states),
    selectizeInput('e1', '1. A basic example (zero-configuration)', choices = states),
    selectizeInput('e2', '2. Multi-select', choices = states, multiple = TRUE),
    selectizeInput('e3', '3. Item creation', choices = states, options = list(create = TRUE)),
    selectizeInput(
      'e4', '4. Max number of options to show', choices = states,
      options = list(maxOptions = 5)
    ),
    selectizeInput(
      'e5', '5. Max number of items to select', choices = states, multiple = TRUE,
      options = list(maxItems = 2)
    )
  ),
  mainPanel(
    verbatimTextOutput('e4out')
  )
)))
