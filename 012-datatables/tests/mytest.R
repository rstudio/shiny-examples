app <- ShinyDriver$new("../", seed = 100,shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
Sys.sleep(5)
app$snapshot()
app$setInputs(dataset = "mtcars")
Sys.sleep(5)
# Input 'mytable2_rows_current' was set, but doesn't have an input binding.
# Input 'mytable2_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(dataset = "iris")
Sys.sleep(5)
# Input 'mytable3_rows_current' was set, but doesn't have an input binding.
# Input 'mytable3_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(dataset = "diamonds")
Sys.sleep(5)
app$setInputs(show_vars = c("carat", "cut", "color", "clarity", "depth", "price", "x", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = c("carat", "cut", "color", "clarity", "price", "x", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
Sys.sleep(5)
app$snapshot()
app$setInputs(show_vars = c("carat", "cut", "color", "clarity", "price", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = c("carat", "color", "clarity", "price", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
Sys.sleep(5)
app$snapshot()
app$setInputs(show_vars = c("color", "clarity", "price", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = c("clarity", "price", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = c("price", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = c("y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = "z")
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = character(0))
Sys.sleep(5)
app$snapshot()
app$setInputs(dataset = "mtcars")
Sys.sleep(5)
app$snapshot()
# Input 'mytable2_rows_current' was set, but doesn't have an input binding.
Sys.sleep(5)
app$snapshot()
# Input 'mytable2_rows_current' was set, but doesn't have an input binding.
# Input 'mytable2_rows_all' was set, but doesn't have an input binding.
# Input 'mytable2_search' was set, but doesn't have an input binding.
# Input 'mytable2_rows_current' was set, but doesn't have an input binding.
# Input 'mytable2_rows_all' was set, but doesn't have an input binding.
# Input 'mytable2_search' was set, but doesn't have an input binding.
Sys.sleep(5)
app$snapshot()
# Input 'mytable2_rows_current' was set, but doesn't have an input binding.
# Input 'mytable2_rows_all' was set, but doesn't have an input binding.
# Input 'mytable2_search' was set, but doesn't have an input binding.
# Input 'mytable2_rows_current' was set, but doesn't have an input binding.
# Input 'mytable2_rows_all' was set, but doesn't have an input binding.
# Input 'mytable2_search' was set, but doesn't have an input binding.
# Input 'mytable2_rows_current' was set, but doesn't have an input binding.
# Input 'mytable2_rows_all' was set, but doesn't have an input binding.
# Input 'mytable2_search' was set, but doesn't have an input binding.
# Input 'mytable2_rows_current' was set, but doesn't have an input binding.
# Input 'mytable2_rows_all' was set, but doesn't have an input binding.
# Input 'mytable2_search' was set, but doesn't have an input binding.
# Input 'mytable2_rows_current' was set, but doesn't have an input binding.
# Input 'mytable2_rows_all' was set, but doesn't have an input binding.
# Input 'mytable2_search' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(dataset = "iris")
Sys.sleep(5)
app$snapshot()
