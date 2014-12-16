# ----------------------------------------------
# IMDB
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

IMDB <- proto(expr={
  
  className <- "IMDB"
  category <- "Movie"
  helpUrl <- "http://www.omdbapi.com/"
  apiUrl <- "http://www.imdb.com/xml/"
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
  
  searchName <- function(., text=""){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"find?json=1&q=", text, sep="")
    x <- fromJSON(str)
    names <- as.data.frame(x$name_popular)
    names2 <- as.data.frame(x$name_exact)
    names3 <- as.data.frame(x$name_substring)
    y <- data.frame()
    y <- rbind(y,names)
    y <- rbind(y,names2)
    y <- y$name
    .$nbCall <- .$nbCall + 1
    return (y)  
  }

  searchTitle <- function(., text=""){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"find?json=1&q=", text, sep="")
    x <- fromJSON(str)
    titles <- as.data.frame(x$title_popular)
    titles2 <- as.data.frame(x$title_exact)
    titles3 <- as.data.frame(x$title_substring)
    y <- data.frame()
    y <- rbind(y,titles)
    y <- rbind(y,titles2)
    y <- rbind(y,titles3)
    y <- y[,c("title","description")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  searchOmdb <- function(., text=""){
    text <- .$correctSpace(text)
    str <- paste("http://www.omdbapi.com/","?s=", text, sep="")
    x <- as.data.frame(fromJSON(str)$Search)
    y <- x[,c("Title","Year","Type")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
})#end of proto 
