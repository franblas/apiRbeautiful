
library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

source("delicious.R")
source("wikipedia.R")
source("reddit.R")
source("googleTrends.R")
source("osm.R")
source("panoramio.R")
source("dailymotion.R")
source("rubyGems.R")
source("tumblr.R")
source("vine.R")
source("googleBooks.R")

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

superTrends <- function(){
  list <- GoogleTrends$country
  m <- 0
  list3 <- list()
  for(i in 1:length(list)){
    list2 <- GoogleTrends$getTrends(list[i])
    for(j in 1:length(list2)){
      list2[j] <- trim(list2[j])
      if(nchar(list2[j])>2){
        list3[m] <- list2[j]
        m <- m + 1
      }
    }
  }
  return(list3)
}

listWiki1 <- function(word="",limit=100){
  list <- Wikipedia$getLinkSphere(word,nblimit=limit)
  list2 <- Wikipedia$getLinks(word,nblimit=limit)
  for(j in 1:length(list)){
    if(grepl(":",list[j])){
      list[j] <- sub(".*:", "", list[j])
      list[j] <- sub(":", "", list[j])
    }  
  }
  for(k in 1:length(list2)){
    if(grepl(":",list2[k])){
      list2[k] <- sub(".*:", "", list2[k])
      list2[k] <- sub(":", "", list2[k])
    } 
  }
  list <- list[!is.na(list)]
  list2 <- list2[!is.na(list2)]
  list <- list[list != ""]
  list2 <- list2[list2 != ""]
  
  if(length(list)==0){
    list3 <- list2
  }else{
    
    if(length(list2)>=length(list)){
      list3 <- list()
      ii <- 0
      for(l in 1:length(list2)){
        for(m in 1:length(list)){
          if(grepl(toString(list2[m]),toString(list[l]),fixed=TRUE)){
            list3[ii] <- list[l]
            ii <- ii + 1
          }
        }
      }
    }
    if(length(list2)<length(list)){
      list3 <- list()
      ii <- 0
      for(l in 1:length(list)){
        for(m in 1:length(list2)){
          if(grepl(toString(list[l]),toString(list2[m]),fixed=TRUE)){
            list3[ii] <- list2[m]
            ii <- ii + 1
          }
        }
      }
    }
  }
  
  if(length(list3)==0 && length(list)!=0){
    list3 <- list  
  }
  
  return(list3) 
}

superListWiki <- function(word="yop",limit=500){
  list1 <- listWiki1(word,limit)
  list3 <- list()
  if(length(list1)<=15){
    list2 <- list()
    for(i in 1:length(list1)){
      list2[[i]] <- listWiki1(list1[i])
    }
    m <- 0
    for(j in 1:length(list2)){
      for(k in 1:length(list2[[j]])){
        list3[m] <- list2[[j]][k]
        m <- m + 1
      }
    }
  }else{
    list3 <- list1
  }
  return(list3)
}

superOSMFrame <- function(words=list()){
  df <- OSM$getCoordinatesCity(toString(words[[1]]))
  for(i in 2:length(words)){
    df <- rbind(df,OSM$getCoordinatesCity(toString(words[[i]])))
  }
  toBeRemoved <- which(df$lat=="")
  df <- df[-toBeRemoved,]
  return(df)
}

superWikiRadius <- function(words=list()){
  dfCoord <- superOSMFrame(words)
  list2 <- list()
  list3 <- list()
  m <- 0
  for(j in 1:length(dfCoord$lat)){
    lat2 <- factor(as.list(dfCoord$lat)[[j]])
    lon2 <- factor(as.list(dfCoord$lon)[[j]])
    list2 <- Wikipedia$searchGeo(lat=lat2,long=lon2)
    if(length(list2)!=0){
      for(k in 1:length(list2)){
        list3[m] <- list2[k]
        m <- m + 1
      } 
    }  
  }
 return(list3)
}

