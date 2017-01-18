rmse <- function (predicted, actual){
  rmse <- sqrt(mean((predicted - actual)^2, na.rm=T))
  return(rmse)
}