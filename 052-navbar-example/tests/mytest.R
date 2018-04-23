app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(plotType = "l")
app$snapshot()
app$snapshot()
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$snapshot()
