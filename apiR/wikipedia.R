# ------------------------------------------------
# Wikipedia 
# Necessite les librairies plyr,httr,jsonlite,proto
# ------------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Wikipedia <- proto(expr={
  
  className <- "Wikipedia"
  category <- "Data"
  helpUrl <- "http://en.wikipedia.org/w/api.php?action=help&modules=query"
  apiUrl <- "http://en.wikipedia.org/w/api.php?action=query&format=json&"
  nbCall <- 0
  
  # Correct space caracter for url
  correctSpace <- function(., word){
    x <- gsub(" ","%20",word, fixed=TRUE)
    return (x)
  } 
  
  # Find all words that link to a given word
  getLinkSphere <- function(., search="", nblimit=10){
    search <- .$correctSpace(search)
    str <- paste(apiUrl,"prop=linkshere&titles=",search,"&lhlimit=",nblimit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[, ncol(x)]
    .$nbCall <- .$nbCall + 1
    return (y) #list
  }
  
  # Returns all links from the given pages
  getLinks <- function(., search="", nblimit=10){
    search <- .$correctSpace(search)
    str <- paste(apiUrl,"prop=links&titles=",search,"&pllimit=",nblimit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[, ncol(x)]
    .$nbCall <- .$nbCall + 1
    return (y) 
  }
  
  # Reasearch pages by prefix
  searchByPrefix <- function(., search="", nblimit=10){
    search <- .$correctSpace(search)
    str <- paste(apiUrl,"list=prefixsearch&pssearch=",search,"&pslimit=",nblimit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[, (ncol(x)-1)]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # Research pages by text
  searchText <- function(.,search="",nblimit=10){
    search <- .$correctSpace(search)
    str <- paste(apiUrl,"list=search&srsearch=",search,"&srlimit=",nblimit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[, (ncol(x)-4)]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # Search pages around the given point
  searchGeo <- function(.,radius=1000,lat=0,long=0,nblimit=10){
    str <- paste(apiUrl,"list=geosearch&gsradius=",radius,"&gscoord=",lat,"|",long,"&gslimit=",nblimit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[, (ncol(x)-4)]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # Latest access to titles protected from creation
  latestProtected <- function(.,nblimit=10){
    str <- paste(apiUrl,"list=protectedtitles&ptlimit=",nblimit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[, (ncol(x)-2)]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # Latest changes 
  latestChanges <- function(.,nblimit=10){
    str <- paste(apiUrl,"list=recentchanges&rclimit=",nblimit, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x[, (ncol(x)-5)]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # List all categories the page(s) belong to
  ## categwiki <- as.data.frame(fromJSON("http://en.wikipedia.org/w/api.php?action=query&prop=categories&titles=big%20data&cllimit=500&format=json"))
  # Returns plain-text or limited HTML extracts of the given pages
  ## datawiki <- as.data.frame(fromJSON("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&titles=justice&exlimit=20&format=json"))
  # Get events from logs
  ## eventwiki <- as.data.frame(fromJSON("http://en.wikipedia.org/w/api.php?action=query&list=logevents&lelimit=500&format=json"))
  
})#end of proto