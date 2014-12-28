# ----------------------------------------------
# Google trends 
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# ----------------------------------------------

library("stringr")
library("httr")
library("jsonlite")
library("plyr")
library("proto")
library("stringr")

GoogleTrends <- proto(expr={
  
  className <- "Google Trends"
  category <- "Data"
  helpUrl <- ""
  apiUrl <- "http://hawttrends.appspot.com/api/"
  nbCall <- 0
  
  country <- c("South Africa","Germany","Saudi Arabia","Argentina","Australia","Austria","Belgium","Brazil","Canada","Chilia","Colombia","South Corea","Denemark","Egypt","Spain","USA","Finland","France","Greece","Hong Kong","Hongria","India","Indonesia","Israel","Italia","Japan","Kenya","Malaisia","Mexico","Nigeria","Norway","Holland","Philippines","Poland","Portugal","Czech Republic","Roumania","UK","Russia","Singapour","Sweden","Switzerland","Taiwan","Thailand","Turkey","Ukraine","Vietnam")
  id <- c(40,15,36,30,8,44,41,18,13,38,32,23,49,29,26,1,50,16,48,10,45,3,19,6,27,4,37,34,21,52,51,17,25,31,47,43,39,9,14,5,42,46,12,33,24,35,28)
  countries <- as.data.frame(country)
  countries$id <- as.data.frame(id)
  
  # Avoid caracter utf8
  avoidUTF8 <- function(.,text){
    res <- str_replace_all(text,"[^[:graph:]]"," ")
    return (res)
  }
  
  
  # Trends
  getTrends <- function(.,name="USA"){
    str <- paste(apiUrl,"terms/", sep="")
    x <- as.data.frame(fromJSON(str))
    #y <- .$avoidUTF8(x$X23)
    idd <- .$countries$id[grep(name,.$countries$country),]
    column <- paste("X",idd,sep="")
    y <- .$avoidUTF8(x[[column]])
    .$nbCall <- .$nbCall + 1
    return (y)
  }
  
  
})#end of proto 