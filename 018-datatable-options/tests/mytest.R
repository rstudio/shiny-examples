app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Input 'ex1_rows_current' was set, but doesn't have an input binding.
# Input 'ex1_rows_all' was set, but doesn't have an input binding.
app$snapshot()
# Input 'ex1_rows_all' was set, but doesn't have an input binding.
# Input 'ex1_search' was set, but doesn't have an input binding.
# Input 'ex1_rows_all' was set, but doesn't have an input binding.
# Input 'ex1_search' was set, but doesn't have an input binding.
# Input 'ex1_search' was set, but doesn't have an input binding.
# Input 'ex1_search' was set, but doesn't have an input binding.
# Input 'ex1_rows_current' was set, but doesn't have an input binding.
# Input 'ex2_rows_current' was set, but doesn't have an input binding.
# Input 'ex2_rows_all' was set, but doesn't have an input binding.
app$snapshot()
# Input 'ex3_rows_current' was set, but doesn't have an input binding.
# Input 'ex3_rows_all' was set, but doesn't have an input binding.
app$snapshot()
# Input 'ex4_rows_current' was set, but doesn't have an input binding.
# Input 'ex4_rows_all' was set, but doesn't have an input binding.
app$snapshot()
# Input 'ex5_rows_current' was set, but doesn't have an input binding.
# Input 'ex5_rows_all' was set, but doesn't have an input binding.
app$snapshot()
# Input 'ex5_rows_current' was set, but doesn't have an input binding.
app$snapshot()
# Input 'ex2_rows_current' was set, but doesn't have an input binding.
app$snapshot()
