# ----------------------------------------------
# EventBrite
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Eventbrite <- proto(expr={
  
  className <- "Eventbrite"
  category <- "Event"
  helpUrl <- "https://developer.eventbrite.com/docs/"
  apiUrl <- "https://www.eventbriteapi.com/v3/"
  apiKey <- ""
  nbCall <- 0
  
  # Avoid caracter utf8
  avoidUTF8 <- function(.,text){
    res <- str_replace_all(text,"[^[:graph:]]"," ")
    return (res)
  }
  
  # Correct space caracter for search
  correctSpace <- function(., word){
    x <- gsub(" ","%20",word, fixed=TRUE)
    return (x)
  }
  
  searchEvents <- function(., text=""){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"events/search/?token=", .$apiKey, "&q=", text, sep="")
    x <- as.data.frame(fromJSON(str)$events)
    x1 <- x$organizer
    x2 <- x$venue
    x3 <- x$category
    x4 <- x$name
    x5 <- x$description
    y <- as.data.frame(x$url)
    if(any(is.na(x3))){
      y$category <- data.frame(name="")
    }
    else{
      y$category <- x3$name
    }
    y$name <- x4$text
    y$latitude <- x2$address$latitude
    y$longitude <- x2$address$longitude
    y$num_past_events <- x1$num_past_events
    y$num_future_events <- x1$num_future_events
    y$description <- x5$text
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getPopularEvents <- function(.){
    str <- paste(apiUrl,"events/search/?token=", .$apiKey, "&popular=true", sep="")
    x <- as.data.frame(fromJSON(str)$events)
    x1 <- x$organizer
    x2 <- x$venue
    x3 <- x$category
    x4 <- x$name
    x5 <- x$description
    y <- as.data.frame(x$url)
    y$name <- x4$text
    y$category <- x3$name
    y$latitude <- x2$address$latitude
    y$longitude <- x2$address$longitude
    y$num_past_events <- x1$num_past_events
    y$num_future_events <- x1$num_future_events
    y$description <- x5$text
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getEventsCity <- function(., text=""){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"events/search/?token=", .$apiKey, "&venue.city=", text, sep="")
    x <- as.data.frame(fromJSON(str)$events)
    x1 <- x$organizer
    x2 <- x$venue
    x3 <- x$category
    x4 <- x$name
    x5 <- x$description
    y <- as.data.frame(x$url)
    y$name <- x4$text
    y$category <- x3$name
    y$latitude <- x2$address$latitude
    y$longitude <- x2$address$longitude
    y$num_past_events <- x1$num_past_events
    y$num_future_events <- x1$num_future_events
    y$description <- x5$text
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
})#end of proto 
