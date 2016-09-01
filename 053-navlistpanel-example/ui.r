fluidPage(

  titlePanel("Navlist panel example"),

  navlistPanel(
    "Header",
    tabPanel("First",
      h3("This is the first panel")
    ),
    tabPanel("Second",
      h3("This is the second panel")
    ),
    tabPanel("Third",
      h3("This is the third panel")
    )
  )
)
