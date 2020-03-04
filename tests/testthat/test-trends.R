test_that("trends work", {

  x <- runif(100) * 1:100
  # Should run without problems
  expect_identical(sen_slope(x)$note, NA_character_)
  expect_identical(mann_kendall(x)$note, NA_character_)

  y <- runif(5)
  # Should warn of small sample size
  expect_warning(expect_match(sen_slope(y)$note,
                              "Less than 10 values provided."))
  expect_warning(expect_match(mann_kendall(y)$note,
                              "Less than 10 values provided."))

  z <- rep(1, 10)
  # Should warn all values are tied
  expect_warning(expect_match(sen_slope(z)$note, "All values tied."))
  expect_warning(expect_match(mann_kendall(z)$note, "All values tied."))
  expect_warning(expect_equal(mann_kendall(z)$p_value, 0.5))
})
