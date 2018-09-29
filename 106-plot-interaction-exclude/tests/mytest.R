app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(exclude_toggle = "click")
app$setInputs(exclude_reset = "click")
app$snapshot()
app$setInputs(exclude_toggle = "click")
# Input 'plot1_click' was set, but doesn't have an input binding.
# Input 'plot1_brush' was set, but doesn't have an input binding.
# Input 'plot1_click' was set, but doesn't have an input binding.
# Input 'plot1_brush' was set, but doesn't have an input binding.
# Input 'plot1_click' was set, but doesn't have an input binding.
app$setInputs(exclude_reset = "click")
app$setInputs(exclude_reset = "click")
app$setInputs(exclude_toggle = "click")
# Input 'plot1_click' was set, but doesn't have an input binding.
# Input 'plot1_brush' was set, but doesn't have an input binding.
# Input 'plot1_brush' was set, but doesn't have an input binding.
# Input 'plot1_click' was set, but doesn't have an input binding.
# Input 'plot1_brush' was set, but doesn't have an input binding.
app$snapshot()
