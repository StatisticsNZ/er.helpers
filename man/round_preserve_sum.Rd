% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/round_preserve_sum.R
\name{round_preserve_sum}
\alias{round_preserve_sum}
\title{Round preserving sum}
\usage{
round_preserve_sum(x, digits = 0)
}
\arguments{
\item{x}{numeric vector to round}

\item{digits}{integer indicating the number of decimal places to be used}
}
\value{
a numeric value
}
\description{
Round values preserving their sum. Often used to round percentages such that
their totals still add to 100%.
}
\examples{
x <- c(10.3, 20.3, 69.4)
# These three values add to 100
sum(x)
# But when rounded they do not add to 100
sum(round(x))
# Using round_preserve_sum ensures the rounded values add to 100
round_preserve_sum(x)
sum(round_preserve_sum(x))
}
