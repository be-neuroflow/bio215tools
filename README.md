# bio215tools

`bio215tools` is a small, dependency-free R package created for BIO215 Interim
Report 3. It provides tested functions for ecological diversity, population
growth, and Hardy-Weinberg equilibrium.

## Installation from GitHub

Install the released package in a clean R session:

```r
install.packages("remotes")
remotes::install_github("be-neuroflow/bio215tools")
library(bio215tools)
```

The repository must be public for this command to work without authentication.
If it is private, configure a GitHub personal access token before installing.

## Quick examples

### Ecological diversity

```r
counts <- c(12, 7, 4, 1)
shannon_diversity(counts)
simpson_diversity(counts)
simpson_diversity(counts, method = "inverse")
```

The included CSV can be loaded without relying on the working directory:

```r
path <- system.file("extdata", "example_abundance.csv",
                    package = "bio215tools")
abundance <- read.csv(path)
shannon_diversity(abundance$count)
```

### Population growth

```r
time <- 0:8
population <- logistic_growth(time, N0 = 5, K = 100, r = 0.8)
plot(time, population, type = "b", xlab = "Time",
     ylab = "Population size")

doubling_time(0.35)
```

### Hardy-Weinberg equilibrium

```r
result <- hardy_weinberg_test(c(AA = 25, Aa = 50, aa = 25))
result
result$observed
result$expected
```

The asymptotic chi-squared approximation is best used when expected genotype
counts are reasonably large. For small samples, report that limitation.

## Functions

| Function | Purpose |
|---|---|
| `shannon_diversity()` | Shannon diversity from abundance counts |
| `simpson_diversity()` | Gini-Simpson, Simpson concentration, or inverse Simpson |
| `logistic_growth()` | Population size under continuous logistic growth |
| `doubling_time()` | Doubling time from an exponential growth rate |
| `hardy_weinberg_test()` | Chi-squared Hardy-Weinberg equilibrium test |

All exported functions include help pages and runnable examples. After loading
the package, use `help(package = "bio215tools")` or, for example,
`?shannon_diversity`.

## Development checks

From the package's parent directory:

```r
install.packages(c("testthat", "rcmdcheck"))
testthat::test_package("bio215tools")
rcmdcheck::rcmdcheck("bio215tools", args = "--no-manual")
```

Every push to GitHub also runs `R CMD check` on Ubuntu through GitHub Actions.

## License

MIT License. See [LICENSE.md](LICENSE.md).

