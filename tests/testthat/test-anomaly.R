test_that("anomaly works", {

  temp <- runif(100, 10, 20)
  years <- 1901:2000
  ref_period <- c(1961, 1990)

  # output must be same length as input
  expect_length(calc_annual_anomaly(temp, years, ref_period), 100)

  # If proportion of NAs during reference period is larger than 0.2 return NA
  temp_na <- temp
  temp_na[60:80] <- NA
  expect_warning({
    calc_annual_anomaly(temp_na, years, ref_period, max_missing = 0.2) %>%
      is.na() %>%
      all() %>%
      expect_equal(TRUE)
  })

  # If proportion of NA during referebce period is smaller than 0.2 then
  # calculate the anomaly
  temp_na <- temp
  temp_na[61:65] <- NA
  expect_warning({
    calc_annual_anomaly(temp_na, years, ref_period, max_missing = 0.2) %>%
      is.na() %>%
      sum() %>%
      expect_equal(5)
  })

})
