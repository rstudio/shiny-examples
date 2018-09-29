app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(cyl = "6")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(trans = "auto(av)")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(man = "dodge")
app$setInputs(trans = "auto(l4)")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
# Input 'table_search' was set, but doesn't have an input binding.
# Input 'table_search' was set, but doesn't have an input binding.
# Input 'table_search' was set, but doesn't have an input binding.
app$snapshot()
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
# Input 'table_search' was set, but doesn't have an input binding.
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
# Input 'table_search' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(man = "hyundai")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(man = "dodge")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
# Input 'table_rows_current' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(cyl = "All")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
