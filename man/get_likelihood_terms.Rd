% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/likelihood.R
\name{get_likelihood_terms}
\alias{get_likelihood_terms}
\title{Translate likely-unlikely to a specified term scale}
\usage{
get_likelihood_terms(terms, term_type = c("worsening-improving",
  "improving-worsening", "increasing-decreasing", "likely-unlikely"))
}
\arguments{
\item{terms}{terms to translate}

\item{term_type}{when \code{scale = "statsnz"} it allows to modify the terms
depending on what the probability \code{p} indicates. \code{term_type =
"worsening-improving"} indicates that a large \code{p} corresponds to a
worsening trend; this is the default. \code{term_type =
"improving-worsening"} indicates that a large \code{p} corresponds to an
improving trend. \code{term_type = "increasing-decreasing"} indicates that
the output should range from "Very likely increasing" to "Very likely
decreasing". \code{term_type = "likely-unlikely"} indicates that the output
should range from "Very likely" to "Very unlikely".}
}
\value{
a factor
}
\description{
Translate likely-unlikely to a specified term scale
}
