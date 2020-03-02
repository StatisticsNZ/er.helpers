#' Sen's slope
#'
#' @inheritParams trend::sens.slope
#'
#' @return a tidy data frame with the test results
#' @importFrom stats runif
#' @export
#'
#' @examples
#' x <- runif(100) * 1:100
#' sen_slope(x)
sen_slope <- function(x, conf_level = 0.95){

  test_result <- trend::sens.slope(x, conf.level = conf_level)

  tibble::tibble(p_value = test_result$p.value,
                 sen_slope = test_result$estimates["Sen's slope"],
                 conf_low = test_result$conf.int[1],
                 conf_high = test_result$conf.int[2],
                 conf_level = attr(test_result$conf.int, "conf.level"),
                 z = test_result$statistic["z"],
                 method = test_result$method,
                 n = test_result$parameter["n"])
}

#' Mann-Kendall Trend Test
#'
#' Performs the Mann-Kendall trend test. This function is a wrapper around
#' \code{\link{trend::mk.test}}. See documentation there for more details about
#' the calculation
#'
#' @inheritParams trend::mk.test
#'
#' @return a tidy data frame with the test results
#' @importFrom stats runif
#' @export
#'
#' @examples
#' x <- runif(100) * 1:100
#' mann_kendall(x, alternative = "two.sided")
mann_kendall <- function(x,
                        alternative = c("two.sided", "greater", "less"),
                        continuity = TRUE){

  test_result <- trend::mk.test(x,
                                alternative = alternative,
                                continuity = continuity)

  tibble::tibble(p_value = test_result$p.value,
                 s = test_result$estimates["S"],
                 var_s = test_result$estimates["varS"],
                 tau = test_result$estimates["tau"],
                 z = test_result$statistic,
                 method = test_result$method,
                 n = test_result$parameter["n"],
                 alternative = test_result$alternative)

}