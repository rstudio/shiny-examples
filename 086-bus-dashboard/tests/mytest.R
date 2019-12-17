app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(routeNum = "6")
app$snapshot()
# Input 'busmap_bounds' was set, but doesn't have an input binding.
# Input 'busmap_center' was set, but doesn't have an input binding.
# Input 'busmap_zoom' was set, but doesn't have an input binding.
# Input 'busmap_bounds' was set, but doesn't have an input binding.
# Input 'busmap_center' was set, but doesn't have an input binding.
# Input 'busmap_zoom' was set, but doesn't have an input binding.
# Input 'busmap_bounds' was set, but doesn't have an input binding.
# Input 'busmap_center' was set, but doesn't have an input binding.
# Input 'busmap_zoom' was set, but doesn't have an input binding.
# Input 'busmap_bounds' was set, but doesn't have an input binding.
# Input 'busmap_center' was set, but doesn't have an input binding.
# Input 'busmap_zoom' was set, but doesn't have an input binding.
app$setInputs(zoomButton = "click")
app$snapshot()
app$setInputs(refresh = "click")
app$snapshot()
app$setInputs(interval = "600")
app$snapshot()
