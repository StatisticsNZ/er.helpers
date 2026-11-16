#' @title Colour palette for a graph with a nominal categorical variable.
#' @description  Colour palette for a graph with a nominal categorical variable.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_snz)
pal_snz <- c("#085c75", "#d2ac2f", "#ae4e51", "#35345d", "#76a93f", "#6f2e38", "#0d94a3", "#dd6829", "#1a6e5b")

#' @title Colour palette for a graph with a continuous variable.
#' @description  Colour palette for a graph with a continuous variable.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_snz)
pal_snz_continuous <- c("#172a45", "#005c75", "#0d94a3","#d0cdbb", "#dd6829", "#b85913")


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



#' @title Colour palette for categorical variables for points on a map etc.
#' @description Colour palette for categorical variables.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_point_set1)
pal_point_set1 <- c("#377EB8", "#A65628", "#F781BF", "#4DAF4A", "#FF7F00", "#984EA3", "#FFFF33", "#E41A1C", "#999999") #from Set1, 9col


#' @title Colour palette for a map of a ordinal categorical trend variable with 3 values.
#' @description Colour palette for a map of a ordinal categorical trend variable with 3 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_point_trend3)
pal_point_trend3 <- c("#4575B4", "#8e8e8e", "#B2182B")

#' @title Colour palette for a map of a ordinal categorical trend variable with 5 values.
#' @description Colour palette for a map of a ordinal categorical trend variable with 5 values.
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_point_trend5)
pal_point_trend5 <- c("#2166AC", "#67A9CF", "#8e8e8e", "#EF6548", "#B2182B")

#' @title Colour palette for a map of continuous diverging pal
#' @description Colour palette for a map of continuous diverging pal for rate of change. Best used in scale_x_gradient...
#' @return A vector of hex codes.
#' @export
#' @examples
#' scales::show_col(pal_point_trend5)
pal_continuous_trend <- c( "#7F0000", "#B2182B", "#D6604D", "#FDB863",
                           "#D9D9D9", "#92C5DE", "#4393C3", "#2166AC", "#053061")

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
