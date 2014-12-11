# ----------------------------------------------
# 9gag 
# Necessite les librairies plyr,httr,jsonlite,proto
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

NineGag <- proto(expr={
  
  className <- "9Gag"
  helpUrl <- "https://github.com/k3min/infinigag"
  apiUrl <- "http://infinigag.eu01.aws.af.cm/"
  nbCall <- 0
  
  # Get trends
  getTrend <- function(.){
    str <- paste(apiUrl,"trending/0", sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,3]
    yy <- x[,5]
    .$nbCall <- .$nbCall + 1
    return (data.frame(description=y,link=yy))
  }
  
  # Get hot topics
  getHot <- function(.){
    str <- paste(apiUrl,"hot/0", sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,3]
    yy <- x[,5]
    .$nbCall <- .$nbCall + 1
    return (data.frame(description=y,link=yy))
  }
  
})#end of proto