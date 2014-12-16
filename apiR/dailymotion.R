# ----------------------------------------------
# Dailymotion
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Dailymotion <- proto(expr={
  
  className <- "Dailymotion"
  category <- "Video"
  helpUrl <- "http://www.programmableweb.com/news/how-to-use-dailymotion-api-to-leverage-video-search/how-to/2014/06/12"
  apiUrl <- "https://api.dailymotion.com/"
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

  searchVideos <- function(., text="",limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"videos?fields=title,views_total,bookmarks_total,comments_total,country,url,tags&sort=relevance&search=", text,"&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$list)
    .$nbCall <- .$nbCall + 1
    return (x)  
  }
  
  searchPlaylists <- function(., text="",limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"playlists?fields=name,description,videos_total&sort=relevance&search=", text,"&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$list)
    .$nbCall <- .$nbCall + 1
    return (x)  
  }
  
  searchGroups <- function(., text="",limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"groups?fields=name,description&sort=relevance&search=", text,"&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$list)
    .$nbCall <- .$nbCall + 1
    return (x)  
  }
  
})#end of proto 
