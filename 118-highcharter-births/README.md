This app demonstrates the usage of [Highcharts](http://www.highcharts.com/) style plots within Shiny via the [highcharter](http://jkunst.com/highcharter/) package.

The app is based on data from a FiveThirtyEight article titled [Some People Are Too Superstitious To Have A Baby On Friday The 13th](http://fivethirtyeight.com/features/some-people-are-too-superstitious-to-have-a-baby-on-friday-the-13th/). The data come from [here](https://github.com/fivethirtyeight/data/tree/master/births). Note that the calculated percentage point differences may not match the ones in the visualization in the FiveThirtyEight article. There are two reasons for this: (1) Holidays were excluded in the FiveThirtyEight but not in this analysis. (2) Two data files are provided by FiveThirtyEight, one for years 1994 to 2003 and another for years 2000 to 2014. The numbers of births for the overlapping years (2000 - 2003) are not exactly the same. This app uses the SSA data for these years, however it is unclear which data source FiveThirtyEight used for these years.

Use the inputs to select a single year or a range of years, a plot type, and a theme.

Note that the products in the Highcharts library are free for non-commercial use. For use in commercial projects and websites, see [here](https://shop.highsoft.com/).
