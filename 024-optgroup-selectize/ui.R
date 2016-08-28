fluidPage(sidebarLayout(
  sidebarPanel(
    # use regions as option groups
    selectizeInput('x1', 'X1', choices = list(
      Eastern = c(`New York` = 'NY', `New Jersey` = 'NJ'),
      Western = c(`California` = 'CA', `Washington` = 'WA')
    ), multiple = TRUE),

    # use updateSelectizeInput() to generate options later
    selectizeInput('x2', 'X2', choices = NULL),

    # an ordinary selectize input without option groups
    selectizeInput('x3', 'X3', choices = setNames(state.abb, state.name)),

    # a select input
    selectInput('x4', 'X4', choices = list(
      Eastern = c(`New York` = 'NY', `New Jersey` = 'NJ'),
      Western = c(`California` = 'CA', `Washington` = 'WA')
    ), selectize = FALSE)
  ),
  mainPanel(
    verbatimTextOutput('values')
  )
), title = 'Options groups for select(ize) input')
