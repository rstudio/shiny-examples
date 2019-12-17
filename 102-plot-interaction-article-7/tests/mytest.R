app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
# Input 'plot_brush' was set, but doesn't have an input binding.
app$snapshot()
app$snapshot()
