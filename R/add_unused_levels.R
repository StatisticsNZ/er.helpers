#' Add a row for each unused factor level to ensure plotly displays all levels in the legend.
#'
#' Add a row for each unused factor level to ensure plotly displays all levels in the legend.
#'
#' @param data A tibble, dataframe or sf object. Required input.
#' @param var A variable of class factor.
#'
#' @return A tibble, dataframe or sf object. Required input.
#' @export
#'
#' @examples
# library(simplevis)
# library(palmerpenguins)
# library(dplyr)
#
# penguins %>%
#   filter(sex == "female") %>%
#   add_unused_levels(sex) %>%
#   tail()
add_unused_levels <- function(data, var) {

  warning("This adds a row for each unused factor level to ensure plotly displays all levels in the legend. It should be used only for input within a ggplotly object.")

  var <- rlang::enquo(var)

  var_vctr <- dplyr::pull(data, !!var)

  unused_levels <- setdiff(levels(var_vctr), unique(var_vctr))

  if(length(unused_levels) != 0) data <- dplyr::bind_rows(data, tibble::tibble(!!var := unused_levels))

  return(data)
}

