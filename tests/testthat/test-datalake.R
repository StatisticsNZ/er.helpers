test_that("searching works", {

  empty_search <- search_data_lake()
  expect_s3_class(empty_search, "data.frame")
  expect_gt(nrow(empty_search), 0)

  one_term_search <- search_data_lake("temperature")
  expect_s3_class(one_term_search, "data.frame")
  expect_lte(nrow(one_term_search), nrow(empty_search))

  two_term_search <- search_data_lake(c("temperature", "freshwater"))
  expect_s3_class(two_term_search, "data.frame")
  expect_gte(nrow(two_term_search), nrow(one_term_search))

})
