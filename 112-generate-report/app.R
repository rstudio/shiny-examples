shinyApp(
  ui = fluidPage(
    sliderInput("slider", "Slider", 1, 100, 50),
    downloadButton("report", "Generate report")
  ),
  server = function(input, output) {
    output$report <- downloadHandler(
      filename = "report.html",
      content = function(file) {
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
