app <- ShinyDriver$new("../../", seed = 100)
app$snapshotInit("mytest")

app$snapshot()
app$snapshot()
app$snapshot()
app$snapshot()
