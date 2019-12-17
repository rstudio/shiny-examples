app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(clear = "click")
app$snapshot()
app$setInputs(clear = "click")
app$snapshot()
