app <- ShinyDriver$new("../../", seed = 100)
app$snapshotInit("mytest")

Sys.sleep(10)
app$snapshot()
Sys.sleep(10)
app$snapshot()
