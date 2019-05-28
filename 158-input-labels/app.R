library(shiny)

# ensure two column appear on small displays
column2 <- function(x) {
  div(class = "col-xs-6", x)
}

row <- function(w1, w2) {
  fluidRow(column2(w1), column2(w2))
}

label_initial <- "An <i>escaped</i> Label"

ui <- fluidPage(
  p("Everytime you click on the button below, it should add labels to the column that doesn't (currently) have labels, and remove labels from the column that does (currently) have labels. Every label should say: '", tags$b(label_initial), "'."),
  p(
    a(href = "https://github.com/rstudio/shiny/pull/2406", "PR #2406"), ", ",
    a(href = "https://github.com/rstudio/shiny/issues/868", "Issue #868")
  ),
  actionButton("update", "Add/remove labels"),
  hr(),
  row(
    textInput("textInput1", label = NULL),
    textInput("textInput2", label = label_initial)
  ),
  row(
    textAreaInput("textAreaInput1", label = NULL),
    textAreaInput("textAreaInput2", label = label_initial)
  ),
  row(
    numericInput("numericInput1", label = NULL, value = 1),
    numericInput("numericInput2", label = label_initial, value = 1)
  ),
  row(
    sliderInput("sliderInput1", label = NULL, value = 1, min = 0, max = 1),
    sliderInput("sliderInput2", label = label_initial, value = 1, min = 0, max = 1)
  ),
  row(
    passwordInput("passwordInput1", label = NULL),
    passwordInput("passwordInput2", label = label_initial)
  ),
  row(
    selectInput("selectInput1", label = NULL, choices = "a", selectize = FALSE),
    selectInput("selectInput2", label = label_initial, choices = "a", selectize = FALSE)
  ),
  row(
    selectizeInput("selectizeInput1", label = NULL, choices = "a"),
    selectizeInput("selectizeInput2", label = label_initial, choices = "a")
  ),
  row(
    varSelectInput("varSelectInput1", label = NULL, data = iris),
    varSelectInput("varSelectInput2", label = label_initial, data = iris)
  ),
  row(
    varSelectizeInput("varSelectizeInput1", label = NULL, data = iris),
    varSelectizeInput("varSelectizeInput2", label = label_initial, data = iris)
  ),
  row(
    checkboxInput("checkboxInput1", label = NULL),
    checkboxInput("checkboxInput2", label = label_initial)
  ),
  row(
    checkboxGroupInput("checkboxGroupInput1", label = NULL, choices = "a"),
    checkboxGroupInput("checkboxGroupInput2", label = label_initial, choices = "a")
  ),
  row(
    dateInput("dateInput1", label = NULL),
    dateInput("dateInput2", label = label_initial)
  )
)


server <- function(input, output, session) {

  observeEvent(input$update, {
    label1 <- if (isTRUE(input$update %% 2 == 0)) character(0) else "An <i>escaped</i> Label"
    updateTextInput(session, "textInput1", label = label1)
    updateTextAreaInput(session, "textAreaInput1", label = label1)
    updateNumericInput(session, "numericInput1", label = label1)
    updateSliderInput(session, "sliderInput1", label = label1)
    updateTextInput(session, "passwordInput1", label = label1)
    updateSelectInput(session, "selectInput1", label = label1)
    updateSelectizeInput(session, "selectizeInput1", label = label1)
    updateVarSelectInput(session, "varSelectInput1", label = label1)
    updateVarSelectizeInput(session, "varSelectizeInput1", label = label1)
    updateCheckboxInput(session, "checkboxInput1", label = label1)
    updateCheckboxGroupInput(session, "checkboxGroupInput1", label = label1)
    updateDateInput(session, "dateInput1", label = label1)

    label2 <- if (isTRUE(input$update %% 2 > 0)) character(0) else "An <i>escaped</i> Label"
    updateTextInput(session, "textInput2", label = label2)
    updateTextAreaInput(session, "textAreaInput2", label = label2)
    updateNumericInput(session, "numericInput2", label = label2)
    updateSliderInput(session, "sliderInput2", label = label2)
    updateTextInput(session, "passwordInput2", label = label2)
    updateSelectInput(session, "selectInput2", label = label2)
    updateSelectizeInput(session, "selectizeInput2", label = label2)
    updateVarSelectInput(session, "varSelectInput2", label = label2)
    updateVarSelectizeInput(session, "varSelectizeInput2", label = label2)
    updateCheckboxInput(session, "checkboxInput2", label = label2)
    updateCheckboxGroupInput(session, "checkboxGroupInput2", label = label2)
    updateDateInput(session, "dateInput2", label = label2)
  })

}

shinyApp(ui, server)
