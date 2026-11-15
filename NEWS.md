Entries before 1.3.2 were reconstructed in November 2026 from the diffs
between consecutive CRAN releases. They record changes visible in the code,
not the authors' stated intent. Releases 0.02-01 to 0.10-2 also shipped the
authors' own `CHANGELOG` file, available in those CRAN source tarballs.

# mi 1.3.2

- (in preparation)

# mi 1.3.1 (2026-07-28)

- Tests now call `set.seed(1)`, and the binary-variable test guarantees both
  values are present, so the test suite no longer fails at random.
- Vignette: one URL changed from http to https.
- No changes to R code, documentation, or dependencies.

# mi 1.2 (2025-09-02)

- Documentation: cross-references to `bayesglm`, `polr` and `write.dta` now
  name their packages (`arm`, `MASS`, `foreign`); the `rdata.frame()` value
  section is restructured; the NLSY97 source URL and the package URL are
  updated.
- No changes to R code or dependencies.

# mi 1.1 (2022-06-06)

- Fixed `change_family()` on a `proportion` variable switched to the binomial
  family: it referred to a non-existent `.identity_transformation` and now uses
  `.identity_transform`.
- Fixed the group-level draw in `fit_model()` for `multilevel_missing_data.frame`
  objects: `rnorm()` was sized by `nrow(X)`, an undefined object, and now uses
  `nrow(data@X)`.
- Fixed imputation of `grouped-binary` variables with a `clogit` model, which
  called `untangle.specials()` without the `survival::` prefix.
- NAMESPACE now imports the functions it uses from `grDevices`, `graphics`,
  `stats`, `utils` and `Matrix` explicitly.
- Documentation: NLSY97 URL changed to https.

# mi 1.0 (2015-04-16)

- Complete rewrite by Ben Goodrich and Jon Kropko, who becomes the maintainer.
  Almost none of the 0.x interface carries over.
- New S4 classes: `missing_variable` and its subclasses (one per variable
  type, such as `continuous`, `binary`, `count`, `ordered-categorical`,
  `unordered-categorical`, `proportion`, `semi-continuous`,
  `censored-continuous` and `truncated-continuous`); `missing_data.frame` and
  its `allcategorical_`, `experiment_` and `multilevel_` subclasses; `mi`; and
  `pooled`.
- New workflow: `missing_data.frame()` describes the data, `change()` and the
  `change_*()` family (`change_family`, `change_imputation_method`,
  `change_link`, `change_model`, `change_size`, `change_transformation`,
  `change_type`) adjust how each variable is modelled, `mi()` imputes
  (`n.iter = 30`, `n.chains = 4`, `max.minutes = Inf`, `parallel` on
  non-Windows), `Rhats()` checks convergence, `complete()` extracts completed
  datasets, and `pool()` fits a model to each completed dataset and pools the
  estimates.
- Other new exports: `fit_model()`, `get_parameters()`, `mipply()`,
  `mi2BUGS()`, `mi2stata()`, `multinomial()`, `rdata.frame()`, and `hist()`,
  `image()` and `plot()` methods.
- Removed all 0.x exports except `mi()` and `display()`, including `mi.info()`
  and the `mi.info.update.*()` functions, `mi.pooled()`, `lm.mi()`, `glm.mi()`,
  `bayesglm.mi()`, `bayespolr.mi()`, `polr.mi()`, `lmer.mi()`, `glmer.mi()`,
  `mi.completed()`, `mi.data.frame()`, the per-type imputation functions
  (`mi.continuous()`, `mi.binary()`, `mi.categorical()`, `mi.polr()`,
  `mi.count()`, `mi.pmm()`, `mi.fixed()`, `mi.copy()`), `mi.preprocess()` and
  `mi.postprocess()`, `typecast()`, `noise.control()`, `random.imp()`,
  `write.mi()`, and the plotting helpers (`mi.hist()`, `mi.scatterplot()`,
  `marginal.scatterplot()`, `conv.plot()`, `convergence.plot()`, `mp.plot()`,
  `missing.pattern.plot()`).
