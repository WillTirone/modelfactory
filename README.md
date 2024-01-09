
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

# Workflow 

1. Edit one or more files below R/.
2. document() (if you’ve made any changes that impact help files or NAMESPACE)
3. load_all()
4. Run some examples interactively.
5. test() (or test_active_file())
6. check()

# GOAL 

3 exported functions total
* put all metrics in one function (lm / glm)
* put all coeff + confint + se in one function (lm / glm / lme4)
- something to output "best" model by a given criteria

# TODO

- currently on ch. ? of book 
- throw error if nothing is passed in 
- function to get betas + C.I. + coeff
- look at R style guide
- check what type of glm it is? can you compare different glm types? 
- unit tests 
  - what's the best way to test a dataframe output or a plot output? 
