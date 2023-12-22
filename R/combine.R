#' Helper function to compute metrics from a list of models summmaries.
#'
#' @param model_sum list of model summary objects
#' @param metric metric from summary to return
#'
#' @return A numeric vector
#' @export
#'
#' @examples
#' # internal use only
get_metric = function(model_sum, metric) {

  # just checking ONE item for now
  # assumes they're all the same so check all at some point
  if (metric %in% names(model_sum[[1]])) {
    output = unlist(lapply(model_sum,
                           function(lm_summary) lm_summary[[metric]]))

  } else {
    stop(paste("Metric '", metric, "' not found in summary object."))
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

  # goal: include MAE, MSE, RMSE
  # second: output df with estimate, C.I., S.E.

  models = list(...)
  model_sum = lapply(models, summary)

  # combine everything into a dataframe to output
  output = data.frame(model = as.character(get_metric(model_sum, 'call')),
                      r.squared = get_metric(model_sum, 'r.squared'),
                      adj.r.squared = get_metric(model_sum, 'adj.r.squared'),

                      # this is what we want, but want in a function
                      MSE = unlist(lapply(model_sum,
                                          function(x) mean(x[['residuals']]^2))))

  return(output)
}
