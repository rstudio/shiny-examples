app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
# Input 'image_hover' was set, but doesn't have an input binding.
app$snapshot()
