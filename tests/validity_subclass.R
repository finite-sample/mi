# Regression test for R-devel (PR#17944): validObject() now calls superclass
# validity methods on the object itself rather than on as(object, superClass).
# The missing_variable validity method must therefore only inspect its own
# slots. We call it directly on subclass objects to emulate that behavior on
# any R version.
stopifnot(require(mi))
mv_validity <- getValidity(getClass("missing_variable"))

set.seed(1)
x <- rbinom(10, size = 1, prob = 0.5)
x[1] <- NA
if (all(x == 1, na.rm = TRUE) || all(x == 0, na.rm = TRUE)) x[10] <- 1 - x[10]
gb <- missing_variable(x, type = "grouped-binary", strata = rep(c("A", "B"), each = 5))
stopifnot(isTRUE(mv_validity(gb)))

data(nlsyV, package = "mi")
mdf <- missing_data.frame(nlsyV, favor_positive = TRUE, favor_ordered = FALSE)
for (v in mdf@variables) stopifnot(isTRUE(mv_validity(v)))

# the original scalar-slot check must still work
bad <- mdf@variables[[1]]
bad@variable_name <- c("a", "b")
stopifnot(is.character(mv_validity(bad)))
