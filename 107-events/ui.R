library(shiny)
library(knitr)

md <- '
# JavaScript event tests

This app exercises Shiny\'s [JavaScript events API](https://shiny.rstudio.com/articles/js-events.html).

1. A dialog box that says "Shiny is busy!" should appear at least twice in succession immediately after page load.
1. The side panel should fade during or after the "Shiny is busy!" dialog box has subsided.
1. The slider input labeled **Number of bins** should have a red dotted border.
1. Modifying the "Title" text input should cause the plot title to update.
1. Pressing the button labeled "Change color" should cause the bars in the plot to change color.
1. Pressing the button labeled "Change color (canceled)" should have no effect.
1. Pressing the button labeled "Send message" should cause the busy dialog to appear very briefly.
1. Pressing the button labeled "Be busy for 2 seconds" should cause the busy dialog to appear for roughly 2 seconds.
1. Pressing the "Swallow event" button should **not** cause an alert box that says "Fail" to appear.
1. The JavaScript console should display the following kinds of messages (input/output names elided):
  - `An output ... was bound to Shiny`
  - `An input ... was bound to Shiny`
  - `Received a message from Shiny`
  - `An output is being recalculated...`
1. `My output was modified by the shiny:value event.` should appear under the **slider_info2** heading.
1. `Error: A nice error occurred :)` should appear under the **Error Info** heading.
1. `Warning: Error in renderPrint: A bad error occurred!` should appear in the R console at least twice.
1. Pressing the button labeled "End session" should cause an alert to say "Disconnected!"
'

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
      tags$span(
        id = "swallow_wrapper",
        actionButton('swallow_event_button', 'Swallow event')
      ),
      actionButton('end', 'End session')
    ),

    mainPanel(
      HTML(knit2html(fragment.only = TRUE, text = md)),
      plotOutput('distPlot'),
      verbatimTextOutput('slider_info1'),
      tags$h3("slider_info2"),
      verbatimTextOutput('slider_info2'),
      tags$h3("Error Info"),
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
