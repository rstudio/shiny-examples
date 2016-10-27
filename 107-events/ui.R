library(shiny)

fluidPage(

  title = 'JavaScript events in shiny',

  tags$head(singleton(tags$script(src = 'events.js'))),

  sidebarLayout(
    sidebarPanel(
      textInput('title', 'Title', 'Histogram Title'),
      sliderInput('bins', 'Number of bins:', min = 1, max = 50, value = 30),
      actionButton('color1', 'Change color'),
      actionButton('color2', 'Change color (canceled)'),
      actionButton('message', 'Send message'),
      actionButton('busy', 'Be busy for 2 seconds'),
      actionButton('end', 'End session')
    ),

    mainPanel(
      plotOutput('distPlot'),
      verbatimTextOutput('slider_info1'),
      verbatimTextOutput('slider_info2'),
      textOutput('error_info')
    )
  ),

  div(
    id = 'busyModal', class = 'modal', role = 'dialog', 'data-backdrop' = 'static',
    div(
      class = 'modal-dialog modal-sm',
      div(
        class = 'modal-content',
        div(class = 'modal-header', h4(class = 'modal-title', 'Shiny is busy!')),
        div(class = 'modal-body', p(paste(
          'This dialog box will disappear',
          'automatically after shiny is idle.'
        )))
      )
    )
  )
)
