#################
#Assignment7    #
#Wij doen MEE   #
#Dillen and Rik #
#17 January 2017#
#################

#Clear environment
rm(list = ls())

#Load packages (please install if necessary)
library(rgdal)
library(raster)


#Source files
source("R/ndvi.R")
source("R/max_ndvi.R")
source("R/plot.R")


#Get data
dir.create("data")
download.file("https://raw.githubusercontent.com/GeoScripting-WUR/VectorRaster/gh-pages/data/MODIS.zip",
              "data/ndvi", method = "auto")
unzip("data/ndvi", exdir = "data")

nlMunicipality <- getData("GADM", country = "NLD", level = 2)
nlProvince <- getData("GADM", country = "NLD", level = 1)

#######################
### Actual commands ###
#######################

#Get and project the ndvi to projection of the municipality
ndvi <- format_ndvi("grd")

#Calculate the max ndvi for all municipalities (491 in total)
  #Get ndvi data for municipalities
ndvi_municip <- extract(ndvi, nlMunicipality, fun=mean, na.rm=T, sp=T)

  #Calculate max ndvi for January and August
January <- max_ndvi(ndvi_municip$January, "municipality")
August <- max_ndvi(ndvi_municip$August, "municipality")

  #Calculate yearly ndvi for all municipalities
ndvi_municip$Year <- (ndvi_municip$January + ndvi_municip$February + ndvi_municip$March + ndvi_municip$April +
                      ndvi_municip$May + ndvi_municip$June + ndvi_municip$July + ndvi_municip$August +
                      ndvi_municip$September + ndvi_municip$October + ndvi_municip$November + ndvi_municip$December)/12

  #Calculate max ndvi for the whole year for the municipalities
Year <- max_ndvi(ndvi_municip$Year, "municipality")

#Calculate the max ndvi for all Provinces (14 in total)
  #Get ndvi data for provinces
ndvi_province <- extract(ndvi, nlProvince, fun=mean, na.rm=T, sp=T)

  #Calculate max ndvi for January and August
January_province <- max_ndvi(ndvi_province$January, "province")
August_province <- max_ndvi(ndvi_province$August, "province")

  #Calculate yearly ndvi for all provinces
ndvi_province$Year <- (ndvi_province$January + ndvi_province$February + ndvi_province$March + ndvi_province$April +
                        ndvi_province$May + ndvi_province$June + ndvi_province$July + ndvi_province$August +
                        ndvi_province$September + ndvi_province$October + ndvi_province$November + ndvi_province$December)/12

  #Calculate max ndvi for the whole year for the provinces
Year_province <- max_ndvi(ndvi_province$Year, "province")

#Test wrong input for calculating the max ndvi
January <- max_ndvi(ndvi_municip$January, "Test wrong")

##############
### Output ###
##############

#Create plots of the calculated max ndvi values for munipalities and provinces
plotJan <- plot(ndvi_municip, "January", "municipality")
plotAug <- plot(ndvi_municip, "August", "municipality")
plotYear <- plot(ndvi_municip, "Year", "municipality")

plotJan_province <- plot(ndvi_province, "January", "province")
plotAug_province <- plot(ndvi_province, "August", "province")
plotYear_province <- plot(ndvi_province, "Year", "province")



