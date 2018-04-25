library(shiny)
library(promises)

wait <- function(secs) {
  force(secs)
  promise(~{later::later(~resolve(TRUE), secs)})
}

ui <- fluidPage(
  h2("Verify inputs are not updated until async tasks are complete"),
  p(
    strong("Instructions:"),
    tags$ol(
      tags$li("Press Go button"),
      tags$li("Immediately change the radio button value"),
      tags$li(
        "After 3 seconds, Shiny will return output; verify that all letters printed are the same.",
        "(The letter used will be whatever letter was selected at the time Go was pressed.)"
      )
    )
  ),
  sidebarLayout(
    sidebarPanel(
      radioButtons("choice", "Choose one", letters[1:5]),
      actionButton("go", "Go")
    ),
    mainPanel(
      verbatimTextOutput("out")
    )
  )
)

server <- function(input, output, session) {
  output$out <- renderPrint({
    req(input$go)
    
    prog <- Progress$new(session)
    prog$set(message = "Thinking...")
    isolate({
      cat(input$choice, "\n")
      wait(1) %...>% {
        cat(input$choice, "\n")
        wait(1)
      } %...>% {
        cat(input$choice, "\n")
        wait(1)
      } %...>% {
        cat(input$choice, "\n")
      } %>% finally(~prog$close()) %...>% {
        invisible()
      }
    })
  })
}

shinyApp(ui, server)

