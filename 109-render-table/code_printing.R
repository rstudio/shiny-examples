# Helper functions to print the corresponding code for the
# user to generate the current table in their own Shiny app.
# By default, each code chunk is omitted if that argument
# is set to its default value.

striped_code <- reactive({
  code <- ""
  if (striped() != FALSE) {
    code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;striped = ", 
                   striped())
  }
  return(code)
})

bordered_code <- reactive({
  code <- ""
  if (bordered() != FALSE) {
    if (striped_code() == "") {
      code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;bordered = ", 
                     bordered())
    } else code <- paste0(", bordered = ", bordered())
  }
  return(code)
})

hover_code <- reactive({
  code <- ""
  if (hover() != FALSE) {
    code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;hover = ", 
                   hover())
  }
  return(code)
})

spacing_code <- reactive({
  code <- ""
  if (input$spacing != "small") {
    if (hover_code() == "") {
      code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;spacing = '", 
                     input$spacing, "'")
    } else code <- paste0(", spacing = '", input$spacing, "'")
  }
  return(code)
})

width_code <- reactive({
  code <- ""
  if (input$width != "auto") {
    code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;width = '", 
                   input$width, "'")
  }
  return(code)
})

align_code <- reactive({
  code <- ""
  if (input$align != "NULL") {
    if (width_code() == "") {
      code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;align = '",
                     input$align, "'")
    } else code <- paste0(", align = '", input$align, "'")
  }
  return(code)
})

rownames_code <- reactive({
  code <- ""
  if (as.logical(input$rownames) != FALSE) {
    code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;rownames = ", 
                   as.logical(input$rownames))
  }
  return(code)
})

colnames_code <- reactive({
  code <- ""
  if (as.logical(input$colnames) != TRUE) {
    if (rownames_code() == "") {
      code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;colnames = ", 
                     as.logical(input$colnames))
    } else code <- paste0(", colnames = ", 
                          as.logical(input$colnames))
  }
  return(code)
})

digits_code <- reactive({
  code <- ""
  if (input$digits != "NULL") {
    code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;digits = ", 
                   as.numeric(input$digits))
  }
  return(code)
})

na_code <- reactive({
  code <- ""
  if (input$na != "NA") {
    if (digits_code() == "") {
      code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;na = '", 
                     input$na, "'")
    } else code <- paste0(", na = '", input$na, "'")
  }
  return(code)
})