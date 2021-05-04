#' Round preserving sum
#'
#' Round values preserving their sum. Often used to round percentages such that
#' their totals still add to 100%.
#'
#' @param x numeric vector to round
#' @param digits integer indicating the number of decimal places to be used
#'
#' @return a numeric value
#' @importFrom utils tail
#' @export
#'
#' @examples
#' x <- c(10.3, 20.3, 69.4)
#' # These three values add to 100
#' sum(x)
#' # But when rounded they do not add to 100
#' sum(round(x))
#' # Using round_preserve_sum ensures the rounded values add to 100
#' round_preserve_sum(x)
#' sum(round_preserve_sum(x))
round_preserve_sum <- function(x, digits = 0) {
  up <- 10 ^ digits
  x <- x * up
  y <- floor(x)
  indices <- tail(order(x - y), round(sum(x)) - sum(y))
  y[indices] <- y[indices] + 1
  y / up
}
