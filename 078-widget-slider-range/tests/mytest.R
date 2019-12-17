app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(slider2 = c(25, 100))
app$snapshot()
app$setInputs(slider2 = c(76, 100))
app$snapshot()
