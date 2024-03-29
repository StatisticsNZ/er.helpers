% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datalake.R
\name{get_bucket_version_df}
\alias{get_bucket_version_df}
\title{List bucket contents with versions}
\usage{
get_bucket_version_df(bucket_name, key_marker = "", prefix = "")
}
\arguments{
\item{bucket_name}{Name of the bucket to connect. By default, it uses the
Ministry for the Environment data lake for environmental reporting
"mfedlkinput".}
}
\value{
A data frame with metadata about all of the versions of objects in a
  bucket.
}
\description{
Returns metadata about all of the versions of objects in a bucket. This
function is similar to `aws.s3::get_bucket_df` but lists all versions of the
objects. Even if the objects have been previously deleted. If there are more
than 1000 object versions, it makes iterative calls to the AWS S3 API to
retrieve the metadata for all versions
}
\examples{
\dontrun{
get_bucket_version_df()
}

}
