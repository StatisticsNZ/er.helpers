#' Makes it easy to get the period for printing or visualisation
#'
#' Usually for plotting or reports one needs to print the range of a datasets.
#' This function prints a nice range of dates or numbers easily
#'
#' @param x,y column with the number/dates/years/etc. If y is NULL the range is
#'   determined by the minimum and maximum value in x. If y is not NULL the
#'   beginning of the range is determined by the minimum of x and the end of the
#'   range by the maximum of y
#' @param sep separator between the range
#'
#' @return a character with the range
#' @export
#'
#' @examples
#'
#' # Range of a numeric vector
#' prettify_range(1:100)
#' # Changing the default separator
#' prettify_range(1:100, sep = " to ")
#' # Range using two numbers
#' prettify_range(1, 100)
#' # When two vectors are provided the minimum of the first and the maximum of the
#' # second is returned
#' tibble::tibble(period_start = 2010:2020,
#'                period_end = 2020:2030) %>%
#'   dplyr::mutate(pretty_range = prettify_range(period_start, period_end))
#' # Also work with dates
#' seq(Sys.Date(), Sys.Date() + 100, length.out = 100) %>%
#'   prettify_range(sep = " and ") %>%
#'   paste("between", .)
#'
prettify_range <- function(x, y = NULL, sep = "\u2013") {

  if (!is.null(y)) {
    period <- c(min(col_as_number(x)),
                max(col_as_number(y)))
  } else {
    period <- col_as_number(x) %>%
      range()
  }

  paste(period, collapse = sep)
}


col_as_number <- function(x){

  if (any(class(x[1]) %in% c("Date", "POSIXct")))
    return(x)

  x %>%
    as.character() %>%
    as.numeric()
}
