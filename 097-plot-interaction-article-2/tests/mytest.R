app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
app$snapshot()
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_brush' was set, but doesn't have an input binding.
# Input 'plot_click' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
app$snapshot()
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_click' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
app$snapshot()
# Input 'plot_hover' was set, but doesn't have an input binding.
# Input 'plot_click' was set, but doesn't have an input binding.
# Input 'plot_hover' was set, but doesn't have an input binding.
app$snapshot()
