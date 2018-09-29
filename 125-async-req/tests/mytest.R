app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(boom = "click")
app$snapshot()
app$setInputs(boom = "click")
app$snapshot()
