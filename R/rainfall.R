#' Get proportion of rainfall above reference
#'
#' Calculates the proportion of rainfall above the refrerence_rainfall value.
#' Usually the reference corresponds to the 95th percentile of a climate
#' normal/reference period. The proportion is often calculated in an annual
#' basis and is a measure of the proportion of annual total rain that falls in
#' intense events. This measure provides information about the importance of
#' intense rainfall events for total annual rainfall.
#'
#' @param rainfall vector with rainfall values
#' @param reference_rainfall reference value of rainfall
#'
#' @return a value between 0 and 1
#' @importFrom stats rlnorm
#' @family rainfall functions
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
#'   mutate(ref = get_reference_rainfall(rainfall,
#'                                              year,
#'                                              climate_normal,
#'                                              percentile = 95L)) %>%
#' # calculate prorportion of rainfall above reference
#'   group_by(year) %>%
#'   summarise(prop_above = rainfall_above_reference(rainfall, ref))
rainfall_above_reference <- function(rainfall,
                                     reference_rainfall){


  above_reference <- ifelse(rainfall > reference_rainfall,
                            rainfall - reference_rainfall,
                            0)

  sum(above_reference, na.rm = TRUE) / sum(rainfall, na.rm = TRUE)

}


#' Calculate reference rainfall for a reference period/climate normal
#'
#' The reference rainfall corresponds to the (usually) 95th percentile of
#' rainfall within the reference period.

#'
#' @param rainfall vector with rainfall values
#' @param date year for each rain value. Must be the same lentgth of rainfall
#' @param reference_period vector with the beginning and end of the reference
#'   period
#' @param percentile percentile for the reference period. Defaults to the 95th
#'   percentile
#'
#' @return the 95th percentile for the reference period.
#' @importFrom stats quantile
#' @family rainfall functions
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
#'   mutate(ref = get_reference_rainfall(rainfall,
#'                                              year,
#'                                              climate_normal,
#'                                              percentile = 95L)) %>%
#' # calculate prorportion of rainfall above reference
#'   group_by(year) %>%
#'   summarise(prop_above = rainfall_above_reference(rainfall, ref))
get_reference_rainfall <- function(rainfall,
                                   date = NULL,
                                   reference_period = NULL,
                                   percentile = 95L){
  # error checking
  if (length(percentile) != 1)
    stop("percentile must be of lenghth 1")

  if (percentile > 100 | percentile < 0)
    stop("percentile must be between 0 and 100")

  if (is.null(reference_period)) {
    rainfall_for_reference <- rainfall
  } else {
    rainfall_for_reference <- rainfall[date >= reference_period[1] & date <= reference_period[2]]
  }

  quantile(rainfall_for_reference, probs = percentile / 100)
}