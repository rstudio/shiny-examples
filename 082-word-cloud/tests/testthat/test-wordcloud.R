
context("loadBook")

# Write out a test book using:
# bf <- gzfile(test_path("test_books", "summer.txt.gz"), "w")
# writeLines(c("Sample book", "lines here"), bf)
# close(bf)

test_that("reads in the lines of a book", {
  book <- loadBook("summer", test_path("test_books/"))

  # Validate that there are four lines in my test book (as defined above)
  expect_length(book, 2)
  # Spot check one line
  expect_equal(book[2], "lines here")
})

test_that("refuses to read in unrecognized books", {
  expect_error(loadBook("MALICIOUS NAME"), "Unknown book")
})


context("getTermMatrix")

test_that("summarizes the given terms and is sorted", {
  m <- suppressWarnings(getTermMatrix(c("lines words", "additional words")))
  expect_length(m, 3)
  expect_equal(m[["words"]], 2)
  expect_equal(m[["additional"]], 1)

  # Sort the output to ensure that it's no different.
  sorted <- sort(m, decreasing=TRUE)
  expect_equal(m, sorted)
})

test_that("it removes stopwords", {
  m <- suppressWarnings(getTermMatrix(c("thy thou interesting thee")))
  # The only word that didn't get filtered out should be 'interesting'
  expect_equal(names(m), "interesting")
})
