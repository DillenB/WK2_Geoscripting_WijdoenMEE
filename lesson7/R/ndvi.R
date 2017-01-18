#################
#Wij doen MEE   #
#17 January 2017#
#################

#Gets the correct file from the downloaded data and projects 
#the ndvi in the same projection as the municipalities/provinces

format_ndvi <- function(type){
  p <- glob2rx(paste0("*.", type))
  ndvi_file <- list.files(path = "Data", pattern=p, full.names=T)
  ndvi <- brick(ndvi_file)
  ndvi_m <- ndvi * 0.0001
  ndvi_m_pr <- projectRaster(ndvi_m, crs= projection(nlMunicipality))
  return(ndvi_m_pr)
}
