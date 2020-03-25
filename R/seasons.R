#' Get the season of a date-time
#'
#' Gets the metereological season of a date or date-time object. Days in
#' December belong to the summer of the next year. For example December 24, 2010
#' belongs to summer 2011.
#'
#' @inheritParams lubridate::quarter
#' @param with_year logical indicating whether or not to include the season's year/
#'
#' @return a string with the season or the year and the season
#' @export
#'
#' @examples
#'  x <- lubridate::ymd("2010-01-15") + seq(0, 365*2, length.out = 25)
#'  get_season(x, with_year = TRUE)
#'  get_season(x, with_year = FALSE)
get_season <- function(x, with_year = TRUE){


  x %>%
    lubridate::quarter(with_year, fiscal_start = 0) %>%
    stringr::str_replace_all(pattern = c("1$" = "summer",
                                         "2$" = "autumn",
                                         "3$" = "winter",
                                         "4$" = "spring"))
}

#' Order season levels
#'
#' Standardise season as a factor with ordered seasons. If an "annual" category
#' is present it includes at the end of the other seasons. Season names are
#' converted to sentence case
#'
#' @param x character vector. If a factor will be coerced to character first
#'
#' @return a factor with ordered levels for season
#' @export
#'
#' @examples
#' library(ggplot2)
#' library(tibble)
#' seasons <- tribble(
#'   ~ season, ~n,
#'   "autum", 1,
#'   "summer", 2,
#'   "winter", 3,
#'   "spring", 1,
#'   "annual", 2)
#' # unordered ugly plot
#' qplot(season, n, fill = season, data = seasons, geom = "col")
#'
#' ordered_seasons <- dplyr::mutate(seasons,
#'                                 season = order_season_levels(season))
#' # nice ordered plot
#' qplot(season, n, fill = season, data = ordered_seasons, geom = "col")
#'
order_season_levels <- function(x){
  ordered_seasons <- c("Spring", "Summer", "Autumn", "Winter", "Annual")

  standard_x <- standardise_season(x)

  original_categories <- unique(standard_x)
  original_in_standard <- original_categories %in% ordered_seasons
  if (any(!original_in_standard)) {
    warning(paste(original_categories[which(!original_in_standard)],
                  collapse = ", "), " not recognised as valid season name(s)")
  }

  if (any(grepl("annual", x, ignore.case = TRUE))) {
    factor(standard_x, ordered_seasons)
  } else {
    factor(standard_x, ordered_seasons[-5])
  }

}

#' Standarise season names
#'
#' @param x non-standard season names
#'
standardise_season <- function(x){
  x %>%
    tolower() %>%
    snakecase::to_sentence_case()
}
