test_that("diversity indices match known equal-abundance values", {
  counts <- rep(10, 4)

  expect_equal(shannon_diversity(counts), log(4))
  expect_equal(shannon_diversity(counts, base = 2), 2)
  expect_equal(simpson_diversity(counts), 0.75)
  expect_equal(simpson_diversity(counts, method = "simpson"), 0.25)
  expect_equal(simpson_diversity(counts, method = "inverse"), 4)
})

test_that("zero counts and missing-value policy are handled", {
  expect_equal(shannon_diversity(c(10, 0, 0)), 0)
  expect_true(is.na(shannon_diversity(c(10, NA))))
  expect_equal(shannon_diversity(c(10, NA), na.rm = TRUE), 0)
})

test_that("invalid abundance data fail clearly", {
  expect_error(shannon_diversity(c(0, 0)), "greater than zero")
  expect_error(shannon_diversity(c(2, -1)), "negative")
  expect_error(shannon_diversity(c(2, 1), base = 1), "base")
  expect_error(simpson_diversity("not numeric"), "numeric vector")
})

