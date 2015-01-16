# ----------------------------------------------
# Reddit 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Reddit <- proto(expr={
  
  className <- "Reddit"
  category <- "Social"
  helpUrl <- "http://www.reddit.com/dev/api"
  apiUrl <- "http://www.reddit.com/"
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
  
  searchArticle <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"search.json?q=", text, "&t=year&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$data$children$data)
    if("title" %in% colnames(x)){
      y <- x[,c("title","url","score","ups","num_comments","subreddit","selftext")]
    }
    else{
      y <- data.frame(title="",url="",score="",ups="",num_comments="",subreddit="",selftext="")
    }
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getHotTopics <- function(.,limit=10){
    str <- paste(apiUrl,"hot.json?limit=", limit=10, sep="")
    x <- as.data.frame(fromJSON(str)$data$children$data)
    y <- x[,c("title","url","score","ups","num_comments","subreddit","selftext")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getControversialTopics <- function(.,limit=10){
    str <- paste(apiUrl,"controversial.json?limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$data$children$data)
    y <- x[,c("title","url","score","ups","num_comments","subreddit","selftext")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getRandomTopics <- function(.){
    str <- paste(apiUrl,"random.json", sep="")
    x <- as.data.frame(fromJSON(str)$data$children[1])
    x <- x$data
    y <- x[,c("title","url","score","ups","num_comments","subreddit","selftext")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getPopularSubreddits <- function(.,limit=10){
    str <- paste(apiUrl,"subreddits/popular.json?limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$data$children)
    x <- x$data
    y <- x[,c("display_name","subscribers")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  searchSubreddits <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"subreddits/search.json?q=", text, "&limit=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$data$children)
    x <- x$data
    y <- x[,c("display_name","subscribers","title")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
})#end of proto 