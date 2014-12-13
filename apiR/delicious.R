# ----------------------------------------------
# Delicious 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Delicious <- proto(expr={
  
  className <- "Delicious"
  category <- "Social"
  helpUrl <- "https://delicious.com/rss"
  apiUrl <- "http://feeds.delicious.com/v2/json/"
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
  
  getRecent <- function(., limit=10){
    str <- paste(apiUrl,"recent?count=", limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("d","u","t")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  search <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"tag/", text, "?count=", limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("d","u","t")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
})#end of proto 