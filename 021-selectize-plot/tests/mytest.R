app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
# Input 'rawdata_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(state = "Alabama")
app$snapshot()
app$setInputs(state = "Arizona")
app$snapshot()
app$setInputs(state = "Arkansas")
app$snapshot()
app$setInputs(state = "California")
app$snapshot()
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
# Input 'rawdata_rows_all' was set, but doesn't have an input binding.
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
# Input 'rawdata_rows_all' was set, but doesn't have an input binding.
# Input 'rawdata_rows_selected' was set, but doesn't have an input binding.
# Input 'rawdata_row_last_clicked' was set, but doesn't have an input binding.
# Input 'rawdata_cell_clicked' was set, but doesn't have an input binding.
app$snapshot()
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
# Input 'rawdata_rows_all' was set, but doesn't have an input binding.
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
# Input 'rawdata_rows_all' was set, but doesn't have an input binding.
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
app$snapshot()
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
# Input 'rawdata_rows_all' was set, but doesn't have an input binding.
# Input 'rawdata_search' was set, but doesn't have an input binding.
app$snapshot()
# Input 'rawdata_rows_current' was set, but doesn't have an input binding.
app$snapshot()
