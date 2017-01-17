#################
#Wij doen MEE   #
#17 January 2017#
#################

# Calculate the max ndvi values for the selected month 
#in the defined region (either 'municipality' or 'province')

max_ndvi <- function(month, region){
  if (region == "municipality"){ 
    max <- max(month, na.rm=T)
    row <- subset(ndvi_municip, month == max)
    municip <- row$NAME_2
    print(municip)
    return(municip)
  } else if (region == "province"){
    max <- max(month, na.rm=T)
    row <- subset(ndvi_province, month == max)
    province <- row$NAME_1
    print(province)
    return(province)
  } else
    warning("Input should be 'municipality' or 'province'")
  
}
