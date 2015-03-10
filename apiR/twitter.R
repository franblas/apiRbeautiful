# ----------------------------------------------
# Twitter 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr,twitteR
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")
library("twitteR")

Twitter <- proto(expr={
  
  className <- "Twitter"
  category <- "Social"
  helpUrl <- "https://dev.twitter.com/rest/public"
  apiUrl <- "https://api.twitter.com/1.1/"
  apiKey <- ""
  apiSecret <- ""
  accessToken <- ""
  accessTokenSecret <- ""
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
  
  search <- function(.,word="",limit=50){
    temp <- twListToDF(searchTwitter(word,n=limit,lang="en"))
    url <- "https://twitter.com/"
    name <- temp$screenName
    iid <- temp$id
    u <- paste(url,name,"/statuses/",iid,sep="")
    temp$url <- u
    return (temp[,c('text','url','favoriteCount','retweetCount','latitude','longitude')])
  }
  
  getTrendsByCoord <- function(.,la=48.223703,lo=-1.691373){
    wo <- closestTrendLocations(lat=la,long=lo)$woeid
    return (getTrends(wo[,c('name','url','query')]))
  }
  
  getTrendsByCity <- function(.,city="San Francisco"){
    loc <- availableTrendLocations()
    wo <- loc[which(tolower(loc$name)==tolower(city)),]$woeid
    return (getTrends(wo[,c('name','url','query')]))
  }
  
})#end of proto 
 