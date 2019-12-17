app <- ShinyDriver$new("../../", seed = 100)
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(val = Sys.Date(),wait_=FALSE, values_=FALSE)
app$snapshot()
