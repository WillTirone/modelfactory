% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/combine.R
\name{stack_metrics}
\alias{stack_metrics}
\title{Calculate and combine model metrics for any number of lm and glm models}
\usage{
stack_metrics(...)
}
\arguments{
\item{...}{models to summarize and combine.}
}
\value{
A \code{\link[=data.frame]{data.frame()}} that includes a variety of evaluation metrics.
}
\description{
\code{stack_metrics()} does some stuff that I will write more about later,
this is the description section.
}
\examples{
lm_1 = lm(mpg ~ cyl + disp + hp, data = mtcars)
lm_2 = lm(mpg ~ hp + drat + wt, data = mtcars)
lm_3 = lm(mpg ~ ., data = mtcars)
lm_combined = stack_metrics(lm_1, lm_2, lm_3)

glm_1 = glm(vs ~ drat + hp, data = mtcars)
glm_2 = glm(vs ~ wt + qsec, data = mtcars)
glm_3 = glm(vs ~ ., data = mtcars)
glm_combined = stack_metrics(glm_1, glm_2, glm_3)
}
