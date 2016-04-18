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
  if (spacing() != "s") {
    if (hover_code() == "") {
      code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;spacing = '", 
                     spacing(), "'")
    } else code <- paste0(", spacing = '", spacing(), "'")
  }
  return(code)
})

width_code <- reactive({
  code <- ""
  if (width() != "auto") {
    code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;width = '", 
                   width(), "'")
  }
  return(code)
})

align_code <- reactive({
  code <- ""
  if (deparse(align()) != "NULL") {
    if (width_code() == "") {
      code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;align = '",
                     align(), "'")
    } else code <- paste0(", align = '", align(), "'")
  }
  return(code)
  })

rownames_code <- reactive({
  code <- ""
  if (rownames() != FALSE) {
    code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;rownames = ", 
                   rownames())
  }
  return(code)
})

colnames_code <- reactive({
  code <- ""
  if (colnames() != TRUE) {
    if (rownames_code() == "") {
      code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;colnames = ", 
                     colnames())
    } else code <- paste0(", colnames = ", colnames())
  }
  return(code)
})

digits_code <- reactive({
  code <- ""
  if (deparse(digits()) != "NULL") {
    code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;digits = ", 
                   digits())
  }
  return(code)
})

na_code <- reactive({
  code <- ""
  if (na() != "NA") {
    if (digits_code() == "") {
      code <- paste0(",&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;na = '", 
                     na(), "'")
    } else code <- paste0(", na = '", na(), "'")
  }
  return(code)
})