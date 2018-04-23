app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
# Input 'plot_click' was set, but doesn't have an input binding.
app$snapshot()
# Input 'plot_click' was set, but doesn't have an input binding.
app$snapshot()
