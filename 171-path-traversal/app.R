shinyApp(
  fluidPage(
    p(
      "Click on each of the links below. They should report that the file is not found, or is forbidden.",
      "(For issues ", a("httpuv#235", href = "https://github.com/rstudio/httpuv/pull/235"),
      "and ", a("shiny#2566", href = "https://github.com/rstudio/shiny/pull/2566", .noWS = "after"), ")",
    ),
    a("Link 1", href = "/shared/..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5cwindows%5cwin.ini"),
    br(),
    a("Link 2", href = "/shared/../../../../../../../../etc/passwd")
  ),
  function(input, output) {}
)
