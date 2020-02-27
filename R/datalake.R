#' MfE Default bucket
#'
#' @export
mfe_datalake_bucket <- "mfedlkinput"

#' Set up access to the data lake programatically.
#'
#' This function set ups the credentials required to access an AWS S3 bucket
#' programatically. By default it connects to the Environmental Reporting Data
#' Lake.
#'
#' @param cred_csv A csv file with the credentials information. At a minimum it
#'   should have two columns: "Access key ID" and "Secret access key". By
#'   default \code{setup_datalake_access} looks for this file in the user
#'   directory "~/credentials.csv".
#' @param bucket_name Name of the bucket to connect. By default, it uses the
#'   Ministry for the Environment data lake for environmental reporting
#'   "mfedlkinput".
#'
#' @export
#'
#' @examples
#' \dontrun{
#' setup_datalake_access(cred_csv = "~/credentials.csv", bucket_name = "mfedlkinput")
#' }
setup_datalake_access <- function(cred_csv = "~/credentials.csv",
                                  bucket_name = mfe_datalake_bucket){

  creds <- readr::read_csv(cred_csv, col_types = "ccccc")
  Sys.setenv(AWS_ACCESS_KEY_ID = creds["Access key ID"],
             AWS_SECRET_ACCESS_KEY = creds["Secret access key"],
             AWS_DEFAULT_REGION = "ap-southeast-2")
}


#' Read a CSV file stored in an AWS S3 bucket.
#'
#' This function get the specified object from an AWS S3 bucket and reads it
#' using \code{readr::read_csv()}. It keeps the CSV in memory and, therefore, it
#' avoids the unintended consequences of saving the file in the disk.
#'
#' @param s3_path The filename of the desired CSV in the S3 bucket including the
#'   full path
#' @inheritParams setup_datalake_access
#' @param version VersionId of the object key desired. Can be retrieved using
#'   \code{\link{get_bucket_version_df}}
#' @param ... Other arguments passed to the reading_function
#'
#' @return A `\code{tibble()}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' setup_datalake_access()
#' csv_object_path <- "freshwater/2020/raw/urban_stream_water_quality_state.csv"
#' read_csv_datalake(csv_object_path)
#' }
read_csv_datalake <- function(s3_path,
                              bucket_name = mfe_datalake_bucket,
                              version = NULL, ...){

  check_aws_access()

  if (is.null(version)) {
    obj <- aws.s3::get_object(object = s3_path,
                              bucket = bucket_name)
  } else {
    obj <- aws.s3::get_object(object = s3_path,
                              bucket = bucket_name,
                              query = list(`versionId` = version))
  }

  connection <- rawConnection(obj)
  # Make sure the connection is clossed on exit
  on.exit(close(connection))

  data <- readr::read_csv(file = connection, ...)

  if (names(data)[1] == "X1") {
    data %>%
      dplyr::select(-"X1")
  } else {
    data
  }
}


#' Write a CSV file as an object in an AWS S3 bucket.
#'
#' @param x A data frame to write to the bucket
#' @inheritParams read_csv_datalake
#'
#' @return TRUE if it succeeded and FALSE if it failed
#'
#' @export
#'
#' @examples
#' \dontrun{
#' setup_datalake_access()
#' csv_object_path <- "freshwater/2020/raw/urban_stream_water_quality_state.csv"
#' write_csv_datalake(iris, csv_object_path)
#' }
write_csv_datalake <- function(x,
                               s3_path,
                               bucket_name = mfe_datalake_bucket,
                               ...){

  check_aws_access()

  # Make sure the connection is clossed on exit
  connection <- rawConnection(raw(0), "w")
  on.exit(unlink(connection))

  readr::write_csv(x, connection, ...)
  aws.s3::put_object(rawConnectionValue(connection),
                     object = s3_path,
                     bucket = bucket_name)

}


#' Make all columns of a data frame snakecase.
#'
#' This function modifies the input data frame such that the names of every
#' column are in snake case. Internally, it uses the
#' \code{snakecase::to_snake_case}.
#'
#' @param x The input data frame.
#'
#' @export
#'
#' @examples
#' x <- data.frame(notSnakecase = 1:10)
#' all_columns_to_snakecase(x)
all_columns_to_snakecase <- function(x){
  new_names <-  snakecase::to_snake_case(names(x))
  magrittr::set_colnames(x, new_names)
}


