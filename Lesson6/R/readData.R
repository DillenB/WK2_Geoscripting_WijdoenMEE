###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 16 January 2017               ##
###################################

# Function to read the data into R.

readData <- function(dsn_path){
  readOGR(dsn_path, layer=ogrListLayers(dsn_path))
}