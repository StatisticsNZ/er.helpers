#' Stats NZ plotting theme
#'
#' A ggplot2 theme for standard Stats NZ style plots.
#'
#' @export
stats_theme_plot <-function() {
  ggplot2::theme_classic() +
  ggplot2::theme(
    axis.line.x = ggplot2::element_line(colour = "#CCCCCC"),
    line = ggplot2::element_line(colour = "#CCCCCC"),
    axis.line.y = ggplot2::element_line(colour = "#CCCCCC"),
    panel.grid.major.x = ggplot2::element_line(colour = "#CCCCCC"),
    axis.ticks.x = ggplot2::element_blank(),
    axis.text.y = ggplot2::element_text(family = "Arial"),
    axis.text.x = ggplot2::element_text(family = "Arial"),
    text = ggplot2::element_text(family = "Arial"),
    strip.background = ggplot2::element_blank(),
    plot.caption = ggplot2::element_text(hjust = 0),
    axis.title.x = ggplot2::element_text(
      face = "bold",
      hjust = 0.5
    ),
    axis.title.y = ggplot2::element_text(
      face = "bold",
      hjust = 0.5
    ),
    plot.title.position = "plot",
    plot.title = ggplot2::element_text(
      face = "bold",
      size = 12,
      hjust = 0.5
    )
  )
}
#' Stats NZ map theme
#'
#' A minimal ggplot2 theme for maps styled to Stats NZ conventions.
#'
#' @return A ggplot2 theme object.
#' @export
stats_theme_map <- function() {

  ggplot2::theme_void() +
    ggplot2::theme(
      # Remove facet borders
      strip.background = ggplot2::element_blank(),

      # Plot title
      plot.title = ggplot2::element_text(
        family = "Arial",
        face = "bold",
        size = 12,
        hjust = 0.5
      ),

      # Global text
      text = ggplot2::element_text(
        family = "Arial"
      ),

      # Legend
      legend.title = ggplot2::element_text(
        family = "Arial",
        face = "bold",
        hjust = 0.5
      ),

      legend.text = ggplot2::element_text(
        family = "Arial",
        size = 12
      )
    )
}