- Dependencies: now Depends on R (>= 3.0.0), `methods`, `Matrix` and `stats4`
  and Imports only `arm` (>= 1.4-11). `abind`, `car`, `lme4`, `nlme` and
  `R2WinBUGS` are dropped; `MASS`, `nnet` and `foreign` move to Suggests,
  joined by `betareg`, `lattice`, `knitr`, `parallel`, `sn`, `survival` and
  `truncnorm`.
- New dataset `nlsyV` (an NLSY97 extract); `CHAIN` is kept.
- New knitr vignette, "An Example of mi Usage".
- New tests for `missing_variable()` and `missing_data.frame()`.

# mi 0.10-2 (2015-04-07)

- `coef()`, `fitted()` and `sigma.hat()` methods for `mi.method` objects, and
  `coef()` for `mi.pooled`, are now S3 methods rather than S4 methods. The
  S4 `coefficients()` methods are removed; `coefficients()` now dispatches to
  `coef()`.
- `fixef` is now imported from `nlme` instead of `arm`; `nlme` added to
  Imports. Requires `arm` (>= 1.8-4).

# mi 0.10-1 (2015-04-06)

- The iteration-limit argument of `mi.binary()`, `mi.categorical()`,
  `mi.continuous()`, `mi.count()`, `mi.pmm()` and `mi.polr()` is renamed from
  `n.iter` to `maxit` (default 100 unchanged), matching the newer
  `arm::bayesglm()`. Requires `arm` (>= 1.8-03).
- `mi.hist()`, `plot()` and `residuals()` for `mi.binary` objects now
  convert factor values to numbers before computing, instead of doing
  arithmetic on a factor.
- Known problem: the new `resid()` method for `mi.binary` objects reads
  `.factor2num(y)(.dichot(y))`, which calls a numeric vector as a function, so
  `resid()` on an `mi.binary` object fails with "attempt to apply
  non-function" in 0.10-1 and 0.10-2; `residuals()` is unaffected.

# mi 0.09-19 (2014-10-02)

- NAMESPACE now imports `bayesglm()`, `bayespolr()`, `sim()`, `logit()`, `invlogit()`, `traceplot()` and `fixef()` from arm and `Matrix()` from Matrix explicitly.
- `coefficients` is defined as an S4 generic only if one does not already exist; documented as an alias in `?mi`.

# mi 0.09-18.03 (2013-08-26)

- Dependencies reorganised: only arm (>= 1.6-07) is in Depends; abind, car, foreign, lme4 (>= 0.999999-2), MASS, Matrix (>= 1.0), methods, nnet, stats and R2WinBUGS moved to Imports, with explicit `importFrom()` directives in NAMESPACE.
- `coef`, `coefficients`, `fitted`, `resid` and `residuals` are now declared as S4 generics in the package; plot methods call `residuals(x, y = y)` by name.
- The bundled `LICENSE` file was removed (the licence is still GPL (>= 2)).
- Documentation: the `?mi` example now runs with `add.noise = FALSE`; the coefficient-convergence example lines are commented out.

# mi 0.09-18 (2012-09-05)

- `mi()` no longer calls `.Internal(seterrmessage(""))` when an imputation model fails.
- Documentation: examples in `?convergence.plot`, `?mi`, `?mi.completed`, `?mi.hist` and `?plot.mi` are commented out (not run).

# mi 0.09-16 (2012-01-19)

- `print` is now made an S4 generic (`setGeneric("print")`) before the `print` method for `mi` objects is defined.

# mi 0.09-15 (2011-11-21)

- New `inst/CITATION`: Su, Gelman, Hill and Yajima (2011), Journal of Statistical Software 45(2).
- The startup message now uses `packageStartupMessage()`, and loading no longer calls `require()` on car, abind and arm.
- Documentation: references updated from "Forthcoming" to the published JSS article.

# mi 0.09-14 (2011-04-25)

- car is listed a second time in Depends, and the startup hook attaches car if it is not already on the search path.

# mi 0.09-13 (2011-02-17)

- `mi.scatterplot()` plots the imputed values again (jittered, without the lowess line).

# mi 0.09-12 (2011-02-09)

