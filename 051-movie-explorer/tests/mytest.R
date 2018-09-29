app <- ShinyDriver$new("../", shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(year = c(1988, 2014))
app$setInputs(year = c(1998, 2014))
app$setInputs(year = c(2002, 2014))
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$snapshot()
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(oscars = 4)
app$setInputs(year = c(2014, 2014))
app$setInputs(oscars = 0)
app$setInputs(oscars = 4)
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(oscars = 1)
app$setInputs(oscars = 0)
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$snapshot()
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(genre = "Animation")
app$snapshot()
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(xvar = "Reviews")
app$setInputs(yvar = "BoxOffice")
app$snapshot()
