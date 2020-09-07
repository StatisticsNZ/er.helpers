#' @title Gridify meshblock data
#'
#' @description Converts meshblock data, a meshblock sf object and a grid sf object to grid sf object with density.
#'
#' @param data A data object with meshblock id variable called id and 1 numeric linecode variable called var. Required input.
#' @param shp A sf object of the meshblock shapes with meshblock id variable called id. Use the year after the APS year for a better join. Required input.
#' @param grid A sf object of a grid. E.g. er.helpers::nz_grid_hex_346. Required input.
#'
#' @return A sf object with estimated grid totals and densities for the var in the input data.
#' @export
#'
#' @examples
#' \dontrun{
#' library(dplyr)
#' library(sf)
#' library(simplevis)
#' library(GMS)
#'
#' agdir <- "~/Network-Shares/U-Drive-SAS-03BAU/IndLabr/Bus Infra & Performance/Agriculture/Ag_Secure/"
#'
#' data <- haven::read_sas(paste0(agdir, "2017/all_linecodes_perturbed_final.sas7bdat")) %>%
#'   select(id = CAR_Meshblock, var = APS_Val_IrriTotArea) #data with cols id and var
#'
#' shp <- get_feature_class("MB2018_V1_00",  epsg = 2193) %>%
#'   select(id = mb2018_v1_00)  #shp with col id
#'
#' grid_irrigated_land_17 <- gridify_mb_data(
#'   data = data,
#'   shp = shp,
#'   grid = er.helpers::nz_grid_hex_346)
#'
#' leaflet_sf_col(grid_irrigated_land_17,
#'                grid_density_per_km2,
#'                col_method = "bin", col_cuts = c(0, 3, 15, 30, 45, 60, Inf))
#' }
gridify_mb_data <- function(data, shp, grid) {

  shp <- shp %>%
    sf::st_sf() %>%
    sf::st_cast("MULTIPOLYGON") %>%
    sf::st_make_valid() %>%
    dplyr::mutate(shp_area_m2 = as.numeric(sf::st_area(.))) #grid with col grid_id and grid_area_m2

  grid <- grid  %>%
    dplyr::mutate(grid_id = row_number()) %>%
    dplyr::mutate(grid_area_m2 = as.numeric(sf::st_area(.))) #grid with col grid_id and grid_area_m2

  shp_grid <- grid %>%
    sf::st_intersection(shp) %>%
    sf::st_sf() %>%
    sf::st_cast("MULTIPOLYGON") %>%
    sf::st_make_valid() %>%
    dplyr::mutate(area_m2 = as.numeric(sf::st_area(.))) %>%
    dplyr::mutate(prop_of_shp = area_m2 / shp_area_m2)

  data_shp_grid <- data %>%
    dplyr::filter(!is.na(var)) %>%
    dplyr::right_join(shp_grid, by = "id") %>%
    dplyr::mutate(var = ifelse(is.na(var), 0, var)) %>%  #convert NAs to 0's
    dplyr::mutate(var = var * prop_of_shp) %>%
    sf::st_sf() %>%
    sf::st_cast("MULTIPOLYGON") %>%
    sf::st_make_valid()

  data_grid <- data_shp_grid %>%
    dplyr::group_by(grid_id, grid_area_m2) %>%
    dplyr::summarise(grid_total = sum(var)) %>%
    dplyr::mutate(grid_area_ha = grid_area_m2 * 0.0001) %>%
    dplyr::mutate(grid_area_km2 = grid_area_m2 * 0.000001) %>%
    dplyr::mutate(grid_density_per_ha = grid_total / grid_area_ha) %>%
    dplyr::mutate(grid_density_per_km2 = grid_total / grid_area_km2) %>%
    sf::st_sf() %>%
    sf::st_cast("MULTIPOLYGON") %>%
    sf::st_make_valid()

  return(data_grid)
}
