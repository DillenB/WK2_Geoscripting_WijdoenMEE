###################
# Exercise 8      #
# Wij doen MEE    #
# Rik & Dillen    #
# 18 January 2017 #
###################

rm(list=ls())

#Load libraries

library(raster)
library(rasterVis)
library(knitr)


#Load source files

source("R/rmse.R")


#Load data
load("data/GewataB1.rda")
load("data/GewataB2.rda")
load("data/GewataB3.rda")
load("data/GewataB4.rda")
load("data/GewataB5.rda")
load("data/GewataB7.rda")
load("data/vcfGewata.rda")
load("data/trainingPoly.rda")


#The loaded Landsat7 data
headings <- c("band1", "band2", "band3", "band4", "band5", "band7", "VCF")
all_uncut <- c(GewataB1, GewataB2, GewataB3, GewataB4, GewataB5, GewataB7,vcfGewata)
GewataBrick_uncut <- brick(all_uncut)
names(GewataBrick_uncut) <- headings


#Outliers cut off from the loaded Landsat7 data
GewataB1[GewataB1 > 750]  <- NA
GewataB2[GewataB2 > 1000]  <- NA
GewataB3[GewataB3 > 1250]  <- NA
GewataB4[GewataB4 > 4000]  <- NA
GewataB5[GewataB5 > 3500]  <- NA
GewataB7[GewataB7 > 2200]  <- NA
vcfGewata[vcfGewata > 100] <- NA

#Make the brick
all <- c(GewataB1, GewataB2, GewataB3, GewataB4, GewataB5, GewataB7,vcfGewata)
GewataBrick <- brick(all)
names(GewataBrick) <- headings

#Plot the pairs to study the correlation
pairs(GewataBrick)

#Build the model
df <- as.data.frame(getValues(GewataBrick))
vcfmodel <- lm(VCF ~ band1 + band2 + band3 + band4 + band5 + band7, data = df)
vcfpred_map <- predict(GewataBrick, model=vcfmodel)
summary(vcfmodel)
vcfpred_map[vcfpred_map < 0] <- NA

#plot the outcome of the model vs the actual data
par(mfrow=c(1,2))
plot(vcfpred_map, main = "Predicted VCF")
plot(vcfGewata, main = "Gewata VCF")

#levelplot of the above
levelplot(stack(vcfpred_map, vcfGewata), main=c("Predicted VCF","Gewata VCF"),
          col.regions=rev(grDevices::terrain.colors(100)), axes=T)

#calculate the RMSE
rmse_map <- rmse(vcfpred_map,vcfGewata)
rmse_avg <- rmse(as.data.frame(vcfpred_map),as.data.frame(vcfGewata))

#Plot the RMSE_map
par(mfrow=c(1,1))
plot(rmse_map, main="RMSE")

#Define the classes
trainingPoly@data$Code <- as.numeric(trainingPoly@data$Class)
classes <- rasterize(trainingPoly, rmse_map, field='Code')

#Calculate the RMSE for the classes
rmse_classes <- zonal(rmse_map, classes, "mean")
rownames(rmse_classes) <- c("Cropland", "Forest", "Wetlands")
rmse_classes
