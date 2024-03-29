#' @title Colour palette for a graph with a nominal categorical variable.
#' @description  Colour palette for a graph with a nominal categorical variable.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_snz)
pal_snz <- c("#085c75", "#d2ac2f", "#ae4e51", "#35345d", "#76a93f", "#6f2e38", "#0d94a3", "#dd6829", "#1a6e5b")

#' @title Colour palette for a graph that compares a current year to 1 past year.
#' @description  Colour palette for a graph that compares a current year to 1 past year.
#' @return A vector of hex codes. Uses the first colour and a 30% tint.
#' @export
#' @examples
#' scales::show_col(pal_snz_alpha2)
pal_snz_alpha2 <- c("#B4CED5", "#085c75")

#' @title Colour palette for a graph of a ordinal categorical trend variable with 2 values.
#' @description  Colour palette for a graph of a ordinal categorical trend variable with 2 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_snz_trend2)
pal_snz_trend2 <- c("#AE4E51", "#0D94A3")

#' @title Colour palette for a graph of a ordinal categorical trend variable with 3 values.
#' @description  Colour palette for a graph of a ordinal categorical trend variable with 3 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_snz_trend3)
pal_snz_trend3 <- c("#0D94A3", "#C4C4C7", "#AE4E51")

#' @title Colour palette for a graph of a ordinal categorical trend variable with 5 values.
#' @description  Colour palette for a graph of a ordinal categorical trend variable with 5 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_snz_trend5)
pal_snz_trend5 <- c("#35345D", "#0D94A3", "#C4C4C7", "#AE4E51", "#6F2E38")

#' @title Colour palette for a NZTCS category graph.
#' @description Colour palette for a NZTCS category graph.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_snz_nztcs_c)
pal_snz_nztcs_c <- c("Threatened" = "#6f2e38", "At risk of becoming threatened" = "#ae4e51", "Data deficient" = "#c4c4c7", "Not threatened" = "#0d94a3")

#' @title Colour palette for a NZTCS subcategory graph.
#' @description A colour palette used for depicting subcategories in the NZ conservation threat status.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_snz_nztcs_s)
pal_snz_nztcs_s <- c(
  "Nationally critical" = "#6f2e38", "Nationally endangered" = "#813641", "Nationally vulnerable" = "#933d4a",
  "Declining" = "#ae4e51", "Recovering" = "#b75e61", "Relict" = "#bf7073", "Naturally uncommon" = "#c78284",
  "Data deficient" = "#c4c4c7", "Not threatened" = "#0d94a3"
)

#' @title  Colour palette for a graph with a nominal categorical variable.
#' @description Colour palette for a graph with a nominal categorical variable.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_ea19)
pal_ea19 <- c("#172a45", "#00b2c3", "#c04124", "#005c75", "#a2c62b", "#702e01", "#ff590d", "#c4c4c7", "#007f39")

#' @title Colour palette for a graph that compares a current year to 1 past year.
#' @description  Colour palette for a graph that compares a current year to 1 past year.
#' @return A vector of hex codes. Uses the first colour and a 40% tint.
#' @export
#' @examples
#' scales::show_col(pal_ea19_alpha2)
pal_ea19_alpha2 <- c("#a2a9b4", "#172a45")

#' @title Colour palette for a graph of a ordinal categorical trend variable with 2 values.
#' @description  Colour palette for a graph of a ordinal categorical trend variable with 2 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_ea19_trend2)
pal_ea19_trend2 <- c("#00b2c3", "#c04124")

#' @title Colour palette for a graph of a ordinal categorical trend variable with 3 values.
#' @description  Colour palette for a graph of a ordinal categorical trend variable with 3 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_ea19_trend3)
pal_ea19_trend3 <- c("#00b2c3", "#c4c4c7", "#c04124")

#' @title Colour palette for a graph of a ordinal categorical trend variable with 5 values.
#' @description  Colour palette for a graph of a ordinal categorical trend variable with 5 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_ea19_trend5)
pal_ea19_trend5 <- c("#172a45", "#00b2c3", "#c4c4c7", "#c04124", "#702e01")

#' @title Colour palette for a NZTCS category graph.
#' @description A colour palette used for depicting categories in the NZ conservation threat status.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_ea19_nztcs_c)
pal_ea19_nztcs_c <- c("Threatened" = "#702e01", "At risk" = "#c04124", "Data deficient" = "#c4c4c7", "Not threatened" = "#00b2c3")

#' @title Colour palette for categorical variables for points on a map etc.
#' @description Colour palette for categorical variables.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_point_set1)
pal_point_set1 <- c("#377EB8", "#A65628", "#F781BF", "#4DAF4A", "#FF7F00", "#984EA3", "#FFFF33", "#E41A1C", "#999999") #from Set1, 9col

#' @title Colour palette for a map of a ordinal categorical trend variable with 2 values.
#' @description Colour palette for a map of a ordinal categorical trend variable with 2 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_point_trend2)
pal_point_trend2 <- c("#4575B4", "#D73027")

#' @title Colour palette for a map of a ordinal categorical trend variable with 3 values.
#' @description Colour palette for a map of a ordinal categorical trend variable with 3 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_point_trend3)
pal_point_trend3 <- c("#4575B4", "#8e8e8e", "#D73027")

#' @title Colour palette for a map of a ordinal categorical trend variable with 5 values.
#' @description Colour palette for a map of a ordinal categorical trend variable with 5 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_point_trend5)
pal_point_trend5 <- c("#4575B4", "#90C3DD", "#8e8e8e", "#F98E52", "#D73027")

#' @title Signed square root ggplot scale transformation.
#' @description A signed square root ggplot scale transformation.
#' @return A ggplot scale transformation function.
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
