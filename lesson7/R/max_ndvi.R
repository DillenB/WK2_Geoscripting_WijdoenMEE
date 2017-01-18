#################
#Wij doen MEE   #
#17 January 2017#
#################

# Calculate the max ndvi values for the selected month 
#in the defined region (either 'municipality' or 'province')

max_ndvi <- function(month, region){
  if (region == "municipality"){ 
    mmonth <- eval(parse(text=paste0("ndvi_municip$", month)))
    max <- max(mmonth, na.rm=T)
    row <- subset(ndvi_municip, mmonth == max)
    municip <- row$NAME_2
    print(municip)
    return(municip)
  } else if (region == "province"){
    pmonth <- eval(parse(text=paste0("ndvi_province$", month)))
    max <- max(pmonth, na.rm=T)
    row <- subset(ndvi_province, pmonth == max)
    province <- row$NAME_1
    print(province)
    return(province)
  } else
    warning("Input should be 'municipality' or 'province'")
  
}
