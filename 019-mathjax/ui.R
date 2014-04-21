library(shiny)

shinyUI(fluidPage(
  title = 'MathJax Examples',
  withMathJax(),
  helpText('An irrational number \\(\\sqrt{2}\\)
           and a fraction $$1-\\frac{1}{2}$$'),
  helpText('and a fact about \\(\\pi\\):
           $$\\frac2\\pi = \\frac{\\sqrt2}2 \\cdot
           \\frac{\\sqrt{2+\\sqrt2}}2 \\cdot
           \\frac{\\sqrt{2+\\sqrt{2+\\sqrt2}}}2 \\cdots$$'),
  uiOutput('ex1'),
  uiOutput('ex2'),
  uiOutput('ex3'),
  checkboxInput('ex4_visible', 'Show Example 4', FALSE),
  uiOutput('ex4')
))
