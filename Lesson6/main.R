###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 16 January 2017               ##
###################################

# load packages
# please install packages first if not installed yet:
library(rgdal)
library(sp)
library(rgeos)

# download data
#dir.create("data", showWarnings = F)
#download.file(url = "http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip", 
#              destfile = "data/railwaysfile", method = "auto")
#download.file(url = "http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip",
#              destfile = "data/placesfile", method = "auto")


# source files
source("R/toRD.R")
source("R/readData.R")


# actual commands
places <- readData("data/netherlands-places-shape")
railways <- readData("data/netherlands-railways-shape")

industrial <- railways[railways$type=="industrial",]

industrial_RD <- toRD(industrial)
places_RD <- toRD(places)

industbuf <- gBuffer(industrial_RD, byid=T, width = 1000)
intersection <- gIntersection(places_RD, industbuf, id=as.character(places_RD$osm_id), byid=T)
intplace <- places_RD[places_RD$osm_id == rownames(intersection@coords),]

#spplot, not as fancy as the normal plot
spplot(industbuf, zcol="type", fill=F, sp.layout=list(list(intplace, cex=2, pch=1, sp.text= "true", col="black"), 
                list(industrial_RD)), colorkey=F, main=paste(intplace$name)) 

#normal plot the buffer.
plot(industbuf, axes=T, main="Buffer around industrial railways in NL", col=rgb(0,1,0, alpha=0.5), xlim=c(134000, 137500))
plot(intplace, add=T, col="black", cex=2, pch=18)
plot(industrial_RD, add=T, col="gray70")
text(intplace@coords+100,paste(intplace$name))
legend("right", lty=1, lwd=6, c("Buffer","City", "Industrial railway"), 
       col=c(rgb(0,1,0, alpha=0.5), "black", "gray70"), title="Legend", 
       title.adj=0.1 ,bty="n")
legend("bottomright", c(paste("City in buffer:", intplace$name), paste("Population of city:", intplace$population)), bty="n")


# output, write to PNG
dir.create("output", showWarnings = F)
png("output/Assignment6.png")
plot(industbuf, axes=T, main="Buffer around industrial railways in NL", col=rgb(0,1,0, alpha=0.5), xlim=c(134000, 137500))
plot(intplace, add=T, col="black", cex=2, pch=18)
plot(industrial_RD, add=T, col="gray70")
text(intplace@coords+100,paste(intplace$name))
legend("right", lty=1, lwd=6, c("Buffer","City", "Industrial railway"), 
       col=c(rgb(0,1,0, alpha=0.5), "black", "gray70"), title="Legend", 
       title.adj=0.1 ,bty="n")
legend("bottomright", c(paste("City in buffer:", intplace$name), paste("Population of city:", intplace$population)), bty="n")
dev.off()

# City: utrecht, population: 100000 (see also the plot)