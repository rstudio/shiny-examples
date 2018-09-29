app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(date = "2018-04-20")
app$snapshot()
app$snapshot()
app$snapshot()
app$snapshot()