superRedditFrame <- function(words=list(),nblimit=10){
  df <- Reddit$searchArticle(words[[1]],limit=nblimit)
  for(i in 2:length(words)){
    df <- rbind(df,Reddit$searchArticle(words[[i]],limit=nblimit))
  }
  return(df)
}

superDeliciousFrame <- function(words=list(),nblimit=10){
  df <- Delicious$search(toString(words[[1]]),limit=nblimit)
  for(i in 2:length(words)){
    df <- rbind(df,Delicious$search(toString(words[[i]]),limit=nblimit))
  }
  toBeRemoved <- which(df$u=="")
  df <- df[-toBeRemoved,]
  return(df)
}

superImdbFrame <- function(words=list()){
  df <- IMDB$searchTitle(toString(words[[1]]))
  for(i in 2:length(words)){
    df <- rbind(df,IMDB$searchTitle(toString(words[[i]])))
  }
  return(df)
}

superPanoramio <- function(words=list()){
  dfCoord <- superOSMFrame(words)
  lat2 <- factor(as.list(dfCoord$lat)[[1]])
  lon2 <- factor(as.list(dfCoord$lon)[[1]])
  df <- Panoramio$getPhotosArea(latitude=lat2, longitude=lon2)
  for(j in 2:length(words)){
    lat2 <- factor(as.list(dfCoord$lat)[[j]])
    lon2 <- factor(as.list(dfCoord$lon)[[j]])
    df <- rbind(df,Panoramio$getPhotosArea(latitude=lat2, longitude=lon2)) 
  }
  return(df)
}

superDailymotionFrame <- function(words=list()){
  df <- Dailymotion$searchVideos(toString(words[[1]]))
  for(i in 2:length(words)){
    df <- rbind(df,Dailymotion$searchVideos(toString(words[[i]])))
  }
  return(df)
}

superRubygemsFrame <- function(words=list()){
  df <- RubyGems$search(toString(words[[1]]))
  for(i in 2:length(words)){
    df <- rbind(df,RubyGems$search(toString(words[[i]])))
  }
  toBeRemoved <- which(df$name=="")
  df <- df[-toBeRemoved,]
  return(df)
}

superTumblrFrame <- function(words=list()){
  df <- Tumblr$searchByTag(toString(words[[1]]))
  for(i in 2:length(words)){
    df <- rbind(df,Tumblr$searchByTag(toString(words[[i]])))
  }
  toBeRemoved <- which(df$post_url=="")
  df <- df[-toBeRemoved,]
  return(df)
}

superVineFrame <- function(words=list()){
  words[[1]] <- iconv(toString(words[[1]]),to='ASCII//TRANSLIT')
  splitword <- strsplit(toString(words[[1]]), " ")
  df <- Vine$searchByTag(toString(splitword[[1]][1]))
  for(j in 2:length(splitword)){
    df <- rbind(df,Vine$searchByTag(toString(splitword[[1]][j])))
  }
  for(i in 2:length(words)){
    words[[i]] <- iconv(toString(words[[i]]),to='ASCII//TRANSLIT')
    print(toString(words[[i]]))
    splitword <- strsplit(toString(words[[i]]), " ")
    for(k in 1:length(splitword)){
      df <- rbind(df,Vine$searchByTag(toString(splitword[[1]][k])))
    }
  }
  toBeRemoved <- which(df$link=="")
  df <- df[-toBeRemoved,]
  return(df)
}

superBooksFrame <- function(words=list()){
  df <- GoogleBooks$searchBook(toString(words[[1]]))
  for(i in 2:length(words)){
    df <- rbind(df,GoogleBooks$searchBook(toString(words[[i]])))
  }
  toBeRemoved <- which(df$title=="")
  df <- df[-toBeRemoved,]
  return(df)
}

#############################################################################

#trends <- superTrends()
#words <- superListWiki(word="apple")
#radius <- superWikiRadius(trends)

#DeliTrends <- superDeliciousFrame(words=trends)
#DeliApple <- superDeliciousFrame(words)
#DeliRadius <- superDeliciousFrame(words=radius)
#imdbTrends <- superImdbFrame(words=trends)
