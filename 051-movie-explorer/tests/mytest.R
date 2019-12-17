app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(5)
app$snapshot()
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(year = c(1988, 2014),wait_=FALSE, values_=FALSE)
app$setInputs(year = c(1998, 2014),wait_=FALSE, values_=FALSE)
app$setInputs(year = c(2002, 2014),wait_=FALSE, values_=FALSE)
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
Sys.sleep(20)
app$snapshot()
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(oscars = 4,wait_=FALSE, values_=FALSE)
app$setInputs(year = c(2014, 2014),wait_=FALSE, values_=FALSE)
app$setInputs(oscars = 0,wait_=FALSE, values_=FALSE)
app$setInputs(oscars = 4,wait_=FALSE, values_=FALSE)
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(oscars = 1,wait_=FALSE, values_=FALSE)
app$setInputs(oscars = 0,wait_=FALSE, values_=FALSE)
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
Sys.sleep(5)
app$snapshot()
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(genre = "Animation",wait_=FALSE, values_=FALSE)
Sys.sleep(5)
app$snapshot()
# Input 'plot1_mouse_over' was set, but doesn't have an input binding.
# Input 'plot1_mouse_out' was set, but doesn't have an input binding.
app$setInputs(xvar = "Reviews",wait_=FALSE, values_=FALSE)
app$setInputs(yvar = "BoxOffice",wait_=FALSE, values_=FALSE)
Sys.sleep(5)
app$snapshot()