#' Check if aws credentials have been configured and attempt default configuration otherwise
#'
check_aws_access <- function() {
  aws_credentials_configured <- c("AWS_ACCESS_KEY_ID",
                                  "AWS_SECRET_ACCESS_KEY",
                                  "AWS_DEFAULT_REGION") %>%
    Sys.getenv() %>%
    magrittr::equals("") %>%
    magrittr::not() %>%
    any()

  if (!aws_credentials_configured) {
    warning("AWS credentials not configured
Attempting setup with `setup_datalake_access()` and default settings
You need to setup access manually if this function fails.")
    setup_datalake_access()
  }
}


#' List bucket contents with versions
#'
#' Returns metadata about all of the versions of objects in a bucket. This
#' function is similar to `aws.s3::get_bucket_df` but lists all versions of the
#' objects. Even if the objects have been previously deleted. If there are more
#' than 1000 object versions, it makes iterative calls to the AWS S3 API to
#' retrieve the metadata for all versions
#'
#' @inheritParams setup_datalake_access
#'
#' @return A data frame with metadata about all of the versions of objects in a
#'   bucket.
#' @export
#'
#' @examples
#' \dontrun{
#' get_bucket_version_df()
#' }
#'
get_bucket_version_df <- function(bucket_name = mfe_datalake_bucket){

  check_aws_access()
  get_versions_list(bucket_name) %>%
    purrr::map(version_list_as_df) %>%
    dplyr::bind_rows()
}

#' Get object versions from an aws s3 bucket recursively
#'
#' @inheritParams setup_datalake_access
#' @param key_marker The key marker from which to download the object metadata.
#'   Empty string download all metadata
#'
#' @return a list with metadata
get_versions_list <- function(bucket_name, key_marker = ""){
  versions <- aws.s3::s3HTTP(verb = "GET",
                             bucket = bucket_name,
                             query = list(versions = "",
                                          "key-marker" = key_marker))

  out <- list()
  out[[1]] <- versions

  if (versions$IsTruncated) {
    more_versions <- get_versions_list(bucket_name, versions$NextKeyMarker)
    return(c(out, more_versions))
  } else {
    return(out)
  }
}


#' Coverts list with object version metadata to a data frame
#'
#' @param versions list item as returned by `get_versions_list`
#'
#' @return A data frame
version_list_as_df <- function(versions){

  suppressWarnings({
    versions %>%
      purrr::keep(function(x) length(x) > 1) %>%
      purrr::imap(function(x, i) dplyr::mutate(as.data.frame(x), marker = i)) %>%
      dplyr::bind_rows()
  })
}


#' Search for keys in the data lake
#'
#' Returns metadata about objects in a bucket. This function is a wrapper to
#' `aws.s3::get_bucket_df` but filters out the desired Keys. If there are more
#' than 1000 objects, it makes iterative calls to the AWS S3 API to retrieve the
#' metadata for all versions. If pattern is a character string, it ignores
#' wether is lower or upper case
#'
#' @inheritParams setup_datalake_access
#' @inheritParams stringr::str_detect
#'
#' @return a data frame with metadata for selected objects
#' @export
#'
#' @examples
#'  \dontrun{
#' search_data_lake("temperature")
#' # search matches for temperature OR lake
#' search_data_lake(c("temperature", "lake"))
#' # search using regex
#' search_data_lake(stringr::regex("^a"))
#' }
search_data_lake <- function(pattern = "", bucket_name = mfe_datalake_bucket){

  check_aws_access()
  all_keys <- aws.s3::get_bucket_df(bucket = bucket_name)

  # If the pattern is a plain character then ignore case as this is ussually
  # what we want
  if (is.null(attr(pattern, "class"))) {
    pattern <- pattern %>%
      purrr::map(stringr::coll, ignore_case = TRUE)
  }

  if (any(pattern == "")) {
    return(all_keys)
  }

  pattern %>%
    purrr::map_dfr(~ dplyr::filter(all_keys, stringr::str_detect(Key, .)))
}
