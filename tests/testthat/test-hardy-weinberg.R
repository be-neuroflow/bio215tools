test_that("equilibrium counts return a zero statistic", {
  result <- hardy_weinberg_test(c(AA = 25, Aa = 50, aa = 25))

  expect_s3_class(result, "htest")
  expect_equal(unname(result$statistic), 0)
  expect_equal(result$p.value, 1)
  expect_equal(unname(result$estimate), 0.5)
  expect_equal(result$expected, c(AA = 25, Aa = 50, aa = 25))
  expect_equal(unname(result$parameter), 1)
})

test_that("a supplied allele frequency uses two degrees of freedom", {
  result <- hardy_weinberg_test(c(30, 40, 30), p = 0.5)
  expect_equal(unname(result$parameter), 2)
})

test_that("invalid genotype data fail clearly", {
  expect_error(hardy_weinberg_test(c(1, 2)), "three")
  expect_error(hardy_weinberg_test(c(1, -1, 2)), "non-negative")
  expect_error(hardy_weinberg_test(c(5, 0, 0)), "monomorphic")
  expect_error(hardy_weinberg_test(c(1, 2, 1), p = 1), "strictly between")
})

