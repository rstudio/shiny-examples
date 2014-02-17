library(shiny)

states <- setNames(state.abb, state.name)
shinyUI(pageWithSidebar(
  headerPanel('Select2 examples'),
  sidebarPanel(
    select2Input('e1', '1. A basic example (zero-configuration)', choices = states),
    select2Input('e2', '2. Multi-select', choices = states, multiple = TRUE),
    select2Input('e3', '3. Placeholders', choices = c('', states), options = list(placeholder = 'Choose a state')),
    select2Input(
      'e4', '4. Clear selection', choices = c('', states),
      options = list(placeholder = 'Choose a state', allowClear = TRUE)
    )
  ),
  mainPanel(
    verbatimTextOutput('e4out')
  )
))
