#' Logistic population growth
#'
#' Calculate population size through time under the continuous logistic growth
#' model. The model is
#' `N(t) = K / (1 + ((K - N0) / N0) * exp(-r * t))`.
#'
#' @param time Numeric vector of time points.
#' @param N0 Initial population size. Must be positive.
#' @param K Carrying capacity. Must be positive.
#' @param r Intrinsic per-capita growth rate.
#'
#' @return A numeric vector with the same length and names as `time`.
#' @export
#'
#' @examples
#' logistic_growth(0:8, N0 = 5, K = 100, r = 0.8)
#' plot(0:8, logistic_growth(0:8, 5, 100, 0.8), type = "b")
logistic_growth <- function(time, N0, K, r) {
  validate_finite_numeric(time, "time", scalar = FALSE)
  validate_finite_numeric(N0, "N0", scalar = TRUE)
  validate_finite_numeric(K, "K", scalar = TRUE)
  validate_finite_numeric(r, "r", scalar = TRUE)
  if (N0 <= 0) {
    stop("`N0` must be greater than zero.", call. = FALSE)
  }
  if (K <= 0) {
    stop("`K` must be greater than zero.", call. = FALSE)
  }

  result <- K / (1 + ((K - N0) / N0) * exp(-r * time))
  names(result) <- names(time)
  result
}

#' Population doubling time
#'
#' Convert a positive exponential growth rate into a doubling time using
#' `log(2) / r`.
#'
#' @param r Positive numeric vector of per-capita growth rates.
#'
#' @return A numeric vector with the same length and names as `r`.
#' @export
#'
#' @examples
#' doubling_time(0.35)
#' doubling_time(c(slow = 0.1, fast = 0.5))
doubling_time <- function(r) {
  validate_finite_numeric(r, "r", scalar = FALSE)
  if (any(r <= 0)) {
    stop("Every value in `r` must be greater than zero.", call. = FALSE)
  }

  result <- log(2) / r
  names(result) <- names(r)
  result
}

validate_finite_numeric <- function(x, argument, scalar) {
  if (!is.numeric(x) || length(x) == 0L || anyNA(x) || any(!is.finite(x))) {
    stop(sprintf("`%s` must contain only finite numeric values.", argument),
         call. = FALSE)
  }
  if (scalar && length(x) != 1L) {
    stop(sprintf("`%s` must be a single number.", argument), call. = FALSE)
  }
  invisible(TRUE)
}

