# ----------------------------------------------
# Instagram 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Instagram <- proto(expr={
  
  className <- "Instagram"
  category <- "Picture"
  helpUrl <- "https://instagram.com/developer/endpoints/"
  apiUrl <- "https://api.instagram.com/v1/"
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
  
  getPopular <- function(., limit=10){
    str <- paste(apiUrl,"media/popular?count=", limit, "&client_id=", .$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data)
    loc <- x$location
    com <- x$comments
    ca <- x$caption
    li <- x$likes
    y <- x[,c("link","filter","users_in_photo")]
    y$latitude <- loc$latitude
    y$longitude <- loc$longitude
    y$loc_name <- loc$name
    y$count_com <- com$count
    y$data_com <- com$data
    y$count_like <- li$count
    y$title <- ca$text
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  searchByCoordinates <- function(.,lat=48.858844,lon=2.294351,limit=10){
    str <- paste(apiUrl,"media/search?lat=", lat, "&lng=", lon,"&count=", limit, "&client_id=", .$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data)
    loc <- x$location
    com <- x$comments
    ca <- x$caption
    li <- x$likes
    y <- x[,c("link","filter","users_in_photo")]
    y$latitude <- loc$latitude
    y$longitude <- loc$longitude
    y$loc_name <- loc$name
    y$count_com <- com$count
    y$data_com <- com$data
    y$count_like <- li$count
    y$title <- ca$text
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getTags <- function(.,text=""){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"tags/search?q=", text, "&client_id=", .$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data)
    y <- x[,c("media_count","name")]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  searchLocations <- function(.,lat=48.858844,lon=2.294351,limit=10){
    str <- paste(apiUrl,"locations/search?lat=", lat, "&lng=", lon, "&count=", limit, "&client_id=", .$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data)
    y <- x[,c("name","latitude","longitude")]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  searchUsers <- function(.,text="",limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"users/search?q=", text, "&count=", limit, "&client_id=", .$apiKey, sep="")
    y <- x[,c("username","full_name","id","profile_picture")]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
})#end of proto 