app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(x1 = "CA")
app$setInputs(x4 = "NJ")
app$snapshot()
app$setInputs(x2 = "OR")
app$snapshot()
