app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$snapshot()
app$snapshot()
app$snapshot()
