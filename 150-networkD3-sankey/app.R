library(networkD3)
library(shiny)
library(shinydashboard)
library(markdown)

markdown <- function(s) {
  s <- gsub("\\n[ \\t]*", "\n", s)
  HTML(markdownToHTML(fragment.only = TRUE, text = s))
}

ui <- function(req) {
  dashboardPage(
    dashboardHeader(title = "networkD3 tests"),
    dashboardSidebar(
      sidebarMenu(
        dateRangeInput(inputId = "dates",
                       label = "Select time period:",
                       start = "2000-01-01",
                       end = "2018-02-01",
                       min = "2000-01-01",
                       max = "2018-02-01",
                       format = "mm-yyyy"),
        actionButton("progress", "Show Progress"),
        bookmarkButton()
      )
    ),
    dashboardBody(
      fluidRow(
        tags$div(style="padding:1em;",
          markdown("
          ### Background

          In versions of Shiny prior to 1.4.0, certain Shiny features didn't work
          because SVGs introduced by the [networkD3](https://github.com/christophergandrud/networkD3)
          package interfered with Shiny's JavaScript. In particular, Shiny used
          the 'body' selector under the assumption there would be only one body
          element on the page. This wasn't  always true when networkD3's sankey
          plot was involved, as it introduced its own 'body' tags inside SVG markup.

          This problem caused datepicker, progress, and bookmarking dialogs not
          to work, so we test them all here.

          More information can be found on this PR: https://github.com/rstudio/shiny/pull/2361

          ### Instructions

          1. Selecting a date in the time period on the left should work correctly.
          1. Clicking 'Show Progress' button should display a progress bar at the bottom right of the page.
          1. Clicking 'Bookmark...' button should show a modal that the bookmark link can be copied from."))),
      fluidRow(
        box(sankeyNetworkOutput(outputId = "sankey_diagram"), width = 12))
    )
  )
}

server = function(input, output, session){
  observeEvent(input$progress, {
    withProgress(message = "Showing progress...", value = 0, {
      for (i in 1:10) {
        incProgress(1/10)
        Sys.sleep(0.25)
      }
    })
  })
  output$sankey_diagram = renderSankeyNetwork({
    t1 = data.frame(source = c(0,0,
                               1,1),
                    target = c(2,3,
                               2,3),
                    value = c(100, 25,
                              10, 20))
    t2 = data.frame(id = c(0,1,2,3), name = c("Group 1", "Group 2", "Group 3", "Group 4"))
    s = sankeyNetwork(Links = t1,
                      Nodes = t2,
                      Source = "source",
                      Target = "target",
                      Value = "value",
                      NodeID = "name",
                      NodeGroup = "name",
                      fontSize = 12,
                      nodeWidth = 30,
                      iterations = 0,
                      colourScale = JS("d3.scaleOrdinal(d3.schemeCategory10);"))
    return(s)
  })
}

shinyApp(ui, server, enableBookmarking = "url")
