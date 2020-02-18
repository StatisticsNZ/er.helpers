#' Launch a shiny app in the background
#'
#' @param path Path of the shiny app, defaults to working directory
#' @param port Port to be used for the connection. If NULL uses a randomly
#'   generated port between 1024 and 9999
#'
#' @return
#'
#' The URL of the running app
#'
#' @export
#'
#' @examples
#' \dontrun{
#' launch_shiny_in_backrgound("app/", port = 6589)
#' }
#'
launch_shiny_in_background <- function(path = ".", port = NULL){

  if (is.null(port)) {
    port <- runif(1, min = 1024, max = 9999) %>%
      round()
  }

  path <- paste0("R -e \"shiny::runApp('", path, "', port = ",
                 port,
                 ", host = '127.0.0.1', launch.browser = TRUE)\"")
  message(path)
  url <- rstudioapi::translateLocalUrl(paste0("http://127.0.0.1:", port),
                                       absolute = TRUE)
  message(url)
  system(path, wait = FALSE)

  Sys.sleep(5)

  utils::browseURL(url = url)
}
