#' Calculate an aggregated value taking into account certain exclusion cirteria
#'
#' Often one needs to calulate the mean accepting certain number of missing
#' values. For example, the World Meteorological Organisation specifies that
#' monthly values must only be calculated if there is up to 10 missing days and
#' less than 5 are consecutive. This function makes it easy to compute the
#' monthly value by specifing these thresholds
#'
#' @param x Numeric values
#' @param max_missing Numeric. Maximum number or proportion of missing values in
#'   x. If any number of missing values is allowed set to 1 (100%) or NULL.
#' @param max_consecutive Numeric. Maximum number or proportion of consecutive
#'   missing values in x. If any number of missing values is allowed set to 1
#'   (100%) or NULL.
#' @param fun Function. Function used to aggregate values usually, mean, min,
#'   max, or sum
#'
#' @return NA if the criteria arent meet the mean of x otherwise
#' @export
aggregate_with_criteria <- function(x, max_missing = 0, max_consecutive = 0, fun = mean){

  if (is.null(max_missing))
    max_missing <- 1
  if (is.null(max_consecutive))
    max_consecutive <- 1

  na_values <- is.na(x)
  n_missing <- sum(na_values)
  prop_missing <- n_missing / length(x)

  # If max missing is a proportion
  if (max_missing <= 1 & max_missing > 0) {
    if (prop_missing > max_missing)
      return(NA)
    # If max_missing is a integer
  } else if (max_missing %% 1 == 0) {
    if (n_missing > max_missing)
      return(NA)
  } else {
    stop("max_missing must be a proportion or an integer.")
  }

  length_na_streaks <- na_values %>%
    rle() %>%
    {.$lengths[.$values]}
  prop_na_streaks <- length_na_streaks / length(x)

  # If max_consecutive is a proportion
  if (max_consecutive <= 1 & max_consecutive > 0) {
    if (any(prop_na_streaks > max_consecutive))
      return(NA)
    # If max_consecutive is a integer
  } else if (max_consecutive %% 1 == 0) {
    if (any(length_na_streaks > max_consecutive))
      return(NA)
  } else {
    stop("max_consecutive must be a proportion or an integer.")
  }

  mean(x, na.rm = TRUE)
}

#' @describeIn aggregate_with_criteria Mean with criteria
#' @export
mean_with_criteria <- function(x, max_missing = 0, max_consecutive = 0){
  aggregate_with_criteria(x, max_missing, max_consecutive, fun = mean)
}

#' @describeIn aggregate_with_criteria Minimum with criteria
#' @export
min_with_criteria <- function(x, max_missing = 0, max_consecutive = 0){
  aggregate_with_criteria(x, max_missing, max_consecutive, fun = min)
}

#' @describeIn aggregate_with_criteria Maximum with criteria
#' @export
max_with_criteria <- function(x, max_missing = 0, max_consecutive = 0){
  aggregate_with_criteria(x, max_missing, max_consecutive, fun = max)
}