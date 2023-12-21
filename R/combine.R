#' A function to combine models
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
  output = unlist(lapply(model_sum,
                         function(lm_summary) lm_summary$r.squared))

  return(output)
}
