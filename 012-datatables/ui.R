library(shiny)
library(ggplot2)  # for the diamonds dataset

shinyUI(pageWithSidebar(
  headerPanel('Examples of DataTables'),
  sidebarPanel(
    checkboxGroupInput('show_vars', 'Columns in diamonds to show:', names(diamonds),
                       selected = names(diamonds)),
    helpText('For the diamonds data, we can select variables to show in the table;
             for the mtcars example, we use bSortClasses = TRUE so that sorted
             columns are colored since they have special CSS classes attached;
             for the iris data, we customize the length menu so we can display 5
             rows per page.')
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('diamonds',
               dataTableOutput("mytable1")),
      tabPanel('mtcars',
               dataTableOutput("mytable2")),
      tabPanel('iris',
               dataTableOutput("mytable3"))
    )
  )
))
