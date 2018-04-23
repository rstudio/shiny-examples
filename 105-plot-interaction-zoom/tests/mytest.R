app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
# Input 'plot2_brush' was set, but doesn't have an input binding.
# Input 'plot1_brush' was set, but doesn't have an input binding.
