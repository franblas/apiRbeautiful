# ----------------------------------------------
# RubyGems 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

RubyGems <- proto(expr={
  
  className <- "RubyGems"
  category <- "Code"
  helpUrl <- "http://guides.rubygems.org/rubygems-org-api/"
  apiUrl <- "https://rubygems.org/api/v1/"
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
  
  search <- function(., text=""){
    str <- paste(apiUrl,"search.json?query=", text, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("name","downloads","info","homepage_uri")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  latestAdded <- function(.){
    str <- paste(apiUrl,"activity/latest.json", sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("name","downloads","info","homepage_uri")]
    .$nbCall <- .$nbCall + 1
    return (y) 
  }
  
  latestUpdated <- function(.){
    str <- paste(apiUrl,"activity/just_updated.json", sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("name","downloads","info","homepage_uri")]
    .$nbCall <- .$nbCall + 1
    return (y) 
  }
  
  totalDownloadGems <- function(.){
    str <- paste(apiUrl,"downloads.json", sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[[1]]
    .$nbCall <- .$nbCall + 1
    return (y)   
  }
  
})#end of proto 
