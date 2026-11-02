#' Chi-squared test for Hardy-Weinberg equilibrium
#'
#' Compare observed counts of the ordered genotypes `AA`, `Aa`, and `aa`
#' with the counts expected under Hardy-Weinberg equilibrium.
#'
#' @param counts Numeric vector of three non-negative integer genotype counts,
#'   ordered as `AA`, `Aa`, and `aa`.
#' @param p Optional frequency of allele `A`. If `NULL`, it is estimated from
#'   `counts` and the test uses one degree of freedom. If supplied, the test uses
#'   two degrees of freedom.
#'
#' @return An object of class `"htest"`. In addition to the usual test fields,
#'   the object contains `observed` and `expected` genotype counts.
#' @export
#'
#' @examples
#' hardy_weinberg_test(c(AA = 25, Aa = 50, aa = 25))
#' hardy_weinberg_test(c(30, 40, 30), p = 0.5)
hardy_weinberg_test <- function(counts, p = NULL) {
  data_name <- deparse(substitute(counts))
  if (!is.numeric(counts) || length(counts) != 3L || anyNA(counts) ||
      any(!is.finite(counts)) || any(counts < 0) ||
      any(abs(counts - round(counts)) > sqrt(.Machine$double.eps))) {
    stop("`counts` must contain three non-negative integer counts in AA, Aa, aa order.",
         call. = FALSE)
  }
  total <- sum(counts)
  if (total <= 0) {
    stop("At least one genotype count must be greater than zero.", call. = FALSE)
  }

  estimated <- is.null(p)
  if (estimated) {
    p <- (2 * counts[[1L]] + counts[[2L]]) / (2 * total)
  } else if (!is.numeric(p) || length(p) != 1L || is.na(p) ||
             !is.finite(p) || p <= 0 || p >= 1) {
    stop("`p` must be one finite number strictly between 0 and 1.",
         call. = FALSE)
  }
  if (p <= 0 || p >= 1) {
    stop("The sample is monomorphic; an equilibrium test requires both alleles.",
         call. = FALSE)
  }

  q <- 1 - p
  expected <- total * c(AA = p^2, Aa = 2 * p * q, aa = q^2)
  observed <- stats::setNames(as.numeric(counts), c("AA", "Aa", "aa"))
  statistic <- sum((observed - expected)^2 / expected)
  degrees_freedom <- if (estimated) 1 else 2
  p_value <- stats::pchisq(statistic, df = degrees_freedom,
                           lower.tail = FALSE)

  structure(
    list(
      statistic = stats::setNames(statistic, "X-squared"),
      parameter = stats::setNames(degrees_freedom, "df"),
      p.value = p_value,
      estimate = stats::setNames(p, "allele frequency (A)"),
      method = "Chi-squared test for Hardy-Weinberg equilibrium",
      data.name = data_name,
      observed = observed,
      expected = expected
    ),
    class = "htest"
  )
}

