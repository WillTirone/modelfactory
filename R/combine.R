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

  if (metric %in% names(model_sum[[1]])){ # just checking ONE item for now
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
#' @param metric metric to calculate.
#'
#' @return output
#' @export
#'
#' @examples
#' lm_1 = lm(mpg ~ cyl + disp + hp, data = mtcars)
#' lm_2 = lm(mpg ~ cyl + wt + drat, data = mtcars)
#' smelt(lm_1, lm_2, metric = 'r.squared')
smelt = function(..., metric) {

  models = list(...)
  model_sum = lapply(models, summary)
  output = metric_calc(model_sum, metric)

  return(output)
}
