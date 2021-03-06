% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datalake.R
\name{write_rds_datalake}
\alias{write_rds_datalake}
\title{Write an RDS file to the lake. .RDS so the attributes can be saved as metadata. Basic attributes are applied below
But you can add your own using attr(). V
The function first writes the file to a temp directory
therefore, it avoids the unintended consequences of saving the file in the
disk.}
\usage{
write_rds_datalake(data, s3_path)
}
\arguments{
\item{data}{an object to write to the lake}

\item{s3_path}{the object path in the lake to save to (this should have the extension .RDS)}
}
\description{
Write an RDS file to the lake. .RDS so the attributes can be saved as metadata. Basic attributes are applied below
But you can add your own using attr(). V
The function first writes the file to a temp directory
therefore, it avoids the unintended consequences of saving the file in the
disk.
}
\examples{
\dontrun{
setup_datalake_access()
read_from_datalake("landcover", "concordance", "lcdb4")
}
}
