# ----------------------------------------------
# Ebay
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

Ebay <- proto(expr={
  
  className <- "Ebay"
  category <- "Shopping"
  helpUrl <- "http://developer.ebay.com/"
  apiUrl <- "http://svcs.ebay.com/"
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
  
  search <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste(apiUrl,"services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0&SECURITY-APPNAME=", .$apiKey, "&RESPONSE-DATA-FORMAT=json&keywords=", text, "&paginationInput.entriesPerPage=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$findItemsByKeywordsResponse$searchResult)
    y <- as.data.frame(x$item)
    if("itemId" %in% colnames(y)){
      y <- y[,c("itemId","title","primaryCategory","viewItemURL","location","sellingStatus")]
    }
    else{
      y <- data.frame(itemId="",title="",primaryCategory="",viewItemURL="",location="",sellingStatus="")
    }
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getMostWatched <- function(., limit=10){
    str <- paste(apiUrl,"MerchandisingService?OPERATION-NAME=getMostWatchedItems&SERVICE-NAME=MerchandisingService&CONSUMER-ID=", .$apiKey, "&RESPONSE-DATA-FORMAT=JSON&maxResults=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$getMostWatchedItemsResponse)
    x <- x[,4:ncol(x)]
    y <- x[,c("itemRecommendations.item.itemId","itemRecommendations.item.title","itemRecommendations.item.primaryCategoryName","itemRecommendations.item.country","itemRecommendations.item.buyItNowPrice","itemRecommendations.item.originalPrice","itemRecommendations.item.viewItemURL")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getSimilar <- function(., id="121187584160", limit=10){
    str <- paste(apiUrl,"MerchandisingService?OPERATION-NAME=getSimilarItems&SERVICE-NAME=MerchandisingService&CONSUMER-ID=", .$apiKey, "&RESPONSE-DATA-FORMAT=JSON&itemId=", id,"&maxResults=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$getSimilarItemsResponse)
    x <- x[,4:ncol(x)]
    y <- x[,c("itemRecommendations.item.title","itemRecommendations.item.primaryCategoryName","itemRecommendations.item.country","itemRecommendations.item.buyItNowPrice","itemRecommendations.item.viewItemURL")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getTopSelling <- function(., limit=10){
    str <- paste(apiUrl,"MerchandisingService?OPERATION-NAME=getTopSellingProducts&SERVICE-NAME=MerchandisingService&CONSUMER-ID=", .$apiKey, "&RESPONSE-DATA-FORMAT=JSON&maxResults=", limit, sep="")
    x <- as.data.frame(fromJSON(str)$getTopSellingProductsResponse)
    x <- x[,4:ncol(x)]
    y <- x[,c("productRecommendations.product.productId","productRecommendations.product.title","productRecommendations.product.reviewCount","productRecommendations.product.productURL")]
    .$nbCall <- .$nbCall + 1
    return (y)  
  }
  
  getPopularSearch <- function(., text="", limit=10){
    text <- .$correctSpace(text)
    str <- paste("http://open.api.ebay.com/","shopping?callname=FindPopularSearches&responseencoding=JSON&appid=", .$apiKey, "&siteid=0&version=531&QueryKeywords=", text, sep="")
    x <- as.data.frame(fromJSON(str)$PopularSearchResult)
    x <- x[,2:ncol(x)]
    .$nbCall <- .$nbCall + 1
    return (x)  
  }
  
})#end of proto 
