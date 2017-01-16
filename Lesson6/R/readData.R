

readData <- function(dsn_path){
  readOGR(dsn_path, layer=ogrListLayers(dsn_path))
}