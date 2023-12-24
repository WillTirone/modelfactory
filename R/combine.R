source("R/helpers.R")

#' A function to calculate and combine model metrics for any number of
#' lm models.
#'
#' @param ... list of lm models to summarize.
#'
#' @return output
#' @export
#'
#' @examples
#' lm_1 = lm(mpg ~ cyl + disp + hp, data = mtcars)
#' lm_2 = lm(mpg ~ cyl + wt + drat, data = mtcars)
#' smelt(lm_1, lm_2)
smelt = function(...) {

  models = list(...)
  model_sum = lapply(models, summary)

  # make sure every item is an lm summary
  if (all(unlist(lapply(model_sum, function(x) class(x) == "summary.lm")))){

  # combine everything into a dataframe to output
  data.frame(model = as.character(get_metric(model_sum, 'call')),
                    r.squared = get_metric(model_sum, 'r.squared'),
                    adj.r.squared = get_metric(model_sum, 'adj.r.squared'),
                    MSE = calc_metric(model_sum, 'MSE'),
                    RMSE = calc_metric(model_sum, 'RMSE'),
                    MAE = calc_metric(model_sum, 'MAE'))

  } else if (all(unlist(lapply(model_sum,
                               function(x) class(x) == "summary.glm")))) {

    # data frame but for glm objects
    data.frame(model = as.character(get_metric(model_sum, 'call')),
               deviance = get_metric(model_sum, 'deviance'),
               AIC = get_metric(model_sum, 'aic'),
               # may need to make a separate function for this
               BIC = unlist(lapply(models, function(x) stats::BIC(x))))

  } else {
    stop('Model type not yet supported!')
  }
}