- `plot.mi()` default `mfrow` changed from `c(1, 4)` to `c(1, 3)`, and the blank filler panels were removed from the per-variable diagnostic plots.
- The red points for imputed-value residuals are no longer drawn on the `mi.method` diagnostic plot.

# mi 0.09-11.06 (2011-02-08)

- `plot()` for `mi.method` objects no longer draws the residual-plot panel (`residual.plot()` call removed).
- `mi.scatterplot()` no longer draws imputed values or their lowess line.
- The startup message uses `packageDescription(lib.loc = )` for the version as well.

# mi 0.09-11.05 (2011-02-05)

- Requires arm (>= 1.3-08).
- Startup message: `packageDescription()` is called with `lib.loc =` instead of the partial argument `lib =`.
- Maintainer address changed to suyusung@tsinghua.edu.cn (DESCRIPTION and all Rd author fields).

# mi 0.09-11.04 (2011-02-04)

- `mi.pmm()`: fitted values for predictive mean matching are now taken from `predict()` on the fitted `bayesglm` model itself, instead of predicting on `data.frame(Y, X)` built from the raw model frame.

# mi 0.09-11.03 (2010-11-11)

- `mi.binary()`, `mi.continuous()`, `mi.count()` and `mi.pmm()` store the current values of the missing outcome in `@model$startY`.
- `plot()` for `mi.method` (and binary) imputations overlays the residuals of the imputed values in red on the residual and binned-residual panels.
- The x-axis label of the scatterplot panel for categorical/ordered imputations changed from "predicted" to "expected".

# mi 0.09-11.02 (2010-10-25)

- `mi.binary()`, `mi.continuous()` and `mi.count()` read simulated coefficients and sigma from `arm::sim()` with `@coef` / `@sigma` (S4 slots) instead of `$coef` / `$sigma`.

# mi 0.09-11.01 (2010-10-18)

- Documentation only: `\docType{genericFunction}` removed from `?mi`, `?mi.hist`, `?plot.mi` and `?typecast`.

# mi 0.09-11 (2010-06-29)

- The post-noise iterations run at the end of `mi()` (`noise.control(post.run.iter=)`) now respect the `max.minutes` time limit.
- When starting values are supplied, `mi.binary()` and `mi.continuous()` now fit with `n.iter = 50` (was 25).

# mi 0.09-10 (2010-06-15)

- `mi.count()` again discards supplied starting values (`start <- NULL`) and uses `n.iter = 50` in that case (was 25).

# mi 0.09-09 (2010-06-08)

- `mi()` now stores the data as supplied in the returned `mi` object, rather than the internally factorised copy.

# mi 0.09-08 (2010-06-06)

- `mi.count()`: `draw.from.beta` default changed back to `TRUE`.
- `mi.count()`: draws are negative binomial when the model is overdispersed in both the `draw.from.beta` and the plain prediction branch; a dispersion of 1 or less now gives Poisson draws (previously a dispersion below 1 produced an invalid negative-binomial size).
- When starting values are supplied, `mi.binary()` and `mi.count()` fit with `n.iter = 25` (was 50).

# mi 0.09-07 (2010-06-04)

- `mi.count()` draws from a negative binomial (instead of Poisson) when `draw.from.beta = TRUE` and the fitted model's dispersion is not 1; supplied starting values are used again.
- New `total.iters` slot in `mi` objects; when `mi()` continues an existing `mi` object, the progress output numbers iterations cumulatively.
- `mi()` on a data frame with `add.noise = FALSE` now also thins the stored trace to about 30 iterations when more than 30 were run.
- `bugs.mi()` now matches `check` with `match.arg()`, so the default is `"data"`.
- `mi.postprocess()`: fixed restoration of original variable names after log/logit transformation (`.mi.log` / `.mi.logit` suffixes) and of nonnegative variables recombined from their `.mi.ind` indicator.

# mi 0.09-06.01 (2010-05-28)

