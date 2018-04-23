app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(show = "click")
app$snapshot()
app$setInputs(show = "click")
app$snapshot()
