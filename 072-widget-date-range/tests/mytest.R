app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(dates = c("2018-04-20", "2018-04-16"))
app$snapshot()
app$setInputs(dates = c("2018-04-20", "2018-04-30"))
app$snapshot()
