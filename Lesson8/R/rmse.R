###################
# Wij doen MEE    #
# 18 January 2017 #
###################

#Function to calculate the RMSE

rmse <- function (predicted, actual){
  rmse <- sqrt(mean((predicted - actual)^2, na.rm=T))
  return(rmse)
}