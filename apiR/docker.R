# ----------------------------------------------
# Docker 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")

Docker <- proto(expr={
  
  className <- "Docker"
  category <- "Code"
  helpUrl <- "https://docs.docker.com/reference/api/registry_api/"
  apiUrl <- "https://index.docker.io/v1/"
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
  
  search <- function(.,text="",limit=100){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"search?q=", text,"&n=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$result)
    y <- x[,c('name','star_count','description')]
    .$nbCall <- .$nbCall + 1
    return (y) 
  }
  
})#end of proto 
