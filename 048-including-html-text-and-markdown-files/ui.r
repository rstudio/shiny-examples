library(markdown)

fluidPage(

  titlePanel("includeText, includeHTML, and includeMarkdown"),

  fluidRow(
    column(4,
      includeText("include.txt"),
      br(),
      pre(includeText("include.txt"))
    ),
    column(4,
      includeHTML("include.html")
    ),
    column(4,
      includeMarkdown("include.md")
    )
  )
)
