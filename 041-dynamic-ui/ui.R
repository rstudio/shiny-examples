fluidPage(
  titlePanel("Dynamically generated user interface components"),
  fluidRow(

    column(3, wellPanel(
      selectInput("input_type", "Input type",
        c("slider", "text", "numeric", "checkbox",
          "checkboxGroup", "radioButtons", "selectInput",
          "selectInput (multi)", "date", "daterange"
        )
      )
    )),

    column(3, wellPanel(
      # This outputs the dynamic UI component
      uiOutput("ui")
    )),

    column(3,
      tags$p("Input type:"),
      verbatimTextOutput("input_type_text"),
      tags$p("Dynamic input value:"),
      verbatimTextOutput("dynamic_value")
    )
  )
)
