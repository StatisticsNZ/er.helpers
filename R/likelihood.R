#' Title
#'
#' @param x
#' @param scale
#' @param term_type
#' @param x_is
#'
#' @return
#' @export
#'
#' @examples
get_likelihood_category <- function(x,
                                    scale = c("statsnz", "ipcc"),
                                    term_type = c("worsening-improving",
                                                  "improving-worsening",
                                                  "increasing-decreasing",
                                                  "likely-unlikely"),
                                    x_is = c("probability", "percentage")) {


  scale <- match.arg(scale)
  term_type <- match.arg(term_type)
  x_is <- match.arg(x_is)

  # determine the desired scale
  scale_frame <- switch(scale,
    statsnz = er.helpers::statsnz_likelihood_scale,
    ipcc = er.helpers::ipcc_likelihood_scale
  )

  terms <- scale_frame$term

  if (scale == "statsnz") {
    terms <- get_likelihood_terms(terms, term_type)
  }

  if (x_is == "percentage") {
    x <- x / 100
  }

  if (all(is.na(x)))
    stop("All values in x are NA")
  if (any(is.na(x)))
    warning("NA values found in x")

  range_x <- range(x, na.rm = TRUE)
  if (!(min(range_x) >= 0 & max(range_x) <= 1))
    stop("x should be between 0 and 1 if is a probabiliy or between 0 and 100 if it's a percentage")

  scale_frame %>%
    split(.$term) %>%
    purrr::map_dfr(~ in_interval(x,
                                 .$left_break, .$right_break,
                                 .$left_open, .$right_open)) %>%
    as.matrix() %>%
    apply(1, which) %>%
    # Recover if x is NA
    purrr::modify_if(~ length(.) == 0, function(x) NA) %>%
    unlist() %>%
    magrittr::extract(terms, .)

}

in_interval <- function(x, lower, upper, left_open, right_open){

  left_compare <- ifelse(left_open, yes = `>`, no = `>=`)
  right_compare <- ifelse(right_open, yes = `<`, no = `<=`)

  left_compare(x, lower) & right_compare(x, upper)

}

get_likelihood_terms <- function(terms, term_type){

  if (term_type == "likely-unlikely") {
    return(terms)
  } else if (term_type == "increasing-decreasing") {
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

order_likelihood_levels <- function(x) {

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
