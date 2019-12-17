app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(throw = TRUE)
app$snapshotDownload("download")
app$setInputs(throw = FALSE)
app$snapshot()
