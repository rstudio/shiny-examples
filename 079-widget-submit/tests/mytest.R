app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(num = 5)
app$snapshot()
app$setInputs(num = 9)
app$snapshot()
