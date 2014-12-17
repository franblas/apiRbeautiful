# ----------------------------------------------
# Ebay
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Ebay <- proto(expr={
  
  className <- "Ebay"
  category <- "Shopping"
  helpUrl <- ""
  apiUrl <- "http://svcs.ebay.com/"
  apiKey <- ""
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
  
  search <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"", text, limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c()]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
})#end of proto 
