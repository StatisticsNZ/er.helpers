test_that("anomaly works", {

  expect_length(calc_annual_anomaly(runif(100, 10, 20),
                                    1901:2000,
                                    c(1961, 1990)), 100)
})