
  <!-- badges: start -->
  [![R-CMD-check](https://github.com/WillTirone/modelfactory/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/WillTirone/modelfactory/actions/workflows/R-CMD-check.yaml)
  [![test-coverage](https://github.com/WillTirone/modelfactory/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/WillTirone/modelfactory/actions/workflows/test-coverage.yaml)
  <!-- badges: end -->

<img src="inst/logo.png" height="300"/>

# About 

`modelfactory` is an R package that takes care of the tedious task of comparing
model metrics and attributes. It's always a pain when I need to calculate, say,
an intercept, S.E., and 95% C.I. for several models and combine them into a dataframe.
This package aims to take care of that.

# Installation

You can install the development version of modelfactory with: 

``` r
# install.packages("devtools")
devtools::install_github("WillTirone/modelfactory")
```

# Usage

``` r
lm_1 = lm(mpg ~ cyl + disp + hp, data = mtcars)
lm_2 = lm(mpg ~ hp + drat + wt, data = mtcars)
smelt(lm_1, lm_2)
```

# Contributing 

Contributions are encouraged and welcomed, feel free to submit a PR or open an 
issue!

# CRAN Submission

- remove unnecessary README stuff
- write a vignette 
- finish / verify that the functions have roxygen correct
- GH actions CI / try using use_github_action() 

First release
  * usethis::use_news_md()
  * usethis::use_cran_comments()
  * Update (aspirational) install instructions in README
  * Proofread Title: and Description:
  * Check that all exported functions have @returns and @examples
  * Check that Authors@R: includes a copyright holder (role ‘cph’)
  * Check licensing of included files
  * Review https://github.com/DavisVaughan/extrachecks
  
# Questions 
  - are imports correct? 

# Presentation Notes: 

## Interesting Stuff: 

- stats::confint and MASS::confint for glm's, see ?confint
- deviance / AIC are attributes of glm, but not lmer models!
  - difficult to write universal functions to get metrics etc.
  - this is why it's confusing to do this by hand
- dependencies are confusing
  
## Workflow: 

1. Edit one or more files below R/.
2. document() (if you’ve made any changes that impact help files or NAMESPACE)
3. load_all()
4. Run some examples interactively.
5. test() (or test_active_file())
6. check()
