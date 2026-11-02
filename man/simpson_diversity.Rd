\name{simpson_diversity}
\alias{simpson_diversity}
\title{Simpson diversity indices}
\usage{
simpson_diversity(
  counts,
  method = c("gini-simpson", "simpson", "inverse"),
  na.rm = FALSE
)
}
\arguments{
\item{counts}{A numeric vector of non-negative counts or abundances.}
\item{method}{Index to return: Gini-Simpson, concentration, or inverse Simpson.}
\item{na.rm}{If \code{TRUE}, remove missing values; otherwise return \code{NA}.}
}
\value{A single numeric value.}
\description{Calculates one of three closely related Simpson diversity indices.}
\examples{
simpson_diversity(c(12, 7, 4, 1))
simpson_diversity(c(12, 7, 4, 1), method = "inverse")
}

