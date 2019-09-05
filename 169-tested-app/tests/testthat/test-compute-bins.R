context("compute bins")

# We don't employ the same workaround for shiny.autoload.r that we have in server.R here.
# Which means that if the test runner doesn't load compute_bins for us, these tests are not going to pass.

test_that("compute bins works", {
  x <- c(1,20)

  # Defaults to length=20
  expect_equal(compute_bins(x), 1:20)

  expect_equal(compute_bins(x, length=2), c(1,20))
})
