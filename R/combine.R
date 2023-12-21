#' Helper function to compute metrics from a list of models summmaries.
#'
#' @param model_sum list of model summary objects
#' @param metric desired metric to calculate
#'
#' @return A numeric vector
#' @export
#'
#' @examples
#' # internal use only
metric_calc = function(model_sum, metric) {
  # will want to add stuff to prevent invalid metrics being asked for
  output = unlist(lapply(model_sum, function(lm_summary) lm_summary[[metric]]))
  return(output)
}

#' A function to combine models. Making a change here to see the effect.
#'
#' @param ... list of models to summarize
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
  output = metric_calc(model_sum, 'r.squared')

  return(output)
}
