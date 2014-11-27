# ----------------------------------------------
# Bitly 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

Bitly <- proto(expr={
  
  className <- "Bitly"
  helpUrl <- "http://dev.bitly.com/api.html"
  apiUrl <- "https://api-ssl.bitly.com/v3/"
  apiKey <- ""
  
  # Popular links
  getPopular <- function(.,nblimit=10){
    str <- paste(apiUrl,"highvalue?limit=",nblimit,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str))
    y <- x$data.values
    return (y)
  }
  
  # Number of clicks by domain for a link
  getRefDomains <- function(.,link="",nblimit=10){
    str <- paste(apiUrl,"link/referring_domains?link=",link,"&limit=",nblimit,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data$referring_domains)
    #y <- x$data.values
    return (x)
  }
  
  # Number of times a link is shortened
  getFrequencyShortened <- function(.,link){
    str <- paste(apiUrl,"link/encoders_count?link=",link,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data)
    y <- x$count
    return (y)
  }
  
  # Users who short the link
  getUserShortened <- function(.,link,limit=10){
    str <- paste(apiUrl,"link/encoders_by_count?link=",link,"&limit=",limit,"&access_token=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$data$encoders_by_count)
    y <- x[1:3]
    return (y)
  }
  
})#end of proto 