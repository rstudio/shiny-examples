app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(runif = "click")
app$snapshot()
app$setInputs(reset = "click")
app$snapshot()
app$setInputs(runif = "click")
app$snapshot()
