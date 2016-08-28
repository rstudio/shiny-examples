navbarPage(
  title = 'DataTable Options',
  tabPanel('Display length',     DT::dataTableOutput('ex1')),
  tabPanel('Length menu',        DT::dataTableOutput('ex2')),
  tabPanel('No pagination',      DT::dataTableOutput('ex3')),
  tabPanel('No filtering',       DT::dataTableOutput('ex4')),
  tabPanel('Function callback',  DT::dataTableOutput('ex5'))
)
