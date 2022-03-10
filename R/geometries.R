
#' rearrange_geometries
#'
#' Takes in geometries arranged with with all the lattitudes first and then all the longitudes
#' and returns a series of lattitude and longitude pairs.
#'
#'
#' @param string This is the comma-separated string of lats and corresponding longs (character string expected)
#'
#' @return returns a comma-separated string of lat/long pairs
#' @export
#'
#' @examples
#' geometry <- "c(1,2,3,4,5,6)"
#' rearrange_geometries(geometry)

rearrange_geometries <- function(string) {

  geometry <- gsub("\\(|c|\\)", "", string, perl = TRUE)
  cut <- er.helpers::round2(stringr::str_count(geometry, pattern = ",")/2, 0)
  parts <- strsplit(geometry, ",")
  stars <- paste(purrr::map2(parts[[1]][1:cut],
                             parts[[1]][(cut+1):length(parts[[1]])],
                             ~ paste(.x, .y, sep = ",")), collapse = ",")
}


# to do
# check for uneven numbers of geometries
# check that lats and longs group together (i.e. are lats and longs)
# do the reverse format