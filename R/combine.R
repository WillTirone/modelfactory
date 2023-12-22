
# internal function to get metrics from summary
get_metric = function(model_sum, metric) {
  output = unlist(lapply(model_sum, function(x) x[[metric]]))
  return(output)
}

# internal function to calculate metrics from summary
calc_metric = function(model_sum, calc) {

  if (calc == "MSE"){
    output = unlist(lapply(model_sum,
                           function(x) mean(x[['residuals']]^2)))
  } else if (calc == "RMSE") {
    output = unlist(lapply(model_sum,
                           function(x) sqrt(mean(x[['residuals']]^2))))
  } else if (calc == "MAE") {
    output = unlist(lapply(model_sum,
                           function(x) mean(abs(x[['residuals']]))))
  }
  return(output)
}

#' A function to combine models.
#'
#' @param ... list of models to summarize.
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

  # just checking one type, check to make sure all are lm in future
  if (class(models[[1]])[1] == 'lm'){
  # combine everything into a dataframe to output
  data.frame(model = as.character(get_metric(model_sum, 'call')),
                    r.squared = get_metric(model_sum, 'r.squared'),
                    adj.r.squared = get_metric(model_sum, 'adj.r.squared'),
                    MSE = calc_metric(model_sum, 'MSE'),
                    RMSE = calc_metric(model_sum, 'RMSE'),
                    MAE = calc_metric(model_sum, 'MAE'))
  } else {
    stop('Model type not yet supported!')
  }
}
