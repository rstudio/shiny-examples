app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
# Input '`scatters-brush`' was set, but doesn't have an input binding.
app$snapshot()
app$snapshot()
app$snapshot()
