app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Input 'one' was set, but doesn't have an input binding.
app$snapshot()
# Input 'two' was set, but doesn't have an input binding.
# Input 'seven' was set, but doesn't have an input binding.
# Input 'seven' was set, but doesn't have an input binding.
app$snapshot()
# Input 'six' was set, but doesn't have an input binding.
# Input 'six' was set, but doesn't have an input binding.
app$snapshot()
