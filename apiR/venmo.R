# --------------------------------------------
# Venmo
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# --------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Venmo <- proto(expr={
  
  className <- "Venmo"
  helpUrl <- "http://www.snip2code.com/Snippet/54422/Hit-venmo-public-feed-API-to-see-what-th"
  apiUrl <- "https://venmo.com/api/v5/"
  nbCall <- 0
  
  # Avoid caracter utf8
  avoidUTF8 <- function(.,text){
    res <- str_replace_all(text,"[^[:graph:]]"," ")
    return (res)
  }
  
  # Feed public
  getPublic <- function(.){
    str <- paste(apiUrl,"public", sep="")
    x <- as.data.frame(fromJSON(str))
    y <- .$avoidUTF8(x$data.message)
    yy <- .$avoidUTF8(x$data.permalink)
    .$nbCall <- .$nbCall + 1
    return (data.frame(message=y,link=yy))
  }
  
})#end of proto