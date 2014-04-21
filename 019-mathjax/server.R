library(shiny)
if (FALSE) library(knitr)  # please ignore this line

shinyServer(function(input, output) {
  output$ex1 <- renderUI({
    withMathJax(helpText('Dynamic output 1:  $$\\alpha^2$$'))
  })
  output$ex2 <- renderUI({
    withMathJax(
      helpText('and output 2 $$3^2+4^2=5^2$$'),
      helpText('and output 3 $$\\sin^2(\\theta)+\\cos^2(\\theta)=1$$')
    )
  })
  output$ex3 <- renderUI({
    withMathJax(
      helpText('The busy Cauchy distribution
               $$\\frac{1}{\\pi\\gamma\\,\\left[1 +
               \\left(\\frac{x-x_0}{\\gamma}\\right)^2\\right]}\\!$$'))
  })
})
