app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(nav = "Data explorer")
# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(states = "MA")
# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.
app$snapshot()
