test_that("Open and closed intervals work", {

  #
  expect_equal(in_interval(c(0,1), 0, 1, TRUE, TRUE), c(FALSE, FALSE))
  expect_equal(in_interval(c(0,1), 0, 1, FALSE, FALSE), c(TRUE, TRUE))

})


test_that("Likelihood categories work", {

  x <- seq(0, 1, length.out = 11)

  larger_is_better <- get_likelihood_category(x, term_type = "improving-worsening")
  smaller_is_better <- get_likelihood_category(x, term_type = "worsening-improving")
  nothing_is_better <- get_likelihood_category(x, term_type = "likely-unlikely")
  increasing_decreasing <- get_likelihood_category(x, term_type = "increasing-decreasing")

  ipcc_1 <- get_likelihood_category(x, scale = "ipcc", term_type = "improving-worsening")
  ipcc_2 <- get_likelihood_category(x, scale = "ipcc", term_type = "worsening-improving")

  # level order should be the same regardless of the direction of improvement
  expect_identical(levels(larger_is_better), levels(smaller_is_better))

  # Ensure level order is correct for plotting and stuff
  expect_equal(levels(larger_is_better)[1], "Very likely improving")
  expect_equal(levels(nothing_is_better)[1], "Very likely")
  expect_equal(levels(ipcc_1)[1], "Virtually certain")
  expect_equal(levels(increasing_decreasing)[1], "Very likely increasing")

  # Ensure imrpoving and worsening work as expected
  expect_equal(as.character(larger_is_better[1]), "Very likely worsening")
  expect_equal(as.character(smaller_is_better[1]), "Very likely improving")
  expect_equal(as.character(ipcc_1)[1], "Exceptionally unlikely")

  # improving should not matter for ipcc
  expect_identical(ipcc_1, ipcc_2)

  # probability and percentage should be identical
  expect_identical(get_likelihood_category(x, x_is = "probability"),
                   get_likelihood_category(x * 100, x_is = "percentage"))

  # error when x is weird
  expect_error(get_likelihood_category(x * 2))
  expect_error(get_likelihood_category(x * 200, x_is = "percentage"))
  expect_error(get_likelihood_category(x * -1))


  # when there are NAs
  expect_error(get_likelihood_category(NA), "All values in x are NA")
  expect_error(get_likelihood_category(c(NA, NA)), "All values in x are NA")
  expect_warning(get_likelihood_category(c(0,NA,1)), "NA values found in x")
})


