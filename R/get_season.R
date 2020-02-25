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