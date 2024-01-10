
# model set up ----------------------

# set up basic lm's to test properties of smelt()
lm_1 = stats::lm(mpg ~ cyl + disp + hp, data = mtcars)
lm_2 = stats::lm(mpg ~ hp + drat + wt, data = mtcars)
lm_3 = stats::lm(mpg ~ ., data = mtcars)
lm_combined = stack_metrics(lm_1, lm_2, lm_3)

# set up basic glm's to test properties of smelt()
glm_1 = stats::glm(vs ~ drat + hp, data = mtcars)
glm_2 = stats::glm(vs ~ wt + qsec, data = mtcars)
glm_3 = stats::glm(vs ~ ., data = mtcars)
glm_combined = stack_metrics(glm_1, glm_2, glm_3)

lmer_1 = lme4::lmer(Sepal.Length ~ (1 | Species), data = iris)
lmer_2 = lme4::lmer(Sepal.Length ~ (1 | Species) + Petal.Length, data = iris)
lmer_combined = stack_metrics(lmer_1, lmer_2)

# testing functions -------------------

test_that("dimension of output dataframe are correct", {
  shape = dim(lm_combined)
  expect_equal(shape, c(3,6))
})

test_that("output is correctly a dataframe", {
  expect_s3_class(lm_combined, 'data.frame')
  expect_s3_class(glm_combined, 'data.frame')
  expect_s3_class(lmer_combined, 'data.frame')
})

test_that("correct columns are returned", {
  expect_equal(names(lm_combined),
               c("model", "r.squared", "adj.r.squared", "MSE", "RMSE", "MAE"))
  expect_equal(names(glm_combined),
               c("model", "deviance", "AIC", "BIC"))
  expect_equal(names(lmer_combined),
               c("model", "deviance", "AIC", "BIC"))
})
