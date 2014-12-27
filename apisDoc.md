# APIs

## Sumup

<table>
<thead>
<tr>
	<th>API name</th>
	<th>Category</th>
	<th>Need key ?</th>
</tr>
</thead>
<tbody>
<tr>
	<td>500 px</td>
	<td>Picture</td>
	<td>Yes</td>
</tr>
<tr>
	<td>9 Gag</td>
	<td>Social</td>
	<td>No</td>
</tr>
<tr>
	<td>Dailymotion</td>
	<td>Video</td>
	<td>No</td>
</tr>
<tr>
	<td>Delicious</td>
	<td>Social</td>
	<td>No</td>
</tr>
<tr>
	<td>Ebay</td>
	<td>Shopping</td>
	<td>Yes</td>
</tr>
<tr>
	<td>Eventbrite</td>
	<td>Event</td>
	<td>Yes</td>
</tr>
<tr>
	<td>GoogleBooks</td>
	<td>Book</td>
	<td>No</td>
</tr>
</tbody>
</table>

## 500px
### Dataframe
```
getPopular <- function(.,nblimit=10)       
```  
```
getBestReated <- function(.,nblimit=10)       
```  
```
getToday <- function(.,nblimit=10)       
```  
```
searchPictures <- function(.,search="",nblimit=10)       
```
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>title</td>
	<td>Name of the picture</td>
</tr>
<tr>
	<td>description</td>
	<td>Description of the picture</td>
</tr>
<tr>
	<td>latitude</td>
	<td>Latitude where the picture is taken</td>
</tr>
<tr>
	<td>longitude</td>
	<td>Longitude where the picture is taken</td>
</tr>
<tr>
	<td>link</td>
	<td>Url of the picture</td>
</tr>
<tr>
	<td>usercountry</td>
	<td>Original country of the user</td>
</tr>
</tbody>
</table>

