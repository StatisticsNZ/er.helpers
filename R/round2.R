#' Round2
#'
#' @description Round using conventional rounding, where .5 always gets rounded up.
#'
#' @param x vector
#' @param n digits to round to
#'
#' @return
#' @export
#'
#' @examples
#' round2(0.05, 1)
round2 <- function(x, n) {

  posneg = sign(x)
  z = abs(x) * 10 ^ n
  z = z + 0.5 + sqrt(.Machine$double.eps)
  z = trunc(z)
  z = z/10^n
  z * posneg

}
