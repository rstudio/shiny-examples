app <- ShinyDriver$new("../../", seed = 100)
app$snapshotInit("mytest")

app$snapshot()