### Dataframe 2
```
getStories <- function(.,nblimit=10)       
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>title</td>
	<td>Name of the picture</td>
</tr>
<tr>
	<td>usercountry</td>
	<td>Original country of the user</td>
</tr>
<tr>
	<td>username</td>
	<td>Full name of the user</td>
</tr>
</tbody>
</table>

## 9 Gag
### Dataframe
```
getTrend <- function(.)
```  
```
getHot <- function(.)
```
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>title</td>
	<td>Name of the article</td>
</tr>
<tr>
	<td>description</td>
	<td>Description of the article</td>
</tr>
</tbody>
</table>

## Dailymotion
### Dataframe
```
searchVideos <- function(., text="",limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>title</td>
	<td>Name of the video</td>
</tr>
<tr>
	<td>views_total</td>
	<td>Total views for the video</td>
</tr>
<tr>
	<td>bookmarks_total</td>
	<td>Total number of bookmarks for the video</td>
</tr>
<tr>
	<td>comments_total</td>
	<td>Total number of comments for the video</td>
</tr>
<tr>
	<td>country</td>
	<td>Original country of the video</td>
</tr>
<tr>
	<td>url</td>
	<td>Url of the video</td>
</tr>
<tr>
	<td>tags</td>
	<td>Words associated with the video</td>
</tr>
</tbody>
</table>
### Dataframe 2
```
searchPlaylists <- function(., text="",limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>name</td>
	<td>Name of the playlist</td>
</tr>
<tr>
	<td>description</td>
	<td>Description of the playlist</td>
</tr>
<tr>
	<td>videos_total</td>
	<td>Total number of videos into the playlist</td>
</tr>
</tbody>
</table>
### Dataframe 3
```
searchGroups <- function(., text="",limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>name</td>
	<td>Name of the group</td>
</tr>
<tr>
	<td>description</td>
	<td>Description of the group</td>
</tr>
</tbody>
</table>
## Delicious
### Dataframe
```
search <- function(., text="", limit=10)
```  
```
getRecent <- function(., limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>d</td>
	<td>Title of the link</td>
</tr>
<tr>
	<td>u</td>
	<td>Url of the link</td>
</tr>
<tr>
	<td>t</td>
	<td>Tags for the link</td>
</tr>
</tbody>
</table>
## Ebay
### Dataframe
```
search <- function(., text="", limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>itemId</td>
	<td>Id of the item</td>
</tr>
<tr>
	<td>title</td>
	<td>Name of the announce</td>
</tr>
<tr>
	<td>primaryCategory</td>
	<td>Category of the item</td>
</tr>
<tr>
	<td>viewItemURL</td>
	<td>Url of the announce</td>
</tr>
<tr>
	<td>location</td>
	<td>Location of the announce</td>
</tr>
<tr>
	<td>sellingStatus</td>
	<td>Price of the item</td>
</tr>
</tbody>
</table>
### Dataframe 2
```
getMostWatched <- function(., limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>itemRecommendations.item.itemId</td>
	<td>Id of the item</td>
</tr>
<tr>
	<td>itemRecommendations.item.title</td>
	<td>Name of the announce</td>
</tr>
<tr>
	<td>itemRecommendations.item.primaryCategoryName</td>
	<td>Category of the item</td>
</tr>
<tr>
	<td>itemRecommendations.item.viewItemURL</td>
	<td>Url of the announce</td>
</tr>
<tr>
	<td>itemRecommendations.item.country</td>
	<td>Original country of the announce</td>
</tr>
<tr>
	<td>itemRecommendations.item.buyItNowPrice</td>
	<td>Price of the item</td>
</tr>
<tr>
	<td>itemRecommendations.item.originalPrice</td>
	<td>riginal price of the item</td>
</tr>
</tbody>
</table>
### Dataframe 3
```
getSimilar <- function(., id="121187584160", limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>itemRecommendations.item.title</td>
	<td>Name of the announce</td>
</tr>
<tr>
	<td>itemRecommendations.item.primaryCategoryName</td>
	<td>Category of the item</td>
</tr>
<tr>
	<td>itemRecommendations.item.viewItemURL</td>
	<td>Url of the announce</td>
</tr>
<tr>
	<td>itemRecommendations.item.country</td>
	<td>Original country of the announce</td>
</tr>
<tr>
	<td>itemRecommendations.item.buyItNowPrice</td>
	<td>Price of the item</td>
</tr>
</tbody>
</table>
### Dataframe 4
```
getTopSelling <- function(., limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>productRecommendations.product</td>
	<td>Id of the product</td>
</tr>
<tr>
	<td>productRecommendations.product.title</td>
	<td>Title of the announce</td>
</tr>
<tr>
	<td>productRecommendations.product.reviewCount</td>
	<td>Number of view</td>
</tr>
<tr>
	<td>productRecommendations.product.productURL</td>
	<td>Url of the product</td>
</tr>
</tbody>
</table>
### Dataframe 5
```
getPopularSearch <- function(., text="", limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>AlternativeSearches</td>
	<td>Alternatives search for a given keyword</td>
</tr>
<tr>
	<td>RelatedSearches</td>
	<td>Related search for a given keyword</td>
</tr>
</tbody>
</table>
## Eventbrite
### Dataframe
```
searchEvents <- function(., text="")
```  
```
getPopularEvents <- function(.)
```  
```
getEventsCity <- function(., text="")
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>name</td>
	<td>Title of the event</td>
</tr>
<tr>
	<td>category</td>
	<td>Category of the event</td>
</tr>
<tr>
	<td>latitude</td>
	<td>Latitude of the event</td>
</tr>
<tr>
	<td>longitude</td>
	<td>Longitude of the event</td>
</tr>
<tr>
	<td>num_past_events</td>
	<td>Number of past events for the given group</td>
</tr>
<tr>
	<td>num_future_events</td>
	<td>Number of future events for the given group</td>
</tr>
<tr>
	<td>description</td>
	<td>Description of the event</td>
</tr>
</tbody>
</table>
## Google Books
### Dataframe
```
searchByAuthor <- function(., author="", limit=10)
```  
```
searchBook <- function(., text="", limit=10)
```  
<table>
<thead>
<tr>
	<th>Column</th>
	<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
	<td>title</td>
	<td>Title of the book</td>
</tr>
<tr>
	<td>publishedDate</td>
	<td>Date of the book</td>
</tr>
<tr>
	<td>canonicalVolumeLink</td>
	<td>Url of the book</td>
</tr>
<tr>
	<td>pageCount</td>
	<td>Number of pages</td>
</tr>
</tbody>
</table>

