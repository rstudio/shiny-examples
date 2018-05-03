app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$uploadFile(file = "Rock.csv") # <-- This should be the path to the file, relative to the app's tests/ directory
app$snapshot()
