#' Calculate annual anomaly
#'
#' @param x metric. A vector
#' @param year the year in which the metric was observed. A vector of the same
#'   length as x
#' @param period the reference period of the anomaly. A vector of length 2 or
#'   NULL. If a vector, the first element indicates the beginning of the
#'   reference period and the second the end of the reference period. If NULL
#'   (the default) the reference period goes from the first to the last year
#'
#' @return a vector with the anomaly of x
#' @export
#'
#' @examples
#'
#' temperature_frame <- tibble::tibble(temperature = runif(100, 10, 20),
#'                                     year = 1901:2000)
#' reference_period <- c(1961, 1990)
#' temperature_frame %>%
#' dplyr::mutate(anomaly = calc_annual_anomaly(temperature,
#'                                            year,
#'                                            reference_period))
calc_annual_anomaly <- function(x, year, period = NULL) {

  if (is.null(period))
    period <- c(min(year), max(year))

  if (min(year) > min(period) | max(year) < max(period)) {
    warning("Reference period not covered by the time series. Returning NA instead")
    return(NA)
  }

  if (length(x) != length(year))
    stop("x and year must have the same length")

  years <- year >= min(period) & year <= max(period)
  values <- x[years]

  if (anyNA(values))
    warning("Missing values for the anomaly reference period")

  reference <- mean(values)
  x - reference
}