

municip <- function(month, region){
  if (region == "municipality"){ 
    max <- max(month, na.rm=T)
    row <- subset(ndvi_municip, month == max)
    municip <- row$NAME_2
    print(municip)
    return(municip)
  } else if (region == "province"){
    max <- max(month, na.rm=T)
    row <- subset(ndvi_province, month == max)
    province <- row$NAME_2
    print(province)
    return(province)
  } else
    print("Input should be 'municipality' or 'province'")
  
}
