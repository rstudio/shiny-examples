Demonstrates that `.R` files in the `R/` directory are automatically loaded at runtime.

At the moment, this functionality is opt-in so this app requires setting the following option in order to work:

```
options(shiny.autoload.r = TRUE)
```

Without setting that option, the example will fail.

Requires Shiny with the change in https://github.com/rstudio/shiny/pull/2547. This requires Shiny v1.3.2.9001.
