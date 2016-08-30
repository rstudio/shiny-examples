fluidPage(
  titlePanel("Image output"),

  fluidRow(
    column(4, wellPanel(
      sliderInput("r", "Radius :", min = 0.05, max = 1,
                  value = 0.2, step = 0.05),
      radioButtons("picture", "Picture:",
                  c("chainring", "face"))
    )),
    column(4,
      imageOutput("image1", height = 300),
      imageOutput("image2")
    )
  )
)
