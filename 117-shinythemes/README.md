This app demonstrates the themes available in the [shinythemes](http://rstudio.github.io/shinythemes/) package. You can select a theme by using the selector in the upper right.

Once you've found a theme that you like, you can use it in your app by passing the argument `theme = shinythemes::shinytheme("theme_name")` (where you replace `theme_name` with the theme that you want) to the top-level page function in your app. The top-level page function in your app will be one of `fluidPage()`, `bootstrapPage()`, `navbarPage()`, or `fixedPage()`.
