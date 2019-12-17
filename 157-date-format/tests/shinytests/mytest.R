app <- ShinyDriver$new("../../", seed = 100)
app$snapshotInit("mytest")
Sys.sleep(10)
app$snapshot()

Sys.sleep(10)
app$snapshot()
app$setInputs(x1 = "2019-11-07")
app$setInputs(x5 = c(Sys.Date(), "2019-11-26"),wait_=FALSE, values_=FALSE)

Sys.sleep(10)
app$snapshot()

Sys.sleep(10)
app$snapshot()
