library(shiny)

shinyServer(function(input, output) {

  # display 10 rows initially
  output$ex1 <- renderDataTable(iris, options = list(pageLength = 10))

  # -1 means no pagination; the 2nd element contains menu labels
  output$ex2 <- renderDataTable(iris, options = list(
    lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
    pageLength = 15
  ))

  # you can also use paging = FALSE to disable pagination
  output$ex3 <- renderDataTable(iris, options = list(paging = FALSE))

  # turn off filtering (no searching boxes)
  output$ex4 <- renderDataTable(iris, options = list(searching = FALSE))

  # turn off filtering on individual columns (3rd and 4th column)
  output$ex5 <- renderDataTable(iris, options = list(
    columnDefs = list(list(targets = c(3, 4) - 1, searchable = FALSE)),
    pageLength = 10
  ))

  # write literal JS code in I()
  output$ex6 <- renderDataTable(
    iris,
    options = list(rowCallback = I(
      'function(row, data) {
        // Bold cells for those >= 5 in the first column
        if (parseFloat(data[0]) >= 5.0)
          $("td:eq(0)", row).css("font-weight", "bold");
      }'
    ))
  )
})
