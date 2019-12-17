app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(date = Sys.Date(),wait_=FALSE, values_=FALSE)
app$snapshot()
app$snapshot()
app$snapshot()
app$snapshot()
