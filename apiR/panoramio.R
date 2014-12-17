# ----------------------------------------------
# Panoramio
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Panoramio <- proto(expr={
  
  className <- "Panoramio"
  category <- "Picture"
  helpUrl <- "http://www.panoramio.com/api/data/api.html"
  apiUrl <- "http://www.panoramio.com/map/"
  nbCall <- 0
  
  # Avoid caracter utf8
  avoidUTF8 <- function(.,text){
    res <- str_replace_all(text,"[^[:graph:]]"," ")
    return (res)
  }
  
  # Correct space caracter for search
  correctSpace <- function(., word){
    x <- gsub(" ","+",word, fixed=TRUE)
    return (x)
  }
  
  getPopularWorldPhotos <- function(., limit=10){
    str <- paste(apiUrl,"get_panoramas.php?order=popularity&set=public&from=0&to=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$photos)
    y <- x[,c("latitude","longitude","owner_name","photo_file_url","photo_title","upload_date")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getPhotosArea <- function(., latitude=0, longitude=0, range=5, limit=10){
    minx <- longitude - range
    maxx <- longitude + range
    miny <- latitude - range
    maxy <- latitude + range
    str <- paste(apiUrl,"get_panoramas.php?order=popularity&set=public","&minx=", minx,"&miny=", miny,"&maxx=", maxx,"&maxy=", maxy, "&from=0&to=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$photos)
    y <- x[,c("latitude","longitude","owner_name","photo_file_url","photo_title","upload_date")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
})#end of proto 
