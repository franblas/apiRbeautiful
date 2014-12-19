# ----------------------------------------------
# Soundcloud
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Soundcloud <- proto(expr={
  
  className <- "Soundcloud"
  category <- "Music"
  helpUrl <- "https://developers.soundcloud.com/docs/api/guide"
  apiUrl <- "http://api.soundcloud.com/"
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
  
  searchTracks <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"tracks.json?client_id=", .$apiKey, "&q=", text, "&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("title","download_count","favoritings_count","comment_count","genre","duration","tag_list","description","permalink_url")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  searchUsers <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"users?client_id=", .$apiKey, "&q=", text, "&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("username","country","full_name","description","city","website","track_count","followers_count")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  searchGroups <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"groups?client_id=", .$apiKey, "&q=", text, "&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("name","track_count","members_count","contributors_count","permalink_url","description")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getLatestComments <- function(., limit=10){
    str <- paste(apiUrl,"comments?client_id=", .$apiKey,"&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("track_id","body")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getInfosTrack <- function(., id="182242225"){
    str <- paste(apiUrl, "tracks/", id,"?client_id=", .$apiKey, sep="")
    x <- as.data.frame(t(fromJSON(str)))
    y <- x[,c("title","download_count","favoritings_count","comment_count","genre","duration","tag_list","description","permalink_url")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getLatestTracks <- function(., limit=10){
    str <- paste(apiUrl,"tracks.json?client_id=", .$apiKey,"&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[,c("title","download_count","favoritings_count","comment_count","genre","duration","tag_list","description","permalink_url")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
})#end of proto 
