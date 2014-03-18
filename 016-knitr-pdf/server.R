shinyServer(function(input, output) {

  regFormula <- reactive({
    as.formula(paste('mpg ~', input$x))
  })

  output$regPlot <- renderPlot({
    plot(regFormula(), data = mtcars, pch = 19)
  })

  output$downloadReport <- downloadHandler(
    filename = 'my-report.pdf',

    content = function(file) {
      rnw <- normalizePath('report.Rnw')

      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      owd <- setwd(tempdir())
      on.exit(setwd(owd))

      library(knitr)
      out <- knit2pdf(rnw)
      file.rename(out, file)
    }
  )

})
