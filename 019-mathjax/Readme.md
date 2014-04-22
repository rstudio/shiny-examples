The function `withMathJax()` is a wrapper function to load the
[MathJax](http://www.mathjax.org) library in a shiny app. For static HTML
content, we only need to call `withMathJax()` once. However, for dynamic UI
output via `renderUI()`, we must wrap the content that contains math
expressions in `withMathJax()`, because we have to call the MathJax function
`MathJax.Hub.Queue(["Typeset", MathJax.Hub])` to render math manually, which is
what `withMathJax()` does.
