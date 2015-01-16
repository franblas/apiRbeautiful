# ----------------------------------------------
# Tumblr 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Tumblr <- proto(expr={
  
  className <- "Tumblr"
  category <- "Social"
  helpUrl <- "https://www.tumblr.com/docs/en/api/v2"
  apiUrl <- "http://api.tumblr.com/v2/"
  apiKey <- "fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4"
  nbCall <- 0
  
  # Avoid caracter utf8
  avoidUTF8 <- function(.,text){
    res <- str_replace_all(text,"[^[:graph:]]"," ")
    return (res)
  }
  
    searchByTag <- function(., text="", limit=10){
    str <- paste(apiUrl,"tagged?tag=", text,"&limit=", limit,"&api_key=", apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$response)
    y <- x[,c("post_url","slug","date","tags","note_count","source_url")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
})#end of proto 