- The `preprocess` argument of `mi()` was removed. Transformation is now explicit: `mi.preprocess(data, info)` returns an object of the new class `mi.preprocessed` (data plus `mi.info`), and `mi()` has a new method for it. `info` is optional in `mi.preprocess()`.
- `mi.preprocess()` renames transformed columns with `.mi.log`, `.mi.logit` and `.mi.ind` suffixes.
- The `preprocess` and `mi.info.preprocessed` slots were removed from the `mi` class; `mi.completed()` and `mi.data.frame()` always back-transform with `mi.postprocess()`.
- `mi.count()`: `draw.from.beta` default changed to `FALSE`, and supplied starting values are ignored.
- When starting values are supplied, models fit with `n.iter = 50` in `mi.binary()` and `mi.count()` and 25 in `mi.continuous()` (was 10).
- Lists of imputations and of per-imputation fits (`lm.mi()`, `glm.mi()`, `bayesglm.mi()`, `polr.mi()`, `lmer.mi()`, ...) are now named `Chain1`, `Chain2`, ... instead of `Imputation1`, ....
- `update.mi.info()`: setting `is.ID` or `all.missing` now looks up the list entry by variable name (it used position), and `imp.formula` can be updated for several variables in one call.
- Documentation: `?mi` examples show imputation with and without `mi.preprocess()`.

# mi 0.09-05 (2010-05-17)

- `mi()` on an existing `mi` object thins the stored trace to about 30 iterations when more than 30 were run.

# mi 0.09-04 (2010-05-09)

- Progress output and `display()` of pooled fits label each imputation "Chain" instead of "Imputation".
- `mi.postprocess()` matches the `.ind` suffix literally (`fixed = TRUE`); before, a regular-expression match could catch other variable names containing "ind" preceded by any character.
- `mi.scatterplot()` adds a dashed 45-degree line.
- Binned-residual panels in `plot()` draw points in blue (black with `gray.scale = TRUE`).

# mi 0.09-02 (2010-04-16)

- `mi()` no longer stops at data convergence when `check.coef.convergence = TRUE`.
- `mi.pmm()`: the `bayesglm` model is now fitted on the `data` argument, and the donor pool for matching excludes the missing rows by index (`-missing.index`); before, `!missing.index` on a numeric index selected the wrong rows.

# mi 0.09-01 (2010-04-15)

- Maintenance release: DESCRIPTION updates only.

# mi 0.08-08.02 (2010-04-13)

- Minor rewrite of the convergence check that prints the termination message in `mi()`; no change in behaviour is visible in the diff.

# mi 0.08-08.01 (2010-04-11)

- `missing.pattern.plot()` / `mp.plot()` gain `clustered = TRUE`, which orders rows by hierarchical clustering of their missingness pattern.
- `mi.pooled()` drops the `m` argument; the number of imputations is taken from `length(coef)`.
- The `threshhold` argument of `mi.info()`, `mi.check.correlation()` and `mi.correlated.list()` is renamed `threshold`.

# mi 0.08-08 (2010-04-03)

- Rewrite of the `mi()` sampler (helper functions moved to the new `R/mi.misc.R`).
- The `post.run` argument of `mi()` was removed; `noise.control()` gains `post.run.iter = 20`, the number of extra iterations run after noise is added (0 to skip).
- `mi()` stops with an error if `n.iter <= 5`.
- The `mi` class replaces the `bugs` and `coef.conv` slots with `mcmc`, `coef.mcmc` and `coef.converged`, and adds `add.noise`; `convergence.plot()` reads the `mcmc` slot.
- `converged()` and `bugs.mi()` gain `check = c("data", "coefs")` to report on the imputed data or on the model coefficients.
- `mi.binary()`, `mi.continuous()`, `mi.count()`, `mi.categorical()`, `mi.polr()`, `mi.pmm()`, `mi.fixed()`, `mi.copy()`, `mi.mean()` and `mi.median()` gain a `missing.index` argument; `mi.info()` records each variable's `missing.index`.
- When starting values are supplied, `mi.binary()`, `mi.continuous()`, `mi.count()` and `mi.pmm()` fit with `n.iter = 10` (was 30).
- `mi.completed()` fills in only variables that are included in the imputation.
- `mi.check.correlation()` and `mi.correlated.list()` convert columns to numeric before calling `cor()`.
- `update.mi.info()` removes excluded variables from all imputation formulas, and recomputes `imp.order` only when `include`, `is.ID` or `all.missing` change; it no longer regenerates default formulas.
- `mi.scatterplot()` default `obs.col` is now opaque blue (was 30% transparent).
- The `CHAIN` dataset is now shipped as `data/CHAIN.rda`.
- Documentation: `?mi` examples now continue an existing imputation with `mi(IMP, n.iter = 6)` and show `converged()` / `bugs.mi()` with `check`.

