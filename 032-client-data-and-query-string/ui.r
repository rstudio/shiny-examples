fluidPage(
  titlePanel("Client data and query string example"),

  fluidRow(
    column(8,    
      h3("session$clientdata values"),
      verbatimTextOutput("summary"),
      h3("Parsed URL query string"),
      verbatimTextOutput("queryText", placeholder = TRUE)
    )
  )
)
