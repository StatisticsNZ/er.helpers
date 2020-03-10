test_that("season ordering works", {
  expect_warning(order_season_levels(c("simmer", "annual", "papa")),
                 "not recognised as valid season")
  expect_s3_class(order_season_levels("summer"), "factor")
})
