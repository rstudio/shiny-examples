library(shiny)

shinyServer(function(input, output) {

  # display 10 rows initially
  output$ex1 <- renderDataTable(iris, options = list(iDisplayLength = 10))

  # -1 means no pagination; the 2nd element contains menu labels
  output$ex2 <- renderDataTable(iris, options = list(
    aLengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
    iDisplayLength = 15
  ))

  # you can also use bPaginate = FALSE to disable pagination
  output$ex3 <- renderDataTable(iris, options = list(bPaginate = FALSE))

  # turn off filtering (no searching boxes)
  output$ex4 <- renderDataTable(iris, options = list(bFilter = FALSE))

  # turn off filtering on individual columns
  output$ex5 <- renderDataTable(iris, options = list(
    aoColumns = list(list(bSearchable = TRUE), list(bSearchable = TRUE),
                     list(bSearchable = FALSE), list(bSearchable = FALSE),
                     list(bSearchable = TRUE)),
    iDisplayLength = 10
  ))

  # write literal JS code in I()
  output$ex6 <- renderDataTable(
    iris,
    options = list(fnRowCallback = I(
      'function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
        // Bold cells for those >= 5 in the first column
        if (parseFloat(aData[0]) >= 5.0)
          $("td:eq(0)", nRow).css("font-weight", "bold");
      }'
    ))
  )
})
