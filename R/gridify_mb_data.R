#' #' @title Gridify meshblock data
#' #'
#' #' @description Converts meshblock data, a meshblock sf object and a grid sf object to grid sf object with density.
#' #'
#' #' @param data A dataframe of meshblock level data. Required input.
#' #' @param data_id_var An unquoted variable of the the meshblock id of the meshblock data. Required input.
#' #' @param data_vars_vctr A quoted character vector of the meshblock columns that you want to gridify. Required input.
#' #' @param shp A sf object of the meshblock level shapes. Note for APS data, use a shp year after the APS year for a better join. Required input.
#' #' @param shp_id_var An unquoted variable of the the meshblock id of the meshblock shapes.  Required input.
#' #' @param grid A sf object of a grid. E.g. er.helpers::nz_grid_hex_346. Required input.
#' #'
#' #' @return A sf object with estimated grid totals and densities for the var in the input data.
#' #' @export
#' #'
#' #' @examples
#' #' \dontrun{
#' #' agdir <- "~/Network-Shares/U-Drive-SAS-03BAU/IndLabr/Bus Infra & Performance/Agriculture/Ag_Secure/"
#' #' data <- haven::read_sas(paste0(agdir, "2017/all_linecodes_perturbed_final.sas7bdat"))
#' #'
#' #' data <- data %>%
#' #'   select(id = CAR_Meshblock,
#' #'          dairy = APS_TotDairy,
#' #'          beef = APS_TotBeef)
#' #'
#' #' shp <- get_feature_class("MB2018_V1_00",  epsg = 2193)
#' #'
#' #' shp <- shp %>%
#' #'   select(id = mb2018_v1_00)
#' #'
#' #' grid <- er.helpers::nz_grid_hex_346
#' #'
#' #' aps_grid_17 <- gridify_mb_data(data = data,
#' #'                                data_id_var = id,
#' #'                                data_vars_vctr = c("dairy", "beef"),
#' #'                                shp = shp,
#' #'                                shp_id_var = id,
#' #'                              grid = er.helpers::nz_grid_hex_346)
#' #'
#' #' leaflet_sf_col(aps_grid_17, dairy_density_per_km2, title = "Dairy density, 2017")
#' #' leaflet_sf_col(aps_grid_17, beef_density_per_km2, title = "Beef density, 2017")
#' #' }
#' gridify_mb_data <- function(data,
#'                             data_id_var,
#'                             data_vars_vctr,
#'                             shp,
#'                             shp_id_var,
#'                             grid) {
#'
#'   data_id_var <- rlang::enquo(data_id_var)
#'   shp_id_var <- rlang::enquo(shp_id_var)
#'
#'   shp_area <- shp %>%
#'     dplyr::select(!!shp_id_var) %>%
#'     sf::st_sf() %>%
#'     sf::st_cast("MULTIPOLYGON") %>%
#'     sf::st_make_valid() %>%
#'     dplyr::mutate(shp_area_m2 = as.numeric(sf::st_area(.)))
#'
#'   grid <- grid  %>%
#'     dplyr::mutate(grid_id = row_number()) %>%
#'     dplyr::mutate(grid_area_m2 = as.numeric(sf::st_area(.)))
#'
#'   shp_grid <- grid %>%
#'     sf::st_intersection(shp_area) %>%
#'     sf::st_sf() %>%
#'     sf::st_cast("MULTIPOLYGON") %>%
#'     sf::st_make_valid() %>%
#'     dplyr::mutate(area_m2 = as.numeric(sf::st_area(.))) %>%
#'     dplyr::mutate(prop_of_shp = area_m2 / shp_area_m2)
#'
#'   data_shp_grid <- data %>%
#'     dplyr::select(!!data_id_var, data_vars_vctr) %>%
#'     dplyr::filter(dplyr::across(c(data_vars_vctr), ~(. != "."))) %>% #remove any with no ids
#'     dplyr::rename(!!shp_id_var := !!data_id_var) %>%
#'     dplyr::right_join(shp_grid) %>%
#'     dplyr::mutate(dplyr::across(c(data_vars_vctr), ~ifelse(is.na(.), 0, .))) %>%  #convert NAs to 0's
#'     dplyr::mutate(dplyr::across(c(data_vars_vctr), ~(. * prop_of_shp))) %>%
#'     sf::st_sf() %>%
#'     sf::st_cast("MULTIPOLYGON") %>%
#'     sf::st_make_valid()
#'
#'   data_grid <- data_shp_grid %>%
#'     dplyr::group_by(grid_id, grid_area_m2) %>%
#'     dplyr::summarise(dplyr::across(c(data_vars_vctr), ~sum(.), .names = "grid_{.col}")) %>%
#'     dplyr::mutate(grid_area_ha = grid_area_m2 * 0.0001) %>%
#'     dplyr::mutate(grid_area_km2 = grid_area_m2 * 0.000001) %>%
#'     dplyr::mutate(dplyr::across(tidyselect::contains(data_vars_vctr) & tidyselect::contains("grid_"), ~(. / grid_area_ha), .names = "{.col}_density_per_ha")) %>%
#'     dplyr::mutate(dplyr::across(tidyselect::contains(data_vars_vctr) & tidyselect::contains("grid_") & !tidyselect::contains("_density_per_ha"), ~(. / grid_area_km2), .names = "{.col}_density_per_km2")) %>%
#'     dplyr::rename_with(~stringr::str_replace_all(., "grid_", ""), starts_with("grid_")) %>%
#'     dplyr::ungroup() %>%
#'     sf::st_sf() %>%
#'     sf::st_cast("MULTIPOLYGON") %>%
#'     sf::st_make_valid()
#'
#'   return(data_grid)
#' }
