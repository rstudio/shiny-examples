app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Input 'plot_hover' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(brush_dir = "x")
app$snapshot()
app$setInputs(brush_dir = "y")
app$snapshot()
app$setInputs(brush_policy = "throttle")
app$setInputs(brush_reset = TRUE)
app$snapshot()
app$setInputs(plot_type = "ggplot2")
app$snapshot()
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(max_points = 37)
app$snapshot()
app$setInputs(hover_policy = "throttle")
app$snapshot()
app$setInputs(ggplot_facet = "grid_xy_free")
app$snapshot()
app$setInputs(ggplot_facet = "grid_xy")
app$snapshot()
app$setInputs(plot_type = "base")
app$snapshot()
app$snapshot()
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
