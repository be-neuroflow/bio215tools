\name{doubling_time}
\alias{doubling_time}
\title{Population doubling time}
\usage{
doubling_time(r)
}
\arguments{
\item{r}{Positive numeric vector of per-capita growth rates.}
}
\value{A numeric vector with the same length and names as \code{r}.}
\description{Converts positive exponential growth rates to doubling times using \code{log(2) / r}.}
\examples{
doubling_time(0.35)
doubling_time(c(slow = 0.1, fast = 0.5))
}

