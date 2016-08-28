library(datasets)

# Create a mock dataset with the three main types of variables 
# (numeric, strings and booleans), "stringy" row.names and a 
# few missing values for the user to test the renderTable() 
# inputs with
mock <- data.frame(v1 = c(    1,    2,    NA,   9,   NaN,   7 ),
                   v2 = c(  "a",  "b",   "c", "d",   "e",  NA ),
                   v3 = c( TRUE, TRUE, FALSE,  NA, FALSE, TRUE)) 
row.names(mock) <- c("uno", "dos", "tres", "cuatro", "cinco", "seis")


function(input, output, session) {
  # Source the code printing functions to improve readibility
  source("check_valid.R", local=TRUE)
  source("code_printing.R", local = TRUE)
  
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars,
           "mock" = mock)
  })
  
  # Dynamically create the `align` options, so that it displays
  # three options with the number of columns of the current
  # dataset selected (+1 for the row.names if `rownames`=TRUE)
  output$pre_align <- renderUI({
    choices <- c("NULL", "?", "c", "l")
    size <- { 
      if (as.logical(input$rownames)) ncol(datasetInput())+1 
      else ncol(datasetInput()) }
    choices <- c(choices, 
                 paste(sample(c("l", "c", "r", "?"), size = size, 
                              replace = TRUE), collapse = ""),
                 paste(sample(c("l", "c", "r", "?"), size = size, 
                              replace = TRUE), collapse = ""),
                 paste(sample(c("l", "c", "r", "?"), size = size, 
                              replace = TRUE), collapse = ""))
    selectInput("align", "Column alignment:", choices, "NULL")
  })
  
  # Display the resulting table
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)}, 
    striped = striped,
    bordered = bordered,
    hover = hover,
    spacing = spacing,
    width = width,
    rownames = rownames,
    colnames = colnames,
    align = align,
    digits = digits,
    na = na
    )
  
  # Display the corresponding code for the user to generate
  # the current table in their own Shiny app
  output$code <- renderText({
    paste0( "in <strong>ui.R</strong>: "    , 
            "<br><code>tableOutput('tbl')</code><br><br>",
            "in <strong>server.R</strong>: ", 
            "<br><code>output$tbl <- ", 
            "renderTable({ head( ", dataset(), 
            ", n = ", obs(), " )}", 
            striped_code(), bordered_code(), 
            hover_code(), spacing_code(),
            width_code(), align_code(),
            rownames_code(), colnames_code(), 
            digits_code(), na_code(),
            ")&nbsp;&nbsp;</code>"
    )
  })
}
