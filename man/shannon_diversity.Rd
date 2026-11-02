\name{shannon_diversity}
\alias{shannon_diversity}
\title{Shannon diversity index}
\usage{
shannon_diversity(counts, base = exp(1), na.rm = FALSE)
}
\arguments{
\item{counts}{A numeric vector of non-negative counts or abundances.}
\item{base}{Logarithm base. The default, \code{exp(1)}, returns nats.}
\item{na.rm}{If \code{TRUE}, remove missing values; otherwise return \code{NA}.}
}
\value{A single numeric value.}
\description{Calculates Shannon's diversity index from taxon counts or abundances.}
\examples{
shannon_diversity(c(12, 7, 4, 1))
shannon_diversity(c(12, 7, 4, 1), base = 2)
}

