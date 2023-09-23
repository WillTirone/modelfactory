library(tidyverse)

combine_model = function(...) {
  model_list = list(...)

  lapply(model_list, function(lm_object) lm_object$coefficients)
}
