library(shiny)

tempdir <- tempfile("test")
dir.create(tempdir)
addResourcePath("my_test_prefix", tempdir)
unlink(tempdir, recursive = TRUE)

ui <- HTML("This app tests whether deleting a directory pointed to by <code>addResourcePath</code> breaks Shiny. If you're reading this, the test passed!")

server <- function(input, output, session) {
}

shinyApp(ui, server)