# mi 0.08-06 (2010-01-01)

- `update.mi.info()`: fixed `imp.order`, which was reset to 1 for every variable because the counter was re-initialised inside the loop; included variables with missing values are now numbered consecutively.

# mi 0.08-05 (2009-12-23)

- `mi()` on an existing `mi` object drops the `info` argument and reuses the object's stored (and, if preprocessed, transformed) `mi.info`.
- `mi.polr()`: the deterministic prediction is the most probable category from the predicted probabilities, and random draws use the level labels of the fitted model.
- Restoring `options(show.error.messages = TRUE)` after a model fit is now done with `on.exit()`.

# mi 0.08-04.07 (2009-12-20)

- Matrix added to Depends; `mi.binary()`, `mi.continuous()` and `mi.count()` build the design matrix for `draw.from.beta` as a sparse `Matrix`.

# mi 0.08-04.06 (2009-12-09)

- `update.mi.info()` with `target = "type"` now resets the variable's `params` to the default arguments of the imputation function for the new type.
- `mi.binary()`, `mi.continuous()` and `mi.count()` build the `draw.from.beta` design matrix for the missing rows only.

# mi 0.08-04.04 (2009-12-03)

- `mi.binary()`, `mi.continuous()` and `mi.count()` build the design matrix only when `draw.from.beta = TRUE` and there are missing values. No user-visible change in the diff beyond this internal restructuring.

# mi 0.08-04.02 (2009-10-01)

- Maintenance release: file permissions, R-Forge fields in DESCRIPTION, and `?write.mi` cross-reference links.

# mi 0.08-04.01 (2009-08-13)

- Documentation only: revisions across the Rd files (e.g. `?mi.preprocess`, `?type.models`, `?write.mi`, `?noise.control`).

# mi 0.08-04 (2009-07-24)

- `mi.info.update.transform()` was removed.
- `update.mi.info()`: setting `is.ID` or `all.missing` to `TRUE` now also sets `include = FALSE`; `imp.order` is reset and default imputation formulas are regenerated after an update; the result keeps class `mi.info`.
- `mi.info()` flags a column as an ID when its values are unique and sorted, no longer requiring an integer column.
- `mi.preprocess()` transforms only included variables.
- `mi()` keeps the user's `mi.info` settings when preprocessing rebuilds `mi.info`, and works when only one variable is included (`drop = FALSE`).

# mi 0.08-03 (2009-06-23)

