# Workaround for https://github.com/yihui/knitr/issues/1538
evaluate2 <- function(...) evaluate::evaluate(...)
environment(evaluate2) <- asNamespace("knitr")
knitr::knit_hooks$set(evaluate = evaluate2)

function(input, output) {

  regFormula <- reactive({
    as.formula(paste('mpg ~', input$x))
  })

  output$report <- renderUI({
    src <- normalizePath('report.Rmd')

    # temporarily switch to the temp dir, in case you do not have write
    # permission to the current working directory
    owd <- setwd(tempdir())
    on.exit(setwd(owd))
    knitr::opts_knit$set(root.dir = owd)

    tagList(
      HTML(knitr::knit2html(text = readLines(src), fragment.only = TRUE)),
      # typeset LaTeX math
      tags$script(HTML('MathJax.Hub.Queue(["Typeset", MathJax.Hub]);')),
      # syntax highlighting
      tags$script(HTML("if (hljs) $('#report pre code').each(function(i, e) {
                          hljs.highlightBlock(e)
                       });"))
    )
  })

}
