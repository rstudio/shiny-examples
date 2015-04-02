This is the source code for a movie explorer app which runs on R and Shiny. The data is a subset of data from [OMDb](http://www.omdbapi.com/), which in turn is from IMDb and Rotten Tomatoes. The data is saved in a SQLite database.

To run it locally, you'll need to install the latest versions of [ggvis](http://ggvis.rstudio.com), [Shiny](http://shiny.rstudio.com), and [dplyr](https://github.com/hadley/dplyr), as well as [RSQLite](http://cran.r-project.org/web/packages/RSQLite/index.html).

```r
install.packages(c('shiny', 'ggvis', 'dplyr', 'RSQLite'))
```

You may need to restart R to make sure the newly-installed packages work properly.

After all these packages are installed, you can run this app by entering the directory, and then running the following in R:

```s
shiny::runApp()
```
