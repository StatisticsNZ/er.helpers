#' round
#'
#' A function used to round numbers using the IEC 60559 standard. base::round doesn't always behave in this manner
#' (see help round for more information). This function is designed to mask base::round.
#'
#' @param x metric. A vector
#' @param digits an integer indicating the number of decimal places to be used.
#'
#' @return a vector rounded to the digits specified.
#' @export
#'

round <- function(x, digits){

    multiplication <- 10 ^ digits

    base::round(x * multiplication, 0)/multiplication

  }
