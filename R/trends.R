#' Sen's slope
#'
#' @inheritParams trend::sens.slope
#'
#' @return a tidy data frame with the test results
#' @export
#'
#' @examples
#' x <- runif(100) * 1:100
#' sen_slope(x)
sen_slope <- function(x, conf_level = 0.95){

  analysis_note <- NULL

  all_ties <- are_all_the_same(x)
  if (all_ties) {
    warning("All values in x are the same. Sen's slope test cannot be performed")
    analysis_note <- paste0(analysis_note, "All values tied. ")
  }

  if (length(x) < 10) {
    warning("Less than 10 values provided for trend analysis")
    analysis_note <- paste0(analysis_note, "Less than 10 values provided. ")
  }

  if (is.null(analysis_note))
    analysis_note <- NA_character_

  test_result <- trend::sens.slope(x, conf.level = conf_level)

  tibble::tibble(p_value = test_result$p.value,
                 sen_slope = test_result$estimates["Sen's slope"],
                 conf_low = test_result$conf.int[1],
                 conf_high = test_result$conf.int[2],
                 conf_level = attr(test_result$conf.int, "conf.level"),
                 z = test_result$statistic["z"],
                 method = test_result$method,
                 n = test_result$parameter["n"],
                 note = analysis_note)
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
#' @export
#'
#' @examples
#' x <- runif(100) * 1:100
#' mann_kendall(x, alternative = "two.sided")
mann_kendall <- function(x,
                        alternative = c("greater", "two.sided", "less"),
                        continuity = TRUE){

  alternative <- match.arg(alternative)

  analysis_note <- NULL

  all_ties <- are_all_the_same(x)
  if (all_ties) {
    warning("All values in x are the same. Mann-Kendall test cannot be performed; p-value set to 0.5")
    analysis_note <- paste0(analysis_note, "All values tied, p-value set to 0.5. ")
  }

  if (length(x) < 10) {
    warning("Less than 10 values provided for trend analysis")
    analysis_note <- paste0(analysis_note, "Less than 10 values provided. ")
  }

  if (is.null(analysis_note))
    analysis_note <- NA_character_

  test_result <- trend::mk.test(x,
                                alternative = alternative,
                                continuity = continuity)

  tibble::tibble(p_value = ifelse(all_ties, 0.5, test_result$p.value),
                 s = test_result$estimates["S"],
                 var_s = test_result$estimates["varS"],
                 tau = test_result$estimates["tau"],
                 z = test_result$statistic,
                 method = test_result$method,
                 n = test_result$parameter["n"],
                 alternative = test_result$alternative,
                 note = analysis_note)

}

#' Are all values on x the same?
#'
#' @param x the values
#'
#' @return TRUE if all values of x are the same, FALSE otherwise
#'
are_all_the_same <- function(x){
  range_x <- range(x, na.rm = TRUE)
  range_x[1] == range_x[2]
}