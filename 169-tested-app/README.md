Must be using Shiny 1.3.2.9001 to have the autoload option. And must set the option:

```
options(shiny.autoload.r = TRUE)
```

in order for this app to run.

Then you can run the tests as outlined in https://github.com/rstudio/shiny/compare/jeff/feature/test?expand=1 by running `shiny::testApp()` on this directory. It should run both the testthat unit tests and the shinytests associated with this app.
