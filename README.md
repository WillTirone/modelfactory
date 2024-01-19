
  <!-- badges: start -->
  [![R-CMD-check](https://github.com/WillTirone/modelfactory/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/WillTirone/modelfactory/actions/workflows/R-CMD-check.yaml)
  [![test-coverage](https://github.com/WillTirone/modelfactory/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/WillTirone/modelfactory/actions/workflows/test-coverage.yaml)
  <!-- badges: end -->

<img src="man/figures/logo.png" height="300"/>

# About 

`modelfactory` is an R package that takes care of the tedious task of comparing
model metrics and attributes. It's always a pain when I need to calculate, say,
an intercept, S.E., and 95% C.I. for several models and combine them into a dataframe.
This package aims to take care of that.

# Installation

You can install the package from CRAN with: 

``` r
install.packages("modelfactory")
```

Or, you can install the development version of modelfactory with: 

``` r
# install.packages("devtools")
devtools::install_github("WillTirone/modelfactory")
```

# Usage

``` r
lm_1 = lm(mpg ~ cyl + disp + hp, data = mtcars)
lm_2 = lm(mpg ~ hp + drat + wt, data = mtcars)
```

# Contributing 

Contributions are encouraged and welcomed, feel free to submit a PR or open an 
issue!

# CRAN Submission / TODO

- remove unnecessary README stuff
- delete inst
- finish / verify that the functions have roxygen correct
- add examples to readme
- add to NEWS.md
- read release section again and use use_release_issue()

# TODO: 
  - fix image in pkgdown site
  - turn on github pages for repo 
  - expects output 

# Change
  - look at r hub 
