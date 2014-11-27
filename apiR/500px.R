# ----------------------------------------------
# 500px 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

CinqCentPx <- proto(expr={
  
  className <- "500px"
  helpUrl <- "https://github.com/500px/api-documentation"
  apiUrl <- "https://api.500px.com/v1/"
  apiKey <- ""
  
  # Avoid caracter utf8
  avoidUTF8 <- function(.,text){
    res <- str_replace_all(text,"[^[:graph:]]"," ")
    return (res)
  }
  
  # Correct space caracter for url
  correctSpace <- function(., word){
    x <- gsub(" ","%20",word, fixed=TRUE)
    return (x)
  } 
  
  # Popular Pictures
  getPopular <- function(.,nblimit=10){
    str <- paste(apiUrl,"photos?feature=popular&rpp=",nblimit,"&consumer_key=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$photos)
    res1 <- .$avoidUTF8(x$name)
    res2 <- .$avoidUTF8(x$description)
    res3 <- .$avoidUTF8(x$latitude)
    res4 <- .$avoidUTF8(x$longitude)
    res5 <- .$avoidUTF8(x$image_url)
    res6 <- .$avoidUTF8(x$user$country)
    return (data.frame(title=res1,dexcription=res2,latitude=res3,longitude=res4,usercountry=res6,link=res5))
  }
  
  # Best rated Pictures
  getBestRated <- function(.,nblimit=10){
    str <- paste(apiUrl,"photos?feature=highest_rated&rpp=",nblimit,"&consumer_key=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$photos)
    res1 <- .$avoidUTF8(x$name)
    res2 <- .$avoidUTF8(x$description)
    res3 <- .$avoidUTF8(x$latitude)
    res4 <- .$avoidUTF8(x$longitude)
    res5 <- .$avoidUTF8(x$image_url)
    res6 <- .$avoidUTF8(x$user$country)
    return (data.frame(title=res1,dexcription=res2,latitude=res3,longitude=res4,usercountry=res6,link=res5))
  }
  
  # Fresh today Pictures
  getToday <- function(.,nblimit=10){
    str <- paste(apiUrl,"photos?feature=fresh_today&rpp=",nblimit,"&consumer_key=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$photos)
    res1 <- .$avoidUTF8(x$name)
    res2 <- .$avoidUTF8(x$description)
    res3 <- .$avoidUTF8(x$latitude)
    res4 <- .$avoidUTF8(x$longitude)
    res5 <- .$avoidUTF8(x$image_url)
    res6 <- .$avoidUTF8(x$user$country)
    return (data.frame(title=res1,dexcription=res2,latitude=res3,longitude=res4,usercountry=res6,link=res5))
  }
  
  # Search pictures
  searchPictures <- function(.,search="",nblimit=10){
    search <- .$correctSpace(search)
    str <- paste(apiUrl,"photos/search?term=",search,"&rpp=",nblimit,"&consumer_key=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$photos)
    res1 <- .$avoidUTF8(x$name)
    res2 <- .$avoidUTF8(x$description)
    res3 <- .$avoidUTF8(x$latitude)
    res4 <- .$avoidUTF8(x$longitude)
    res5 <- .$avoidUTF8(x$image_url)
    res6 <- .$avoidUTF8(x$user$country)
    return (data.frame(title=res1,dexcription=res2,latitude=res3,longitude=res4,usercountry=res6,link=res5))
  }
  
  # Get stories from blog
  getStories <- function(.,nblimit=10){
    str <- paste(apiUrl,"blogs?rpp=",nblimit,"&consumer_key=",.$apiKey, sep="")
    x <- as.data.frame(fromJSON(str)$blog_posts)
    res1 <- .$avoidUTF8(x$title)
    res2 <- .$avoidUTF8(x$user$country)
    res3 <- .$avoidUTF8(x$user$fullname)
    return (data.frame(title=res1,usercountry=res2,username=res3))
  }
  
})#end of proto