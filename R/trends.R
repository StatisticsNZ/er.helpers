#' Sen's slope
#'
#' #' Performs the Sen's slope trend test. This function is a wrapper around
#' \code{\link[trend]{sens.slope}}. See documentation there for more details about
#' the calculation
#'
#' @inheritParams trend::sens.slope
#' @param conf_level confidence level of the test
#'
#' @return a tidy data frame with the test results
#' @importFrom stats runif
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

  if (any(is.na(x))) {
    warning("Trend analysis does not accept missing data. Returning NA instead.")
    test_result <- list()
    test_result$conf.int <- c(NA, NA)
    conf_level <- NA
    test_result$statistic <- c("z" = NA)
    test_result$parameter <- c("n" = NA)
    test_result$estimates <- c("Sen's slope" = NA)
    test_result$p.value <- test_result$method <- NA
    analysis_note = "NA values present."
  } else {
    test_result <- trend::sens.slope(x, conf.level = conf_level)
  }

  tibble::tibble(p_value = test_result$p.value,
                 sen_slope = test_result$estimates["Sen's slope"],
                 conf_low = test_result$conf.int[1],
                 conf_high = test_result$conf.int[2],
                 conf_level = conf_level,
                 z = test_result$statistic["z"],
                 method = test_result$method,
                 n = test_result$parameter["n"],
                 note = analysis_note)
}

#' Mann-Kendall Trend Test
#'
#' Performs the Mann-Kendall trend test. This function is a wrapper around
#' \code{\link[trend]{mk.test}}. See documentation there for more details about
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

  if (any(is.na(x))) {
    warning("Trend analysis does not accept missing data. Returning NA instead.")
    test_result <- list()
    test_result$statistic <- NA
    test_result$parameter <- c("n" = NA)
    test_result$estimates <- c("S" = NA, "varS" = NA, "tau" = NA)
    test_result$p.value <- test_result$method <- NA
    test_result$alternative <- NA
    analysis_note = "NA values present."
  } else{
    test_result <- trend::mk.test(x,
                                  alternative = alternative,
                                  continuity = continuity)
  }

  tibble::tibble(p_value = ifelse(all_ties & !is.na(test_result$p.value), 0.5,
                                  test_result$p.value),
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
