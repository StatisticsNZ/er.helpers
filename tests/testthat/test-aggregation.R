test_that("aggregation functions work", {

  # Test that functions return NA when everything is NA, even if the number is
  # below requirements
  expect_equal(mean_with_criteria(rep(NA), 10, 4), NA)
  expect_equal(min_with_criteria(rep(NA), 10, 4), NA)
  expect_equal(max_with_criteria(rep(NA), 10, 4), NA)
})
