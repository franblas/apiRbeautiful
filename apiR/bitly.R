# ----------------------------------------------
# Bitly 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Bitly <- proto(expr={
  
  className <- "Bitly"
  helpUrl <- "http://dev.bitly.com/api.html"
  apiUrl <- "https://api-ssl.bitly.com/v3/"
  apiKey <- ""
  nbCall <- 0
  
  # Bid dataframe for popular links
#   getPopularExtend <- function(.,nblimit=10){
#     list <- .$getPopular(nblimit)
#     table <- data.frame()
#     for(LINK in list){
#       refdom <- .$getRefDomains(LINK,nblimit)
#       freqshort <- .$getFrequencyShortened(LINK)
#       usershort <- .$getUserShortened(LINK,nblimit)
#       clickcountry <- .$getClicksCountries(LINK,nblimit)
#       click <- .$getClicks(LINK,nblimit)
#       title <- .$getTitle(LINK)
#       url <- .$getRealUrl(LINK)
#       rbind(table,c(refdom,freqshort,usershort,clickcountry,click,title,url))
#     }
#     return (table)
#   }
  
  # Popular links
  getPopular <- function(.,nblimit=10){
    str <- paste(apiUrl,"highvalue?limit=",nblimit,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x$data.values
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # Number of clicks by domain for a link
  getRefDomains <- function(.,link="",nblimit=10){
    str <- paste(apiUrl,"link/referring_domains?link=",link,"&limit=",nblimit,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data$referring_domains)
    #y <- x$data.values
    .$nbCall <- .$nbCall + 1
    return (x)
  }
  
  # Number of times a link is shortened
  getFrequencyShortened <- function(.,link=""){
    str <- paste(apiUrl,"link/encoders_count?link=",link,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data)
    y <- x$count
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # Shortened frequency by user
  getUserShortened <- function(.,link="",limit=10){
    str <- paste(apiUrl,"link/encoders_by_count?link=",link,"&limit=",limit,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data$encoders_by_count)
    y <- x[1:3]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # Number of clicks by countries
  getClicksCountries <- function(.,link="",limit=10){
    str <- paste(apiUrl,"link/countries?link=",link,"&limit=",limit,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data$countries)
    #y <- x[1:3]
    .$nbCall <- .$nbCall + 1
    return (x)
  }
  
  # Number of clicks for a link
  getClicks <- function(.,link="",limit=10){
    str <- paste(apiUrl,"link/clicks?link=",link,"&limit=",limit,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data$link_clicks)
    y <- x[[1]]
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # Infos for a link
  getTitle <- function(.,link){
    str <- paste(apiUrl,"info?shortUrl=",link,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data$info)
    y <- x$title
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  # Get link expand
  getRealUrl <- function(.,link){
    str <- paste(apiUrl,"expand?shortUrl=",link,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data$expand)
    y <- x$long_url
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
})#end of proto 