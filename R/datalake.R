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
#'
#' setup_datalake_access(cred_csv = "~/credentials.csv", bucket_name = "mfedlkinput")
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
#' @param s3_path The filename of the desired CSV in the S3 bucket including
#'   the full path
#' @inheritParams setup_datalake_access
#' @param ... Other arguments passed to the reading_function
#'
#' @return A `\code{tibble()}
#'
#' @export
#'
#' @examples
#'
#' setup_datalake_access()
#' csv_object_path <- "freshwater/2020/raw/urban_stream_water_quality_state.csv"
#' read_csv_datalake(csv_object_path)
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
                              headers = list(`versionId` = version))
  }


  connection <- rawConnection(obj)
  # Make sure the connection is clossed on exit
  on.exit(close(connection))
  readr::read_csv(file = connection, ...)
}



#' Write a CSV file stored in an AWS S3 bucket.
#'
#' @param x A data frame to write to the bucket
#' @inheritParams read_csv_datalake
#'
#' @return
#'
#' @export
#'
#' @examples
#' setup_datalake_access()
#' csv_object_path <- "freshwater/2020/raw/urban_stream_water_quality_state.csv"
#' write_csv_datalake(iris, csv_object_path)
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
#' x <- tibble::tible(notSnakecase = 1:10)
#' all_columns_to_snakecase(x)
all_columns_to_snakecase <- function(x){
  new_names <- names(x) %>%
    snakecase::to_snake_case(string = .)
  magrittr::set_colnames(x, new_names)
}


#' Check if aws credentials have been configured and attempt default configuration otherwise
#'
#' @return
#'
check_aws_access <- function() {
  aws_credentials_configured <- c("AWS_ACCESS_KEY_ID",
                                  "AWS_SECRET_ACCESS_KEY",
                                  "AWS_DEFAULT_REGION") %>%
    Sys.getenv() %>%
    magrittr::equals("") %>%
    any()

  if (!aws_credentials_configured) {
    warning("AWS credentials not configured, attempting setup with `setup_datalake_access()` using default settings. Setup access manually if requested action fails.")
    setup_datalake_access()
  }
}
