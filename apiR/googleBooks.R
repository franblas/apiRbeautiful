# ----------------------------------------------
# Google Books 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

GoogleBooks <- proto(expr={
  
  className <- "Google Books"
  helpUrl <- "https://developers.google.com/books/docs/v1/using#RetrievingVolume"
  apiUrl <- "https://www.googleapis.com/books/v1/"
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
  
  searchByAuthor <- function(., author="", limit=10){
    author <- .$correctSpace(author)
    str <- paste(apiUrl,"volumes?q=inauthor:", author, "&maxResults=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$items$volumeInfo)
    if("description" %in% colnames(x) && "categories" %in% colnames(x)){
      y <- x[,c("title","publishedDate","canonicalVolumeLink","description","pageCount","categories")]
    }
    else{
      y <- x[,c("title","publishedDate","canonicalVolumeLink","pageCount")]
    }
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  searchBook <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"volumes?q=", text, "&maxResults=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$items$volumeInfo)
    if("description" %in% colnames(x) && "categories" %in% colnames(x)){
      y <- x[,c("title","publishedDate","canonicalVolumeLink","description","pageCount","categories")]
    }
    else{
      y <- x[,c("title","publishedDate","canonicalVolumeLink","pageCount")]
    }
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
})#end of proto 