\name{hardy_weinberg_test}
\alias{hardy_weinberg_test}
\title{Chi-squared test for Hardy-Weinberg equilibrium}
\usage{
hardy_weinberg_test(counts, p = NULL)
}
\arguments{
\item{counts}{Three non-negative integer genotype counts, ordered \code{AA}, \code{Aa}, \code{aa}.}
\item{p}{Optional frequency of allele \code{A}; if omitted, it is estimated.}
}
\value{An object of class \code{"htest"}, including observed and expected counts.}
\description{Compares observed genotype counts with those expected under Hardy-Weinberg equilibrium.}
\examples{
hardy_weinberg_test(c(AA = 25, Aa = 50, aa = 25))
hardy_weinberg_test(c(30, 40, 30), p = 0.5)
}

