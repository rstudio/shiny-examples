app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(show = "click")
app$snapshot()
app$setInputs(show = "click")
app$snapshot()
