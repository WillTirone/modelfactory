#' Calculate and combine model metrics for any number of lm / glm / lmer models.
#'
#' @param ... A list of models to summarize and combine.
#'
#' @return A [data.frame()] that includes a variety of evaluation metrics.
#' @export
#'
#' @examples
#' lm_1 = lm(mpg ~ cyl + disp + hp, data = mtcars)
#' lm_2 = lm(mpg ~ hp + drat + wt, data = mtcars)
#' lm_3 = lm(mpg ~ ., data = mtcars)
#' lm_combined = smelt(lm_1, lm_2, lm_3)
#'
#' glm_1 = glm(vs ~ drat + hp, data = mtcars)
#' glm_2 = glm(vs ~ wt + qsec, data = mtcars)
#' glm_3 = glm(vs ~ ., data = mtcars)
#' glm_combined = smelt(glm_1, glm_2, glm_3)
smelt = function(...) {

  models = list(...)
  model_sum = lapply(models, summary)

  # make sure every item is an lm summary
  if (model_type_check(model_sum, "summary.lm")) {
    # combine everything into a dataframe to output
    data.frame(
      model = as.character(get_metric(model_sum, "call")),
      r.squared = get_metric(model_sum, "r.squared"),
      adj.r.squared = get_metric(model_sum, "adj.r.squared"),
      MSE = calc_metric(model_sum, "MSE"),
      RMSE = calc_metric(model_sum, "RMSE"),
      MAE = calc_metric(model_sum, "MAE")
    )
  } else if (model_type_check(model_sum, "summary.glm")) {
    # data frame but for glm objects
    data.frame(
      model = as.character(get_metric(model_sum, "call")),
      deviance = get_metric(model_sum, "deviance"),
      AIC = get_metric(model_sum, "aic"),
      BIC = unlist(lapply(models, function(x) stats::BIC(x)))
    )
  } else {
    stop("Model type not yet supported!")
  }
}

#' With several models, we want to compare their coefficients, confidence
#' intervals, and standard errors.
#'
#' @param ... A list of models to summarize and combine.
#'
#' @return A [data.frame()]
#' @export
#'
#' @examples
stack_coeff = function(...) {

  models = list(...)
  model_sum = lapply(models, summary)

  data.frame(
    model = as.character(get_metric(model_sum, "call")),
    coeff = get_metric(model_sum, 'coefficients')
  )
  #confint(lm_1)

}



