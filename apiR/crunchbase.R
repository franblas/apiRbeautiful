# ----------------------------------------------
# Crunchbase 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")

Crunchbase <- proto(expr={
  
  className <- "Crunchbase"
  category <- "Data"
  helpUrl <- "https://developer.crunchbase.com/docs"
  apiUrl <- "http://api.crunchbase.com/v/2/"
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
  
  newOrganisations <- function(.){
    str <- paste(apiUrl,"organizations?user_key=", .$apiKey,"&order=created_at%20desc", sep="")
    x <- as.data.frame(fromJSON(str)$data$items)
    .$nbCall <- .$nbCall + 1
    return (x$name)  
  }
  
  updatedOrganizations <- function(.){
    str <- paste(apiUrl,"organizations?user_key=", .$apiKey,"&order=updated_at%20desc", sep="")
    x <- as.data.frame(fromJSON(str)$data$items)
    .$nbCall <- .$nbCall + 1
    return (x$name)  
  }
  
  searchOrganization <- function(.,text=""){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"organizations?user_key=", .$apiKey,"&query=", text, sep="")
    x <- as.data.frame(fromJSON(str)$data$items)
    .$nbCall <- .$nbCall + 1
    return (x$name)  
  }
  
  newPeople <- function(.){
    str <- paste(apiUrl,"people?user_key=", .$apiKey,"&sort=created_at%20desc", sep="")
    x <- as.data.frame(fromJSON(str)$data$items)
    .$nbCall <- .$nbCall + 1
    return (x$name)  
  }
  
  newProducts <- function(.){
    str <- paste(apiUrl,"products?user_key=", .$apiKey,"&sort=created_at%20desc", sep="")
    x <- as.data.frame(fromJSON(str)$data$items)
    .$nbCall <- .$nbCall + 1
    return (x$name)  
  }
  
})#end of proto 
