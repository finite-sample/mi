# mi

[![CRAN status](https://www.r-pkg.org/badges/version/mi)](https://CRAN.R-project.org/package=mi)
[![R-CMD-check](https://github.com/finite-sample/mi/actions/workflows/R-CMD-check.yml/badge.svg)](https://github.com/finite-sample/mi/actions/workflows/R-CMD-check.yml)

mi fills in missing values in a data frame by multiple imputation. Each
variable with missing values gets its own model, conditional on all the
others: a linear regression for a continuous variable, a logistic regression
for a binary one, an ordered logit for an ordered factor, and so on. mi cycles
through these models, drawing each variable's missing values from its model
given the current values of the rest, and runs several such chains at once.
When the chains agree (the `Rhat` statistic is near 1), each chain's final
state is one completed data set. An analysis is then run on every completed
data set and the results are pooled, so the standard errors include the
uncertainty about the missing values.

The package also provides diagnostics for the imputation models and for
convergence. It is by Andrew Gelman, Jennifer Hill, Yu-Sung Su, Masanao
Yajima, Maria Grazia Pittau, Ben Goodrich, Yajuan Si and Jon Kropko; see Su
et al. (2011) below.

## Installation

```r
# Released version
install.packages("mi")

# Development version
# install.packages("pak")
pak::pak("finite-sample/mi")
```

## Example

`nlsyV` is a subset of the National Longitudinal Survey of Youth: a child's
test score at 36 months (`ppvtr.36`) and the mother's characteristics, with
values missing in five of the seven columns.

```r
library(mi)
data(nlsyV, package = "mi")
mdf <- missing_data.frame(nlsyV)

set.seed(1)
imputations <- mi(mdf, n.chains = 2, n.iter = 30, parallel = FALSE, verbose = FALSE)
Rhats(imputations)
#> mean_ppvtr.36   mean_b.marr   mean_income    mean_momed  mean_momrace
#>     1.0406276     0.9879077     1.2139696     0.9847186     1.0273200
#>   sd_ppvtr.36     sd_b.marr     sd_income      sd_momed    sd_momrace
#>     0.9915178     0.9877323     1.0681728     1.0191437     0.9932422

analysis <- pool(ppvtr.36 ~ first + b.marr + income + momage + momed + momrace,
                 data = imputations, m = 2)
display(analysis)
#> bayesglm(formula = ppvtr.36 ~ first + b.marr + income + momage +
#>     momed + momrace, data = imputations, m = 2)
#>             coef.est coef.se
#> (Intercept) 87.56     8.53
#> first1       4.22     1.69
#> b.marr1      4.96     2.59
#> income       0.00     0.00
#> momage      -0.29     0.37
#> momed.L     13.65     4.00
#> momed.Q      1.05     3.53
#> momed.C      1.38     2.21
#> momrace.L    8.82     2.03
#> momrace.Q    6.55     1.76
#> n = 390, k = 10
#> residual deviance = 94249.2, null deviance = 139394.4 (difference = 45145.2)
#> overdispersion parameter = 241.7
#> residual sd is sqrt(overdispersion) = 15.55
```

Thirty iterations and two chains keep the example fast; `income`'s `Rhat` of
1.21 says these chains have not yet converged, and a real analysis would use
the defaults (four chains, 30 iterations, continued with further calls to
`mi()` until every `Rhat` is near 1).

## Citation

Su, Y.-S., Gelman, A., Hill, J., and Yajima, M. (2011). Multiple Imputation
with Diagnostics (mi) in R: Opening Windows into the Black Box. *Journal of
Statistical Software*, 45(2).
[doi:10.18637/jss.v045.i02](https://doi.org/10.18637/jss.v045.i02)

## License

GPL (>= 2).
