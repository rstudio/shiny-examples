function(input, output, session) {
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
  output$ex4 <- renderUI({
    invalidateLater(5000, session)
    x <- round(rcauchy(1), 3)
    withMathJax(sprintf("If \\(X\\) is a Cauchy random variable, then
                        $$P(X \\leq %.03f ) = %.03f$$", x, pcauchy(x)))
  })
  output$ex5 <- renderUI({
    if (!input$ex5_visible) return()
    withMathJax(
      helpText('You do not see me initially: $$e^{i \\pi} + 1 = 0$$')
    )
  })
}
