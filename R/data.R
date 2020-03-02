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