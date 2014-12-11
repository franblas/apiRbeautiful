# ------------------------------------------------
# Vine 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ------------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Vine <- proto(expr={
  
  className <- "Vine"
  helpUrl <- "https://github.com/starlock/vino/wiki/API-Reference"
  apiUrl <- "https://api.vineapp.com/"
  nbCall <- 0
  
  # Avoid caracter utf8
  avoidUTF8 <- function(.,text){
    res <- str_replace_all(text,"[^[:graph:]]"," ")
    return (res)
  }
  
  # Get latest populat vine
  getPopular <- function(.){
    str <- paste(apiUrl,"timelines/popular", sep="")
    x <- as.data.frame(fromJSON(str)$data$records)
    y <- .$avoidUTF8(x$description) 
    yy <- .$avoidUTF8(x$permalinkUrl)
    .$nbCall <- .$nbCall + 1
    return (data.frame(description=y,link=yy))
  }
  
  # search vine by tag
  searchByTag <- function(., tag=""){
    str <- paste(apiUrl,"timelines/tags/",tag, sep="")
    x <- as.data.frame(fromJSON(str)$data$records)
    y <- .$avoidUTF8(x$description) 
    yy <- .$avoidUTF8(x$permalinkUrl)
    .$nbCall <- .$nbCall + 1
    return (data.frame(description=y,link=yy))
  }
  
})#end of proto 