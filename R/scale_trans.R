#' @title Signed square root ggplot scale transformation.
#' @description A signed square root ggplot scale transformation. This is useful for where there is negative values.
#' @return A ggplot scale transformation.
#' @export
signed_sqrt_trans <- function()
  scales::trans_new(
    name = "signed_sqrt",
    transform = function(x) {
      sign(x) * sqrt(abs(x))
    },
    inverse = function(x) {
      x ^ 2 * sign(x)
    }
  )
