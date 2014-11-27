# --------------------------------------------
# Venmo
# Necessite les librairies plyr,httr,jsonlite,proto,stringr
# --------------------------------------------

Venmo <- proto(expr={
  
  className <- "Venmo"
  helpUrl <- "http://www.snip2code.com/Snippet/54422/Hit-venmo-public-feed-API-to-see-what-th"
  apiUrl <- "https://venmo.com/api/v5/"
  
  # Avoid caracter utf8
  avoidUTF8 <- function(.,text){
    res <- str_replace_all(text,"[^[:graph:]]"," ")
    return (res)
  }
  
  # Feed public
  getPublic <- function(.){
    str <- paste(apiUrl,"public", sep="")
    x <- as.data.frame(fromJSON(str))
    y <- .$avoidUTF8(x$data.message)
    yy <- .$avoidUTF8(x$data.permalink)
    return (data.frame(message=y,link=yy))
  }
  
})#end of proto