- When starting values are supplied, `mi.binary()`, `mi.continuous()`, `mi.count()` and `mi.pmm()` now fit with `n.iter = 30` (previously 1 for `mi.binary()` and `mi.pmm()`, and the caller's `n.iter` for the others).
- `mi()` on an existing `mi` object always initialises each chain with `random.imp()` of the data; before, when `preprocess = FALSE`, it started from the previous completed data.

# mi 0.08-02 (2009-06-19)

- Numeric unordered-categorical variables are converted with `as.factor(as.character(x))`.
- `plot()` for `mi.polr` and `mi.categorical` imputations no longer draws the binned-residual panel.
- `residuals()` / `resid()` for `mi.count` standardise by `sd(fitted)` instead of `sqrt(y)`.

# mi 0.08-01 (2009-06-17)

- `draw.from.beta` now defaults to `TRUE` in `mi.binary()`, `mi.continuous()` and `mi.count()`.
- `mi.binary()`, `mi.continuous()` and `mi.count()` build the `draw.from.beta` design matrix from the fitted model's terms and contrasts, rather than from the raw model frame, so factor predictors are expanded into dummy columns.
- `mi.count()`: draws with `draw.from.beta = TRUE` now use `exp()` of the linear predictor as the Poisson mean (before, the linear predictor itself), and no draws are attempted when nothing is missing.
- `mi()` on an existing `mi` object drops the `preprocess` and `check.coef.convergence` arguments and takes them from the object.
- `mi()` converts unordered-categorical variables to factors before imputing.
- `update.mi.info()` no longer rewrites imputation formulas when a variable's type changes.

# mi 0.07-4 (2009-06-14)

- `mi.pooled()`: fixed the between-imputation variance. It squared the column sums of deviations from the mean (which sum to zero); it now takes the variance of the estimates across imputations.

# mi 0.07-3 (2009-06-10)

- `mi.binary()`, `mi.continuous()` and `mi.count()` with `draw.from.beta = TRUE` read simulated coefficients from `sim()$coef` (was `$beta`).
- `mi()` on an existing `mi` object no longer takes `n.imp`.
- `display()` for pooled fits prints the separate per-imputation estimates first and the pooled estimates last.

# mi 0.07-2 (2009-05-10)

- New `write.mi()` writes each completed dataset to `midata1`, `midata2`, ... as csv, Stata (`.dta`) or plain table files.
- `glmer.mi()` is no longer exported.

# mi 0.07-1 (2009-04-29)

- Renamed: `mi.dichotomous()` (and class) to `mi.binary()`, variable type `"dichotomous"` to `"binary"`, type `"mixed"` to `"nonnegative"`, `prior.control()` to `noise.control()`, `mi.info.update.correlated()` to `mi.info.update.collinear()`, and the `correlated` element of `mi.info` to `collinear`.
- `mi()` arguments renamed: `add.priors` to `add.noise`, `continue.on.convergence` to `run.past.convergence`.
- The `plot()` method for `mi` objects accepts a `y` argument, sets compact margins and restores `par()` on exit; per-variable plot methods pass `gray.scale` through.

# mi 0.06-5 (2009-04-23)

- `mi.polr()` now wraps the response in `ordered()` itself before calling `bayespolr()`, so a plain `y ~ x` formula works (the example drops `factor(y)`). Correspondingly, the default imputation formulas no longer wrap ordered or unordered categorical responses in `ordered()`/`factor()` (this reverses the 0.06-2 change).
- `mi()`: the per-iteration means and standard deviations used for the convergence check are now computed by variable name, for included variables with missing values only. The vector is stored as all means followed by all SDs, which matches the `mean(...)`/`sd(...)` labels. The case where only one variable is imputed is now handled too. Levels filled in for unordered-categorical variables are sorted.
- `update(<mi.info>, "type", ...)`: changing a variable to `"ordered-categorical"` now removes `factor()` wrappers around it in the imputation formulas. Changing it to `"unordered-categorical"` first removes `ordered()` from its own formula and then wraps it in `factor()`.
- `mi.info()`: `NULL` entries are dropped from the list of correlated variable pairs.

# mi 0.06-4.01 (2009-04-21)

- `mi()`: if an unordered-categorical variable has no `level` in its `mi.info`, the levels are now taken from the observed values.
- `mi()`: the convergence statistics are now computed according to each variable's `mi.info` type: level-indicator means and SDs for unordered-categorical, `ordered()` codes for ordered-categorical, and numeric values otherwise. Labels for categorical indicator columns now use the level values rather than the level names.
- `update(<mi.info>, "type", ...)`: the type lookup now uses `[[` (`object$type[[name]]`).
- Documentation: removed the placeholder Details section from `?mi.info`.

# mi 0.06-2 (2009-04-19)

- Default imputation formulas now wrap an ordered-categorical response in `ordered()` and an unordered-categorical response in `factor()`. Variables of type `"fixed"` get `y ~ y`.
- `update(<mi.info>, "type", ...)`: setting a variable to ordered or unordered categorical now wraps that variable in `ordered()`/`factor()` wherever it appears in the imputation formulas. Previously the variable's own formula was regenerated from scratch.
- `mi.info.fix()`: an interactive type change now goes through `update()`, so formulas are adjusted as well.
- `mi()` progress output: with the reshuffling prior, variables that were not reshuffled in an iteration are now printed as well.

# mi 0.06-1 (2009-04-17)

- `prior.control()` has a new interface: `prior.control(method = c("reshuffling", "fading"), pct.aug = 10, K = 1)`, which replaces the `augment.data` argument. `"reshuffling"` (the default) draws from the marginal with probability `K/s`, and `"fading"` augments the data with `pct.aug` percent of random draws. Use `add.priors = FALSE` for no prior.
- `mi()` with `post.run = TRUE` now runs the extra 20 iterations whenever `add.priors` is a `prior.control()` list, instead of only when `K > 0` or `augment.data = TRUE`.
- `mi.postprocess()` (and therefore `mi.completed()`/`mi.data.frame()` on preprocessed data) no longer drops every column when the data contain no `.ind` indicator columns. The fix guards the `[, -idx]` call for an empty index.
- `mi.info()`: a pair of perfectly correlated variables is no longer treated as a deterministic pair when the two have different missingness patterns.
- `mi.data.frame()` no longer leaves a stray global variable `aa`.
- The convergence-statistic labels now cover only the included variables.

# mi 0.05-1 (2009-04-15)

- New class `mi.pooled` and exported function `mi.pooled(coef, se, m)`, which combines estimates across imputations. `lm.mi()`, `glm.mi()`, `bayesglm.mi()`, `lmer.mi()` and `glmer.mi()` now all return `mi.pooled` objects, replacing the classes `mi.lm`, `mi.glm` and `mi.mer`. These objects have `print`, `display`, `coef` and `se.coef` methods.
- New pooled-analysis functions `polr.mi()` and `bayespolr.mi()`.
- `lmer.mi()`/`glmer.mi()` now take the per-imputation estimates from `fixef()` and `se.coef()$fixef`.
- Back-transformation of preprocessed data moved into `mi.completed()`/`mi.data.frame()`, which now call `mi.postprocess()` when `mi()` was run with `preprocess = TRUE`. The modeling functions no longer call `mi.postprocess()` themselves. `mi.data.frame()` also assigns a global variable `aa` as a side effect.
- `mi.preprocess(data, info)` and `mi.postprocess(mi.data, info)` now take an `mi.info` object instead of `type`/`varnames`. Transformed variables replace the original column in place, with type `"log-continuous"` or `"proportion"`, instead of being added as new columns.
- New variable type `"log-continuous"`, imputed with `mi.continuous()`.
- `mi.info()` records each variable's class (`var.class`) and its factor or character levels (`level`).
- `mi()`: `add.priors = FALSE` now means no prior. Convergence of unordered-categorical variables is monitored through the means and SDs of one indicator per level.
- Documentation: new `?mi.pooled` page replacing `?lm.mi`, `?glm.mi` and `?lmer.mi`; examples updated.

# mi 0.04-6 (2009-04-01)

- New pooled-analysis functions `lmer.mi()`, `glmer.mi()` (class `mi.mer`) and `bayesglm.mi()`.
- `mi.lm`/`mi.glm` slots were renamed from `lm.mi.pooled`/`glm.mi.pooled` and `lm.mi.fit`/`glm.mi.fit` to `mi.pooled` and `mi.fit`. `display()` for these objects now reads `object@call`.
- The variable type `"predictive-mean-match"` was renamed `"predictive-mean-matching"`.
- `mi()`: a variable that is a deterministic copy of another (`determ.pred`) is now imputed as the predictor times the regression slope estimated on the observed data, instead of as a direct copy. This handles cases such as `y = 2x`.
- `mi.copy()` is now exported.
- `mi.preprocess()`: column renaming after a transform is now skipped when no other variable names remain, instead of assigning names over `1:0`.
- DESCRIPTION: license field normalized to `GPL (>= 2)`.

# mi 0.04-5 (2009-03-21)

- `mi()`: fixed the convergence test. `all(con.check$summary[,8]) < R.hat` became `all(con.check$summary[,8] < R.hat)`. Before the fix, the test compared `TRUE` with `R.hat`, so 0.04-4 declared convergence at the first check regardless of the R-hat values.

# mi 0.04-4 (2009-03-11)

- `mi()` has a new argument `R.hat = 1.1`, the R-hat threshold for declaring convergence, for both the `data.frame` and `mi` methods. It is also passed to the post-run iterations. Continuing an `mi` object previously used a fixed cutoff of 1.049.
- Documentation: the `?mi` example outcome now depends on `x9`.

# mi 0.04-3 (2009-03-10)

- `mi()`: the R-hat cutoff for convergence was relaxed from 1.049 to 1.1 for new imputations.
- `mi()` with the `K` prior: when a variable is selected for a random draw, the data are now filled with `random.imp()`, the imputation model is still fitted, and the random draws are used as the imputed values. Coefficients and start values are therefore recorded at every iteration. Previously the model fit was skipped.
- `mi.continuous()`, `mi.dichotomous()`, `mi.polr()` and `mi.categorical()` now handle a variable with no missing values by returning empty random predictions.
- `missing.pattern.plot()` no longer changes `par()` margin and label settings itself. `mp.plot` is now the same function.

# mi 0.04-2 (2009-03-05)

- `mi()` is now an S4 generic with `data.frame` and `mi` methods. The `type` argument was removed.
  - The default for `preprocess` changed from `FALSE` to `TRUE`.
  - The `augment.data` and `K` arguments were replaced by `add.priors = prior.control()`. The default is now `K = 1`, so random draws from the marginal are on by default.
  - New `post.run = TRUE` runs 20 more iterations after convergence when priors were used.
- New functions `prior.control()`, `mi.preprocess()` and `mi.postprocess()`. Preprocessing splits `"mixed"` variables into an indicator and a log-transformed positive part, and logs `"positive-continuous"` variables.
- New imputation function `mi.count()` and variable types `"count"`, `"proportion"` and `"positive-continuous"`.
- Removed `mi.logcontinuous()`, `mi.sqrtcontinuous()`, `mi.mixed()`, `mi.start()` and `mi.matrix()`, along with the `"logscale-continuous"` and `"squareroot-continuous"` types. `"mixed"` is now imputed with `mi.continuous()` after preprocessing.
- `mi.info.update()` was replaced by an `update()` method for `mi.info` objects. The `mi.info.update.*()` helpers now take `object` instead of `info`.
- `mi.info()`: the argument `threshold` was renamed `threshhold`.
- `mi.completed()` now returns a list of completed data frames, one per imputation. Its `m` and `outcome` arguments were removed.
- `mi.data.frame(object, m = 1)` now honors `m`. Previously it always returned imputation 1.
- `coef`, `fitted`, `resid`/`residuals` and `plot` methods are now S4 methods. New `coef` and `se.coef` methods for `lm.mi()`/`glm.mi()` results.
- Dependencies: now also depends on `car`, `lme4` and `abind`.
- Documentation: new pages for `mi.count`, `mi.preprocess` and `prior.control`; removed pages for the dropped functions.

# mi 0.02-03 (2009-01-06)

- `mi()` has new arguments `augment.data = FALSE`, which adds 10% random draws from the observed data, and `K = 0`, a cooling parameter: with probability `K/s` a variable is drawn from its marginal at iteration `s`.
- `mi()` now leaves the working imputations in a global `data.tmp` if it stops with an error.
- On attach, the package now loads `arm` if it is not attached. Previously it called `require(mi)`.
- Documentation: Rd formatting cleanups and added author entries.

# mi 0.02-02 (2008-10-07)

- New `display()` methods for the results of `lm.mi()` and `glm.mi()` (classes `mi.lm` and `mi.glm`), with `digits = 2`. They show the pooled estimate and then each imputation's fit. `print()` on these objects now calls `display()` and is registered as an S3 method.
- The package prints its version and build date on attach.
- The title was changed to "Missing Data Imputation and Model Checking".

# mi 0.02-01 (2008-10-06)

- Initial CRAN release.
