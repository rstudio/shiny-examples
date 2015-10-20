This small example shows a Shiny module (`linked_brush.R`) and how it can be
used within an application (`app.R`). The linked brush module lets the caller
specify the data frame (mpg) and dimensions (cty/hwy and drv/hwy) that should
be plotted, and also returns a reactive expression that contains the data
frame with selection info in a `selected_` column.
