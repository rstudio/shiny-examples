app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(throw = TRUE)
app$snapshotDownload("download")
app$setInputs(throw = FALSE)
app$snapshot()
