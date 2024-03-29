% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datalake.R
\name{get_versions_list}
\alias{get_versions_list}
\title{Get object versions from an aws s3 bucket recursively}
\usage{
get_versions_list(bucket_name, key_marker = "", prefix = "")
}
\arguments{
\item{bucket_name}{Name of the bucket to connect. By default, it uses the
Ministry for the Environment data lake for environmental reporting
"mfedlkinput".}

\item{key_marker}{The key marker from which to download the object metadata.}

\item{prefix}{The prefix from which to download the object metadata.
Empty string download all metadata}
}
\value{
a list with metadata
}
\description{
Get object versions from an aws s3 bucket recursively
}
