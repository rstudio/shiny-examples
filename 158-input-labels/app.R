library(shiny)

row <- function(w1, w2) {
  fluidRow(column(6, w1), column(6, w2))
}

ui <- fluidPage(
  actionButton("update", "Clicking here should add/remove the label of every widget"),
  row(
    textInput("textInput1", label = NULL),
    textInput("textInput2", label = "An <i>escaped</i> Label")
  ),
  row(
    textAreaInput("textAreaInput1", label = NULL),
    textAreaInput("textAreaInput2", label = "An <i>escaped</i> Label")
  ),
  row(
    numericInput("numericInput1", label = NULL, value = 1),
    numericInput("numericInput2", label = NULL, value = 1)
  ),
  row(
    sliderInput("sliderInput1", label = NULL, value = 1, min = 0, max = 1),
    sliderInput("sliderInput2", label = NULL, value = 1, min = 0, max = 1)
  ),
  row(
    passwordInput("passwordInput1", label = NULL),
    passwordInput("passwordInput2", label = NULL)
  ),
  row(
    selectInput("selectInput1", label = NULL, choices = "a"),
    selectInput("selectInput2", label = NULL, choices = "a")
  ),
  row(
    selectizeInput("selectizeInput1", label = NULL, choices = "a"),
    selectizeInput("selectizeInput2", label = NULL, choices = "a")
  ),
  row(
    varSelectInput("varSelectInput1", label = NULL, data = iris),
    varSelectInput("varSelectInput2", label = NULL, data = iris)
  ),
  row(
    varSelectizeInput("varSelectizeInput1", label = NULL, data = iris),
    varSelectizeInput("varSelectizeInput2", label = NULL, data = iris)
  ),
  row(
    checkboxInput("checkboxInput1", label = NULL),
    checkboxInput("checkboxInput2", label = NULL)
  ),
  row(
    checkboxGroupInput("checkboxGroupInput1", label = NULL, choices = "a"),
    checkboxGroupInput("checkboxGroupInput2", label = NULL, choices = "a")
  ),
  row(
    dateInput("dateInput1", label = NULL),
    dateInput("dateInput2", label = NULL)
  )
)


server <- function(input, output, session) {

  observeEvent(input$update, {
    label1 <- if (isTRUE(input$update %% 2 == 0)) character(0) else "An <i>escaped</i> Label"
    updateTextInput(session, "textInput1", label = label1)
    updateTextAreaInput(session, "textAreaInput1", label = label1)
    updateNumericInput(session, "numericInput1", label = label1)
    updateSliderInput(session, "sliderInput1", label = label1, value = 1, min = 0, max = 1)
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
    updateSliderInput(session, "sliderInput2", label = label2, value = 1, min = 0, max = 1)
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
