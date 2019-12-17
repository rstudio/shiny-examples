app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(txt = "test")
app$setInputs(txt = "testing")
app$snapshot()
app$setInputs(chk = TRUE)
app$snapshot()
