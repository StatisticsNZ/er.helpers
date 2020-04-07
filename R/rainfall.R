#' Get proportion of rainfall above reference
#'
#' Calculates the proportion of rainfall above the refrerence_rainfall value.
#' Usually the reference corresponds to the 95th percentile of a climate
#' normal/reference period. The proportion is often calculated in an annual
#' basis and is a measure of the proportion of annual total rain that falls in
#' intense events. This measure provides information about the importance of
#' intense rainfall events for total annual rainfall.
#'
#' @inheritParams get_reference_precipitation
#' @param reference_precipitation reference value of precipitation
#'
#' @return a value between 0 and 1
#' @importFrom stats rlnorm
#' @family rainfall functions
#' @name rainfall_above_reference
#' @seealso \code{\link{er.helpers-deprecated}}
#' @export
#'
#' @examples
#' library(dplyr)
#' # Simulate one measurement of rain per day for 10 years
#' rainfall <- rlnorm(10*365)
#' years <- rep(2001:2010, each = 365)
#' rain_data <- tibble(rainfall = rainfall, year = years)
#' # We chose a climate normal
#' climate_normal <- c(2001, 2005)
#'
#' rain_data %>%
#' # calculate reference rainfall
#'   mutate(ref = get_reference_precipitation(rainfall,
#'                                             year,
#'                                             climate_normal,
#'                                             percentile = 95L)) %>%
#' # calculate prorportion of rainfall above reference
#'   group_by(year) %>%
#'   summarise(prop_above = precipitation_above_reference(rainfall, ref))
precipitation_above_reference <- function(precipitation,
                                          reference_precipitation,
                                          wet_day_threshold){


  above_reference <- rainfall[rainfall > reference_rainfall]
  wet_days <- rainfall[rainfall >= wet_day_threshold]
  sum(above_reference, na.rm = TRUE) / sum(wet_days, na.rm = TRUE)

}


#' Calculate reference precipitation for a reference period/climate normal
#'
#' The reference rainfall corresponds to the (usually) 95th or 99th percentile
#' of rainfall within the reference period.

#'
#' @param precipitation vector with rainfall values
#' @param date date for each rain value. Must be the same lentgth of rainfall
#'   and must be the same type as the reference period. I.e if date is numeric
#'   (e.g. year) then the reference period must be given as numeric as well. If
#'   date is a date or a date-time ("date" or "POSIX.ct") then the reference
#'   period must be also a date or a date-time
#' @param reference_period vector of length 2 with the beginning and end of the
#'   reference period
#' @param percentile percentile for the reference period. Defaults to the 95th
#'   percentile
#' @param wet_day_threshold Numeric. Amount of precipitation at which the day is
#'   considered a wet day. Defaults to 1.
#'
#' @return the 95th percentile for the reference period.
#' @importFrom stats quantile
#' @family rainfall functions
#' @name get_reference_rainfall
#' @seealso \code{\link{er.helpers-deprecated}}
#' @export
#'
#' @examples
#' library(dplyr)
#' # Simulate one measurement of rain per day for 10 years
#' rainfall <- rlnorm(10*365)
#' years <- rep(2001:2010, each = 365)
#' rain_data <- tibble(rainfall = rainfall, year = years)
#' # We chose a climate normal
#' climate_normal <- c(2001, 2005)
#'
#' rain_data %>%
#' # calculate reference rainfall
#'   mutate(ref = get_reference_precipitation(rainfall,
#'                                            year,
#'                                            climate_normal,
#'                                            percentile = 95L)) %>%
#' # calculate prorportion of rainfall above reference
#'   group_by(year) %>%
#'   summarise(prop_above = precipitation_above_reference(rainfall, ref))
get_reference_precipitation <- function(precipitation,
                                        date = NULL,
                                        reference_period = NULL,
                                        percentile = 95L,
                                        wet_day_threshold = 1){
  # error checking
  if (length(percentile) != 1)
    stop("percentile must be of lenghth 1")

  if (percentile > 100 | percentile < 0)
    stop("percentile must be between 0 and 100")

  if (is.null(reference_period)) {
    rainfall_for_reference <- rainfall
  } else {
    rainfall_for_reference <- rainfall[date >= reference_period[1] &
                                         date <= reference_period[2]]
  }

  rainfall_for_reference <- rainfall_for_reference[rainfall_for_reference >=
                                                     wet_day_threshold]
  quantile(rainfall_for_reference, probs = percentile / 100)
}


