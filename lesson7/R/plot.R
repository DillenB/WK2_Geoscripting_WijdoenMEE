#################
#Wij doen MEE   #
#17 January 2017#
#################

#Makes plots of the source output for the selected region with its average ndvi per chosen month

plot <- function(source, month, region){
  plot <- spplot(source, zcol = month, main = paste("Average", month, "NDVI for each", region), 
                 scales=list(draw=T))
  print(plot)
}

