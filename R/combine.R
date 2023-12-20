lm_1 = lm(mpg ~ disp + hp + drat + wt, data = mtcars)
lm_2 = lm(mpg ~ disp + hp + drat, data = mtcars)
lm_3 = lm(mpg ~ disp + hp, data = mtcars)

smelt = function(...) {

  models = list(...)

  output = data.frame(

  )

  output = data.frame(model =
                        c(as.character(t$call)[2],
                          as.character(q$call)[2],
                          as.character(z$call)[2]),
                      R_squared =
                        c(t$r.squared,
                          q$r.squared,
                          z$r.squared)
  )
  return(output)
}

# feed in models
check = list(lm_1, lm_2, lm_3)

# apply summary
#summaries = lapply(check, summary)
#for (i in 1:length(summaries)) {
#  print(summaries[[i]]$r.squared)
#}
