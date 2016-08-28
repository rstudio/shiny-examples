fluidPage(
  fluidRow(
    column(12,
      h2("Shiny Table Demo"),
      fluidRow(
        column(4,
          h3("Inputs"),
          hr(),
          fluidRow(
            column(6, selectInput("dataset", "Data:", 
                        c("rock", "pressure", "cars", "mock"))),
            column(6,numericInput("obs", "Rows:", 6))
          ),
          br(),
          fluidRow(
            column(6, checkboxGroupInput("format", "Options:",
                        c("striped", "bordered", "hover"))),
            column(6, radioButtons("spacing", "Spacing:",
                        c("xs", "s", "m", "l"), "s"))
          ),
          br(),
          fluidRow(
            column(6, selectInput("width", "Width:",
                        c("auto", "100%", "75%",
                          "300", "300px", "10cm"), "auto")),
            column(6, uiOutput("pre_align"))
          ),
          br(),
          fluidRow(
            column(6, radioButtons("rownames", "Include rownames:",
                        c("T", "F"), "F", inline=TRUE)),
            column(6, radioButtons("colnames", "Include colnames:",
                        c("T", "F"), "T", inline=TRUE))
          ),
          br(),
          fluidRow(
            column(6, selectInput("digits", "Number of decimal places:",
                        c("NULL", "3", "2", "0", "-2", "-3"))),
            column(6, selectInput("na", "String for missing values:",
                        c("NA", "missing", "-99"), "NA"))
          )
        ),
        column(7, offset=1,
          h3("Table and Code"),
          br(),
          tableOutput("view"),
          br(),
          h4("Corresponding R code:"),
          htmlOutput("code")
        )
      )
    )
  )
)
