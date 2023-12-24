# internal function to get metrics from summary. These are already
# available in the summary object.
get_metric <- function(model_sum, metric) {
  output <- unlist(lapply(model_sum, function(x) x[[metric]]))
  return(output)
}

# internal function to calculate metrics from summary.
# these are not freely available from the summary so have to calculate them
# instead of getting them directly.
calc_metric <- function(model_sum, calc) {
  if (calc == "MSE") {
    output <- unlist(lapply(
      model_sum,
      function(x) mean(x[["residuals"]]^2)
    ))
  } else if (calc == "RMSE") {
    output <- unlist(lapply(
      model_sum,
      function(x) sqrt(mean(x[["residuals"]]^2))
    ))
  } else if (calc == "MAE") {
    output <- unlist(lapply(
      model_sum,
      function(x) mean(abs(x[["residuals"]]))
    ))
  } else {
    stop("Metric type not supported!")
  }
  return(output)
}
