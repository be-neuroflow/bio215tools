test_that("logistic model starts at N0 and approaches K", {
  values <- logistic_growth(c(start = 0, later = 100), 5, 100, 0.8)

  expect_equal(values[[1]], 5)
  expect_equal(unname(values[[2]]), 100, tolerance = 1e-10)
  expect_named(values, c("start", "later"))
})

test_that("doubling time uses log(2) divided by r", {
  expect_equal(doubling_time(log(2)), 1)
  expect_equal(doubling_time(c(slow = 0.1)), c(slow = log(2) / 0.1))
})

test_that("growth functions reject invalid inputs", {
  expect_error(logistic_growth(0:2, 0, 100, 0.2), "N0")
  expect_error(logistic_growth(0:2, 5, -1, 0.2), "K")
  expect_error(doubling_time(c(0.1, 0)), "greater than zero")
})

