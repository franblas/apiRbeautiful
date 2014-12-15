# ----------------------------------------------
# Open Street Map 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

OSM <- proto(expr={
  
  className <- "Open Street Map"
  category <- "Map"
  helpUrl <- "http://wiki.openstreetmap.org/wiki/API_v0.6"
  apiUrl <- "http://api.openstreetmap.org/api/0.6/"
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
  
  searchLatestNotes <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"notes/search.json?q=", text,"&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- data.frame()
    y <- t(as.data.frame(x$features.geometry$coordinates))
    y <- cbind(y,t(as.data.frame(t(x$features.properties$comments))))
    .$nbCall <- .$nbCall + 1
    return (y)   
  }
  
  search <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste("http://nominatim.openstreetmap.org/","search?q=", text,"&format=json&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("lat","lon","display_name","importance")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  
  
})#end of proto 
