\name{logistic_growth}
\alias{logistic_growth}
\title{Logistic population growth}
\usage{
logistic_growth(time, N0, K, r)
}
\arguments{
\item{time}{Numeric vector of time points.}
\item{N0}{Positive initial population size.}
\item{K}{Positive carrying capacity.}
\item{r}{Intrinsic per-capita growth rate.}
}
\value{A numeric vector with the same length and names as \code{time}.}
\description{Calculates population size through time under the continuous logistic model.}
\examples{
logistic_growth(0:8, N0 = 5, K = 100, r = 0.8)
plot(0:8, logistic_growth(0:8, 5, 100, 0.8), type = "b")
}

