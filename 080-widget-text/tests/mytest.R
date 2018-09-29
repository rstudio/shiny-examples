app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(text = "Enter t")
app$setInputs(text = "Enter ")
app$setInputs(text = "Enter test")
app$snapshot()
