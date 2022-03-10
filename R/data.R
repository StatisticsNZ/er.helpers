#' IPCC likelihood scale
#'
#' A dataset containing the Intergovernmental Panel on Climate Change (IPCC)
#' likelihood scale
#'
#' @format A data frame with 9 rows and 5 variables:
#' \describe{
#'   \item{term}{likelihood term}
#'   \item{left_break}{lower probability limit for the term}
#'   \item{right_break}{upper probability limit for the term}
#'   \item{left_open}{whether the lower limit is an open interval}
#'   \item{right_open}{whether the upper limit is an open interval}
#' }
#'
#' @source Mastrandrea, M.D., C.B. Field, T.F. Stocker, O. Edenhofer, K.L. Ebi,
#'   D.J. Frame, H. Held, E. Kriegler, K.J. Mach, P.R. Matschoss, G.-K.
#'   Plattner, G.W. Yohe, and F.W. Zwiers, 2010: Guidance Note for Lead Authors
#'   of the IPCC Fifth Assessment Report on Consistent Treatment of
#'   Uncertainties. Intergovernmental Panel on Climate Change (IPCC). Available
#'   at \url{http://www.ipcc.ch}
"ipcc_likelihood_scale"

#' Stats NZ likelihood scale
#'
#' A dataset containing the Statistics New Zealand (Stats NZ) likelihood scale.
#' This scale is a simplification of the IPCC likelihood scale


#' @format A data frame with 9 rows and 5 variables:
#' \describe{
#'   \item{term}{likelihood term}
#'   \item{left_break}{lower probability limit for the term}
#'   \item{right_break}{upper probability limit for the term}
#'   \item{left_open}{whether the lower limit is an open interval}
#'   \item{right_open}{whether the upper limit is an open interval}
#' }
#'
#' @source http://archive.stats.govt.nz/browse_for_stats/environment/environmental-reporting-series/environmental-indicators/Home/About/trend-assessment-technical-information.aspx
"statsnz_likelihood_scale"

#' @title Hexagonal grid sf object with hexagons of 346km2.
#' @description Hexagonal grid sf object with hexagons of 346km2.
#' @format An \code{sf} object.
"nz_grid_hex_346"

#' @format A data frame with 9 rows and 5 variables:
#' \describe{
#'   \item{term}{likelihood term}
#'   \item{left_break}{lower probability limit for the term}
#'   \item{right_break}{upper probability limit for the term}
#'   \item{left_open}{whether the lower limit is an open interval}
#'   \item{right_open}{whether the upper limit is an open interval}
#' }
#'
#' @source http://archive.stats.govt.nz/browse_for_stats/environment/environmental-reporting-series/environmental-indicators/Home/About/trend-assessment-technical-information.aspx
"statsnz_likelihood_scale"


#' @title New Zealand with regional bourndaries sf object.
#' @description Hexagonal grid sf object with hexagons of 346km2.
#' @format An \code{sf} object.
"nz_grid_hex_346"


#' @title New Zealand coastline.
#' @description Simplified New Zealand coastline boundary, excluding the Chatham Islands.
#' @format An \code{sf} object.
"nz"

#' New Zealand coastline intersected with regional bourndaries.
#'
#' An sf object of New Zealand coastline intersected with regional bourndaries.
#'
#' @format An sf object with 3 columns and 16 rows:
#' \describe{
#'   \item{region_code}{The code for each region}
#'   \item{region}{The name of each region}
#' }
"nz_region"