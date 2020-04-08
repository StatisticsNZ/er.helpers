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
                 method = "Sen's slope",
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

  tibble::tibble(p_value = ifelse(all_ties & !any(is.na(x)), 0.5,
                                  test_result$p.value),
                 s = test_result$estimates["S"],
                 var_s = test_result$estimates["varS"],
                 tau = test_result$estimates["tau"],
                 z = test_result$statistic,
                 method = "Mann-Kendall",
                 n = test_result$parameter["n"],
                 alternative = test_result$alternative,
                 note = analysis_note)

}


#' Linear model for trend analysis
#'
#' Performs a linear model for
#'
#' @param x numeric vector
#' @param y optional time variable, converted to numeric. If its not provided it
#'   will be assumed that all values in X are sequential, regularly measured,
#'   and there are no gaps in the measurements.
#' @conf_level numeric. Level of confidence to be used to calculate the
#'   confidence intervals
#'
#' @return a tidy data frame with the model results
#' @importFrom broom glance tidy
#' @importFrom stats lm qnorm
#' @export
#'
#' @examples
#' x <- runif(100) * 1:100
#' linear_model(x)
#' # If measurements were for example taken daily
#' linear_model(x, y = Sys.Date() + (1:100))
linear_model <- function(x, y = NULL, conf_level = 0.95){

  analysis_note <- NULL

  if (length(x) < 10) {
    warning("Less than 10 values provided for trend analysis")
    analysis_note <- paste0(analysis_note, "Less than 10 values provided. ")
  }

  if (is.null(y)) {
    y <- 1:length(x)
  } else {
    y <- as.numeric(y)
  }

  model_data <- tibble::tibble(x = x) %>%
    dplyr::mutate(y = y)

  model <- lm(x ~ y, data = model_data)
  model_glance <- glance(model)
  model_tidy <- tidy(model)

  quantile <- qnorm((1 + conf_level)/2)
  conf_width <- model_tidy[2, "std.error"] %>%
    magrittr::multiply_by(quantile) %>%
    magrittr::extract2(1)

  if (is.null(analysis_note))
    analysis_note <- NA_character_

  tibble::tibble(p_value = model_glance$p.value,
                 slope = model_tidy[2, "estimate"][[1]],
                 conf_low = model_tidy[2, "estimate"][[1]] - conf_width,
                 conf_high = model_tidy[2, "estimate"][[1]] + conf_width,
                 conf_level = conf_level,
                 intercept = model_tidy[1, "estimate"][[1]],
                 r_squared = model_glance$r.squared[1],
                 sigma = model_glance$sigma[1],
                 method = "Linear model",
                 n = length(x),
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
