app <- ShinyDriver$new("../../index.Rmd", seed = 84031)
app$snapshotInit("mytest")

app$snapshot()
app$snapshot()
