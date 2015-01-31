library(httr)
library(jsonlite)

# Functions for retreiving leaderboard data and stream GPX data from Strava
# get_leaderboard takes a segment ID (unquoted) and an access token (quoted) as arguments
# get_stream takes a effort ID (unquoted) and an access token (quoted) as arguments

get_leaderboard <- function(id, access_token) {
  # Initial GET request and parsing JSON 
  data <- GET(paste0("https://www.strava.com/api/v3/segments/", id, "/leaderboard"), 
              add_headers(Authorization = paste0("Bearer ",access_token)), query = list(page = 1, per_page = 200))
  leaderboard <- fromJSON(toString(data))
  
  # Convert list to data frame
  df <- as.data.frame(leaderboard)
  
  # Convert distance from meters to miles
  df$miles <- df$entries.distance/1609.34
  
  df
}

get_stream <- function(id, access_token) {
  # Initial GET request and parsing JSON 
  data <- GET(paste0("https://www.strava.com/api/v3/segment_efforts/", id, "/streams/latlng"), 
              add_headers(Authorization = paste0("Bearer ",access_token)), query = list(resolution = "low"))
  leaderboard <- fromJSON(toString(data))
  
  # Convert list to data frame
  df <- as.data.frame(leaderboard)
  
  df
}