This app demonstrates some advanced plot interaction features:

* Interactions work with log scales, as well as factors, dates, and datetimes.
* Interactions work with ggplot2 facets.
* There are controls for parameters for double-clicking, hovering, and brushing.
* With brushing, you can have the brush automatically reset whenever a plot is updated. If this is turned off, then when the plot is updated, the brush will be resized to fit the same data coordinates, as long as the x, y, and optional faceting variables are the same as the previous plot.

This app also demonstrates how to use the `nearPoints()` and `brushedPoints()` functions for filtering rows from the data frame.

* `nearPoints()` is used for selecting rows of the data frame that are near a click, double-click, or hover event. In this app, it is used to select rows near the most recent click. The rows are sorted by distance of the point from the mouse event; when you use `addDist=TRUE`, the distance in pixels is shown in the `dist_` column. If you just want the nearest point, you can set the `maxpoints=1`.
* `brushedPoints()` is used for selecting rows of the data frame that are inside the brush.
