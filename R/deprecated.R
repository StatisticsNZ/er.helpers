## er.helpers-deprecated.r
#' @title Deprecated functions in package \pkg{er.helpers}.
#' @description The functions listed below are deprecated and will be defunct in
#'   the near future. When possible, alternative functions with similar
#'   functionality are also mentioned. Help pages for deprecated functions are
#'   available at \code{help("-deprecated")}.
#' @name er.helpers-deprecated
#' @keywords internal
NULL

#' @rdname er.helpers-deprecated
#' @section \code{get_reference_rainfall}:
#' For \code{get_reference_rainfall}, use \code{\link{get_reference_precipitation}}.
#' @keywords internal
#' @export
get_reference_rainfall <- function(rainfall, year, reference_period, percentile) {
  .Deprecated("get_reference_precipitation")
  get_reference_precipitation(rainfall, year, reference_period, percentile)
}

#' @rdname er.helpers-deprecated
#' @section \code{rainfall_above_reference}:
#' For \code{rainfall_above_reference}, use \code{\link{precipitation_above_reference}}.
#' @keywords internal
#' @export
rainfall_above_reference <- function(rainfall, reference_rainfall) {
  .Deprecated("precipitation_above_reference")
  precipitation_above_reference(rainfall, reference_rainfall)
}
