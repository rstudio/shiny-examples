app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(runif = "click")
app$snapshot()
app$setInputs(rnorm = "click")
app$snapshot()
