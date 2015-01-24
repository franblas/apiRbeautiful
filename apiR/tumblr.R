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
  
  # Correct space caracter for search
  correctSpace <- function(., word){
    x <- gsub(" ","+",word, fixed=TRUE)
    return (x)
  }
  
  searchByTag <- function(., text="", limit=10){
    text <- .$correctSpace(text)  
    str <- paste(apiUrl,"tagged?tag=", text,"&limit=", limit,"&api_key=", apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$response)
    if("post_url" %in% colnames(x)){
      y <- x[,c("post_url","slug","date","tags","note_count")]
    }
    else{
      y <- data.frame(post_url="",slug="",date="",tags="",note_count="") 
    }
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
})#end of proto 
