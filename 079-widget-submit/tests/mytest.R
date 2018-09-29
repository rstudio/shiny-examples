app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(num = 5,wait_=FALSE, values_=FALSE)
app$snapshot()
app$setInputs(num = 9,wait_=FALSE, values_=FALSE)
app$snapshot()
