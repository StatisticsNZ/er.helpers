#' @title Prepare data to be input into the networkD3 sankeyNetwork function.
#' @description Prepare data to be input into the networkD3 sankeyNetwork function.
#' @param data A tibble or dataframe with all categorical columns apart from the final column, which is numeric. Required input.
#' @param colour_data A tibble or dataframe with variable 1 called name containing relevant categorical values and variable 2 called colour and containing hex codes (or colour names). Required input.
#' @return A vector of labels.
#' @export
#' @examples
#' library(dplyr)
#'
#' plot_data <- tibble::tribble(
#' ~state1, ~state2, ~value,
#' "Trees", "Grass", 5,
#' "Trees", "Wetland", 1,
#' "Grass", "Trees", 7,
#' "Grass", "Wetland", 1,
#' "Wetland", "Trees", 1,
#' "Wetland", "Grass", 2)
#'
#' pal_data <- tibble::tribble(
#'   ~name, ~colour,
#'   "Trees", "purple",
#'   "Grass", "green",
#'   "Wetland", "brown")
#'
#' sankey_data <- sankey_build_data(
#'   data = plot_data,
#'   colour_data = pal_data)
#'
#' units <- "ha"
#'
#' networkD3::sankeyNetwork(Links = sankey_data$links, Nodes = sankey_data$nodes,
#'                          Source = "source_id", Target = "target_id", Value = "value",
#'                          NodeID = "name", colourScale = sankey_data$colour_scale,
#'                          fontSize = 14, fontFamily = "Arial", units = units)
sankey_build_data <- function(data, colour_data) {

  space_char <- ' '

  data <- data %>%
    dplyr::mutate_if(is.character, ~(stringr::str_replace_all(., " ", space_char)))

  colour_data <- colour_data %>%
    dplyr::mutate_if(is.character, ~(stringr::str_replace_all(., " ", space_char)))

  gather_cols <- names(data)[1:(ncol(data) - 1)]
  value_col <- names(data)[ncol(data)]

  node_data <- data %>%
    dplyr::select(dplyr::one_of(gather_cols)) %>%
    tidyr::gather(dplyr::one_of(gather_cols), key = 'variable', value = 'name') %>%
    dplyr::distinct() %>%
    dplyr::mutate(id = as.numeric(factor(paste(variable, name, sep = "//"))) - 1) %>%
    dplyr::arrange(id)

  link_list <- lapply(1:(ncol(data) - 2), function(i) {
    link_cols   <- names(data)[c(i, i + 1, ncol(data))]
    source <- link_cols[1]
    target <- link_cols[2]
    value  <- link_cols[3]
    res <- data[, link_cols]
    names(res) <- c('source', 'target', 'value')

    res <- res %>%
      dplyr::group_by(source, target) %>%
      dplyr::summarise(value = sum(value)) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(source_var = link_cols[1],
             target_var = link_cols[2])

    return(res)
  })

  link_data <- link_list %>%
    dplyr::bind_rows() %>%
    dplyr::inner_join(node_data, by = c("source_var" = "variable", "source" = "name")) %>%
    dplyr::rename(source_id = id) %>%
    dplyr::inner_join(node_data, by = c("target_var" = "variable", "target" = "name")) %>%
    dplyr::rename(target_id = id) %>%
    dplyr::select(source_var, target_var, source, target, source_id, target_id, value) %>%
    dplyr::mutate(source_id = as.integer(source_id),
           target_id = as.integer(target_id)) %>%
    as.data.frame()

  node_data <- node_data %>%
    dplyr::mutate(name = factor(name)) %>%
    dplyr::left_join(colour_data, by = c('name')) %>%
    as.data.frame()

  build_d3_palette <- function(names, colours) {
    if (length(names) != length(colours)) {
      stop("Names and colours lengths do not match")
    }
    name_list    <- jsonlite::toJSON(names)
    palette_list <- jsonlite::toJSON(colours)
    palette_text <- paste0('d3.scaleOrdinal()',
                           '.domain(', name_list,   ')',
                           '.range(', palette_list, ");")
    return(palette_text)
  }

  colour_scale <- build_d3_palette(node_data$name, node_data$colour)

  res <- list(nodes = node_data, links = link_data, colour_scale = networkD3::JS(colour_scale))

  return(res)
}
