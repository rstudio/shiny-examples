basicPage(
  plotOutput('plot', width = "300px", height = "300px"),
  tableOutput('table'),
  actionButton('goPlot', 'Go plot'),
  actionButton('goTable', 'Go table')
)
