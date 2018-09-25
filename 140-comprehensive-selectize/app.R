library(shiny)

bigvec <- paste0("a", 1:1e5)
named_bigvec <- setNames(bigvec, bigvec)
nested_biglist <- lapply(named_bigvec, function(item) setNames(list(item), item))

test_set <- list(
  "Unnamed vector" = c(1, 2),
  "Named vector" = c(a = 1, B = 2),
  "Partially named vector" = c(a = 1, B = 2, 3),
  "Unnamed list" = c(1, 2),
  "Named list" = list(a = 1, B = 2, c = 3),
  "Partially named list" = list(a = 1, B = 2, 3),
  "Nested list" = list(a = 1, B = list(B = 2), c = list(3)),
  "Big unnamed vector (server-side only)" = bigvec,
  "Big named vector (server-side only)" = named_bigvec,
  "Big unnamed list (server-side only)" = as.list(bigvec),
  "Big named list (server-side only)" = as.list(named_bigvec),
  "Big nested list (server-side only)" = nested_biglist,
  "Data frame (server-side only)" = data.frame(label = c("a", "B"), value = c(1, 2))
)

ui <- fluidPage(
  sidebarPanel(
    checkboxInput("server", "Server-side selectize"),
    selectInput("set", "Test set", names(test_set)),
    selectizeInput("select", "Select", choices = NULL)
  ),
  mainPanel(
    verbatimTextOutput("txt")
  )
)

server <- function(input, output, session) {
  validateSelection <- function() {
    if (is.null(input$set) || is.null(input$server))
      return(FALSE)
    if (!input$server && grepl("server-side", input$set))
      return(FALSE)
    
    TRUE
  }
  
  observe({
    if (!validateSelection()) return()
    cat("starting updateSelectizeInput... ")
    updateSelectizeInput(session, "select",
      choices = test_set[[input$set]], selected = NULL, server = input$server
    )
    cat("done\n")
  })
  
  output$txt = renderPrint({
    if (!validateSelection())
      return("This test set must be used with server-side selectize (too slow otherwise)")
    input$select
  })
}
