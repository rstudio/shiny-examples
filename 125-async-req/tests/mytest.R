app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(10)
app$snapshot()
app$setInputs(boom = "click")

Sys.sleep(10)
app$snapshot()
app$setInputs(boom = "click")

Sys.sleep(10)
app$snapshot()
