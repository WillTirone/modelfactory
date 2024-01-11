#' Combine model metrics for any number of lm, glm, and lmer models
#'
#' `stack_metrics()` calculates basic model metrics like MSE for the models
#' passed in, then stacks them in a dataframe for comparison. This supports
#' lm, glm, and lmer models, and different metrics are calculated for each.
#' This does not perform model selection based on a given criteria, but it
#' makes the tedious task of, say, comparing R-squared across several models
#' very easy.
#'
#' @param ... models to summarize and combine.
#'
#' @return A [data.frame()] that includes a variety of evaluation metrics.
#' @export
#'
#' @examples
#' lm_1 = lm(mpg ~ cyl + disp + hp, data = mtcars)
#' lm_2 = lm(mpg ~ hp + drat + wt, data = mtcars)
#' lm_3 = lm(mpg ~ ., data = mtcars)
#' lm_combined = stack_metrics(lm_1, lm_2, lm_3)
#'
#' glm_1 = glm(vs ~ drat + hp, data = mtcars)
#' glm_2 = glm(vs ~ wt + qsec, data = mtcars)
#' glm_3 = glm(vs ~ ., data = mtcars)
#' glm_combined = stack_metrics(glm_1, glm_2, glm_3)
#'
#' lmer_1 = lme4::lmer(Sepal.Length ~ (1 | Species), data = iris)
#' lmer_2 = lme4::lmer(Sepal.Length ~ (1 | Species) + Petal.Length, data = iris)
#' lmer_combined = stack_metrics(lmer_1, lmer_2)
stack_metrics = function(...) {

  models = list(...)
  model_sum = lapply(models, summary)

  if (length(models) == 0) {
    stop("No models were passed into the function.")
  }

  # make sure every item is an lm summary
  if (model_type_check(model_sum, "summary.lm")) {
    # combine everything into a tibble to output
    tibble::tibble(
      model = as.character(get_metric(model_sum, "call")),
      r.squared = get_metric(model_sum, "r.squared"),
      adj.r.squared = get_metric(model_sum, "adj.r.squared"),
      MSE = calc_metric(model_sum, "MSE"),
      RMSE = calc_metric(model_sum, "RMSE"),
      MAE = calc_metric(model_sum, "MAE")
    )
  } else if (model_type_check(model_sum, "summary.glm")) {
    # data frame but for glm objects
    tibble::tibble(
      model = as.character(get_metric(model_sum, "call")),
      deviance = get_metric(model_sum, "deviance"),
      AIC = get_metric(model_sum, "aic"),
      BIC = unlist(lapply(models, function(x) stats::BIC(x)))
    )
  } else if (model_type_check(model_sum, "summary.merMod")) {
    # data frame but for lmer objects
    tibble::tibble(
      model = as.character(get_metric(model_sum, "call")),
      deviance = -2 * get_metric(model_sum, "logLik"),
      AIC = unlist(lapply(models, function(x) stats::AIC(x))),
      BIC = unlist(lapply(models, function(x) stats::BIC(x)))
    )
  } else {
    stop("Model type not yet supported! Make sure all of your models are of
         the same type.")
  }
}

#' Stack coefficents, confidence intervals, and standard errors
#'
#' `stack_coeff()` takes several lm or glm models, pulls out their coefficients,
#' standard errors, and confidence intervals, and stacks everything into a
#' [tibble()] for easy comparison across models.
#'
#' @param ... models to summarize and combine.
#'
#' @return A [tibble()] with coefficients, C.I.s., and standard errors.
#' @export
#'
#' @examples
#' lm_1 = lm(mpg ~ cyl + disp + hp, data = mtcars)
#' lm_2 = lm(mpg ~ hp + drat + wt, data = mtcars)
#' lm_3 = lm(mpg ~ ., data = mtcars)
#' lm_combined = stack_coeff(lm_1, lm_2, lm_3)
#'
#' glm_1 = glm(vs ~ drat + hp, data = mtcars)
#' glm_2 = glm(vs ~ wt + qsec, data = mtcars)
#' glm_3 = glm(vs ~ ., data = mtcars)
#' glm_combined = stack_coeff(glm_1, glm_2, glm_3)
stack_coeff = function(...) {

  models = list(...)
  output = data.frame()

  # think about making model_type_check more flexible if model isn't a summary()
  if (length(models) == 0) {
    stop("No models were passed into the function.")
  } else if (!model_type_check(models, "lm") &
             !(all(unlist(lapply(models, function(x) class(x)[1] == "glm"))))
  ) {
    stop("Model type not yet supported!")
  }

  # iteratively build dataframes since we're not summarizing them individually
  for (model in models) {
    temp_data = data.frame(model_name = as.character(model$call)[2],
                               summary(model)$coef[, c('Estimate',
                                                   'Std. Error',
                                                   'Pr(>|t|)')],
                           stats::confint(model)) |>
      tibble::rownames_to_column(var = 'coefficient')
    output = dplyr::bind_rows(output, temp_data)
  }

  new_names = c("coefficient", "model_name", "estimate", "std_error",
            "p_value", "lb_2.5", "ub_97.5")
  names(output) = new_names
  output = tibble::tibble(output)

  return(output)
}



