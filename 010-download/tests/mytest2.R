app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest2")

app$snapshot()
app$snapshotDownload("downloadData")
app$setInputs(dataset = "pressure")
app$snapshot()
app$snapshotDownload("downloadData")
