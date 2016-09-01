basicPage(
  plotOutput('plot', width = "300px", height = "300px"),
  tableOutput('table'),
  radioButtons('style', 'Progress bar style', c('notification', 'old')),
  actionButton('goPlot', 'Go plot'),
  actionButton('goTable', 'Go table')
)
