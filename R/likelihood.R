#' Get likelihood category for a p-value
#'
#' Given a probabiliy p it returns the term used to describe the category this
#' probability belongs to. It ensures the levels of the output are ordered
#' appropietly.
#'
#' This function uses the data contained in the \link{statsnz_likelihood_scale}
#' and \link{ipcc_likelihood_scale} tables to determine the category of a given
#' probability (usually a p-value). It uses
#' \code{\link{order_likelihood_levels}} to ensure that levels of the output are
#' ordered correctly.
#'
#' @param p the probability (or percentage) used to caclulate the category
#' @param scale whether to base the categories using the Statistics New Zealand
#'   likelihood scale ("statsnz") or the IPCC scale ("ipcc")
#' @param term_type when \code{scale = "statsnz"} it allows to modify the terms
#'   depending on what the probability \code{p} indicates. \code{term_type =
#'   "worsening-improving"} indicates that a large \code{p} corresponds to a
#'   worsening trend; this is the default. \code{term_type =
#'   "improving-worsening"} indicates that a large \code{p} corresponds to an
#'   improving trend. \code{term_type = "increasing-decreasing"} indicates that
#'   the output should range from "Very likely increasing" to "Very likely
#'   decreasing". \code{term_type = "likely-unlikely"} indicates that the output
#'   should range from "Very likely" to "Very unlikely".
#' @param p_is whether \code{p} is a probability (from 0 to 1) or a percentage
#'   (from 0 to 100)
#'
#' @return a factor
#' @family likelihood functions
#' @export
#'
#' @examples
#' p <- seq(0, 1, length.out = 11)
#'
#' # In most water quality metrics an increasing trend (large p) corresponds to
#' # a worsening trend
#' get_likelihood_category(p, term_type = "worsening-improving")
#'
#' # In climate metrics we usually prefer an increasing-decreasing scale
#' get_likelihood_category(p, term_type = "increasing-decreasing")
#'
#' # Also works when p is a percentages
#' get_likelihood_category(p*100, p_is = "percentage")
#'
#' # We can also get terms used by ipcc if desired
#' get_likelihood_category(p, scale = "ipcc")
get_likelihood_category <- function(p,
                                    scale = c("statsnz", "ipcc"),
                                    term_type = c("worsening-improving",
                                                  "improving-worsening",
                                                  "increasing-decreasing",
                                                  "decreasing-increasing",
                                                  "likely-unlikely"),
                                    p_is = c("probability", "percentage")) {


  scale <- match.arg(scale)
  term_type <- match.arg(term_type)
  p_is <- match.arg(p_is)

  # determine the desired scale
  scale_frame <- switch(scale,
    statsnz = er.helpers::statsnz_likelihood_scale,
    ipcc = er.helpers::ipcc_likelihood_scale
  )

  terms <- scale_frame$term

  if (scale == "statsnz") {
    terms <- get_likelihood_terms(terms, term_type)
  }

  if (p_is == "percentage") {
    p <- p / 100
  }

  if (all(is.na(p))){
    warning("All values in p are NA")
    return(rep(NA, length(p)))
  }

  if (any(is.na(p)))
    warning("NA values found in p")

  range_p <- range(p, na.rm = TRUE)
  if (!(min(range_p) >= 0 & max(range_p) <= 1))
    stop("p should be between 0 and 1 if is a probabiliy or between 0 and 100 if it's a percentage")

  terms_index <- scale_frame %>%
    split(scale_frame$term) %>%
    purrr::map_dfr(function(x) {
      in_interval(p,
                  x$left_break, x$right_break,
                  x$left_open, x$right_open)})%>%
    as.matrix() %>%
    apply(1, which) %>%
    # Recover if p is NA
    purrr::modify_if(function(x) length(x) == 0, function(p) NA) %>%
    unlist()

  terms[terms_index]

}

#' Wether a value is within a specified interval
#'
#' @param x the value to test
#' @param lower lower limit
#' @param upper upper limit
#' @param left_open whether the lower limit is an open interval
#' @param right_open whether the upper limit is an open interval
#'
#' @return logical
#'
in_interval <- function(x, lower, upper, left_open, right_open){

  left_compare <- ifelse(left_open, yes = `>`, no = `>=`)
  right_compare <- ifelse(right_open, yes = `<`, no = `<=`)

  left_compare(x, lower) & right_compare(x, upper)

}

#' Translate likely-unlikely to a specified term scale
#'
#' @param terms terms to translate
#' @inheritParams get_likelihood_category
#'
#' @return a factor
#'
get_likelihood_terms <- function(terms,
                                 term_type = c("worsening-improving",
                                               "improving-worsening",
                                               "increasing-decreasing",
                                               "likely-unlikely")){

  if (term_type == "likely-unlikely") {
    return(terms)
  } else if (term_type == "increasing-decreasing") {
    translation <- likelihood_terms$statsnz %>%
      magrittr::set_names(rev(likelihood_terms$statsnz_increasing))
  } else if (term_type == "decreasing-increasing") {
    translation <- likelihood_terms$statsnz %>%
      magrittr::set_names(likelihood_terms$statsnz_increasing)
  } else if (term_type == "improving-worsening") {
    translation <- likelihood_terms$statsnz %>%
      magrittr::set_names(likelihood_terms$statsnz_improving)
  } else if (term_type == "worsening-improving") {
    translation <- likelihood_terms$statsnz %>%
      magrittr::set_names(rev(likelihood_terms$statsnz_improving))
  }

  purrr::lift_dv(forcats::fct_recode)(.f = terms, translation) %>%
    order_likelihood_levels()

}

#' Orders the levels of a likelihood category factor
#'
#' @param x the unordered factor. Levels must be one of those found in
#'   er.helpers:::likelihood_terms
#'
#' @return a factor with ordered levels
#' @family likelihood functions
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' library(tibble)
#' trends <- tribble(
#'   ~ trend, ~n,
#'   "Indeterminate", 2,
#'   "Very likely worsening", 3,
#'   "Likely improving", 2)
#' # unordered plot
#' qplot(trend, n, fill = trend, data = trends, geom = "col")
#'
#' ordered_trends <- dplyr::mutate(trends,
#'                                 trend = order_likelihood_levels(trend))
#' # nice ordered plot
#' qplot(trend, n, fill = trend,  data = ordered_trends, geom = "col")
#' }
order_likelihood_levels <- function(x) {

  # If it's not a factor make it one
  if (!is.factor(x))
    x <- factor(x)

  already_ordered <- likelihood_terms %>%
    purrr::map_lgl(~ identical(levels(x), .)) %>%
    any()

  if (already_ordered)
    return(x)

  # terms that only appear in the ipcc terms
  ipcc_characteristic_terms <- likelihood_terms$ipcc[c(1, 2, 5, 8, 9)]
  if (any(ipcc_characteristic_terms %in% x)) {
    factor(x, levels  = likelihood_terms$ipcc)
  }

  statsnz_likelihood_terms <- likelihood_terms[-1]

  new_levels_index <- statsnz_likelihood_terms %>%
    # remove the Indeterminate level for the comparison as it appears everywhere
    purrr::map_lgl(~ any(.[-3] %in% x)) %>%
    which()

  factor(x, levels  = statsnz_likelihood_terms[[new_levels_index]])
}
