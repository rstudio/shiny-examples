shinyApp(
  ui = fluidPage(
    sliderInput("slider", "Slider", 1, 100, 50),
    downloadButton("report", "Generate report")
  ),
  server = function(input, output) {
    output$report <- downloadHandler(
      filename = "report.html",
      content = function(file) {
        src <- normalizePath('report.Rmd')

        # Temporarily switch to a temp dir, in case you don't have write
        # permissions to the current working directory.
        owd <- setwd(tempdir())
        on.exit(setwd(owd))
        file.copy(src, "report.Rmd", overwrite = TRUE)

        # Set up parameters to pass to Rmd document
        params <- list(n = input$slider)

        # Knit the document, passing in the `params` list, and eval it in a
        # child of the global environment (this isolates the code in the document
        # from the code in this app).
        rmarkdown::render("report.Rmd", output_file = file,
          params = params,
          envir = new.env(parent = globalenv())
        )
      }
    )
  }
)
