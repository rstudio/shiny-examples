This is the source code for a movie explorer app which runs on R and Shiny. The data is a subset of data from [OMDb](http://www.omdbapi.com/), which in turn is from IMDb and Rotten Tomatoes. The data is saved in a SQLite database.

To run it locally, you'll need to install the latest versions of [ggvis](http://ggvis.rstudio.com), [Shiny](http://shiny.rstudio.com), and [dplyr](https://github.com/hadley/dplyr), as well as [RSQLite](http://cran.r-project.org/web/packages/RSQLite/index.html).

```R
# Install devtools 1.4 if needed
if (!require('devtools') || packageVersion('devtools') < 1.4) install.packages('devtools')

devtools::install_github(c('rstudio/ggvis', 'rstudio/shiny', 'hadley/dplyr'))

install.packages(c('RSQLite', 'RSQLite.extfuns'))
```

You may need to restart R to make sure the newly-installed packages work properly.

After all these packages are installed, you can run this app by entering the directory, and then running the following in R:

```S
shiny::runApp()
```
