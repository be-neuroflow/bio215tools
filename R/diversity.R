#' Shannon diversity index
#'
#' Calculate Shannon's diversity index from a vector of taxon counts or
#' abundances. Zero-count taxa are omitted from the logarithmic sum.
#'
#' @param counts A numeric vector of non-negative counts or abundances.
#' @param base Logarithm base. The default, [exp(1)], returns the index in nats.
#' @param na.rm Logical. If `TRUE`, missing values are removed; otherwise a
#'   missing value produces `NA`.
#'
#' @return A single numeric value.
#' @export
#'
#' @examples
#' shannon_diversity(c(12, 7, 4, 1))
#' shannon_diversity(c(12, 7, 4, 1), base = 2)
shannon_diversity <- function(counts, base = exp(1), na.rm = FALSE) {
  counts <- validate_counts(counts, na.rm = na.rm)
  if (length(counts) == 1L && is.na(counts)) {
    return(NA_real_)
  }
  if (!is.numeric(base) || length(base) != 1L || is.na(base) ||
      !is.finite(base) || base <= 0 || base == 1) {
    stop("`base` must be one finite positive number other than 1.",
         call. = FALSE)
  }

  proportions <- counts[counts > 0] / sum(counts)
  -sum(proportions * log(proportions, base = base))
}

#' Simpson diversity indices
#'
#' Calculate one of three closely related Simpson indices from taxon counts or
#' abundances. If `p[i]` is the relative abundance of taxon `i`, Simpson's
#' concentration is `sum(p[i]^2)`.
#'
#' @param counts A numeric vector of non-negative counts or abundances.
#' @param method Index to return: `"gini-simpson"` gives
#'   `1 - sum(p^2)`, `"simpson"` gives `sum(p^2)`, and `"inverse"` gives
#'   `1 / sum(p^2)`.
#' @param na.rm Logical. If `TRUE`, missing values are removed; otherwise a
#'   missing value produces `NA`.
#'
#' @return A single numeric value.
#' @export
#'
#' @examples
#' simpson_diversity(c(12, 7, 4, 1))
#' simpson_diversity(c(12, 7, 4, 1), method = "inverse")
simpson_diversity <- function(counts,
                              method = c("gini-simpson", "simpson", "inverse"),
                              na.rm = FALSE) {
  method <- match.arg(method)
  counts <- validate_counts(counts, na.rm = na.rm)
  if (length(counts) == 1L && is.na(counts)) {
    return(NA_real_)
  }

  proportions <- counts / sum(counts)
  concentration <- sum(proportions^2)

  switch(
    method,
    "gini-simpson" = 1 - concentration,
    "simpson" = concentration,
    "inverse" = 1 / concentration
  )
}

validate_counts <- function(counts, na.rm) {
  if (!is.numeric(counts) || !is.null(dim(counts))) {
    stop("`counts` must be a numeric vector.", call. = FALSE)
  }
  if (!is.logical(na.rm) || length(na.rm) != 1L || is.na(na.rm)) {
    stop("`na.rm` must be TRUE or FALSE.", call. = FALSE)
  }
  if (anyNA(counts)) {
    if (!na.rm) {
      return(NA_real_)
    }
    counts <- counts[!is.na(counts)]
  }
  if (length(counts) == 0L) {
    stop("`counts` must contain at least one observed value.", call. = FALSE)
  }
  if (any(!is.finite(counts))) {
    stop("`counts` must contain only finite values.", call. = FALSE)
  }
  if (any(counts < 0)) {
    stop("`counts` cannot contain negative values.", call. = FALSE)
  }
  if (sum(counts) <= 0) {
    stop("At least one value in `counts` must be greater than zero.",
         call. = FALSE)
  }
  counts
}

