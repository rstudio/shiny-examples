basicPage(
  h2('Immediate output here'),
  verbatimTextOutput('fast'),
  h2('Delayed output comes after the page is ready'),
  verbatimTextOutput('slow'),
  plotOutput('slow_plot')
)
