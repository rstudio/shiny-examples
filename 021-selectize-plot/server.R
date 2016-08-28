library(maps)

function(input, output, session) {

  mapurl <- session$registerDataObj(

    name   = 'arrests', # an arbitrary but unique name for the data object
    data   = USArrests,
    filter = function(data, req) {

      query <- parseQueryString(req$QUERY_STRING)
      state <- query$state  # state name
      # data is USArrests, the `data` argument of registerDataObj()
      urban <- data[state, 'UrbanPop']  # % urban population

      # save a map of the state and a pie of %UrbanPop to a PNG file
      image <- tempfile()
      tryCatch({
        png(image, width = 400, height = 200, bg = 'transparent')
        par(mfrow = c(1, 2), mar = c(0, 0, 0, 0))
        map('county', regions = state, mar = c(0, 0, 0, 4))
        pie(c(100 - urban, 100), col = rgb(1, c(1, 0), c(1, 0), .2), labels = NA)
      }, finally = dev.off())

      # send the PNG image back in a response
      shiny:::httpResponse(
        200, 'image/png', readBin(image, 'raw', file.info(image)[, 'size'])
      )

    }
  )

  # update the render function for selectize
  updateSelectizeInput(
    session, 'state', server = TRUE,
    # sorry, Alaska and Hawaii, I do not have maps for you
    choices = setdiff(rownames(USArrests), c('Alaska', 'Hawaii')),
    options = list(render = I(sprintf(
      "{
          option: function(item, escape) {
            return '<div><img width=\"100\" height=\"50\" ' +
                'src=\"%s&state=' + escape(item.value) + '\" />' +
                escape(item.value) + '</div>';
          }
      }",
      mapurl
    )))
  )

  # a parallel coordinate plot showing the three crime variables
  output$parcoord <- renderPlot({
    par(mar = c(2, 4, 2, .1))
    arrests <- USArrests[, -3]
    plot(c(1, 3), range(as.matrix(arrests)), type = 'n', xaxt = 'n', las = 1,
         xlab = '', ylab = 'Number of arrests (per 100,000)')
    matlines(t(arrests), type = 'l', lty = 1, col = 'gray')
    state <- input$state
    if (state != '') {
      lines(1:3, arrests[state, ], lwd = 2, col = 'red')
      text(2, arrests[state, 2], state, cex = 2)
    }
    axis(1, 1:3, colnames(arrests))
  })

  # show raw data
  output$rawdata <- DT::renderDataTable(DT::datatable(
    cbind(State = rownames(USArrests), USArrests),
    options = list(pageLength = 10), rownames = FALSE
  ))

}
