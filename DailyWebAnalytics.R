library(RGoogleAnalytics)

library(RCurl)
library(dplyr)
library(ggplot2)
library(scales) 
library(tidyr)

# working Directory and packages #
setwd("c:/Users/dhadley/Documents/GitHub/City_Web_Analytics/")


# # Generate the oauth_token object
# oauth_token <- Auth(client.id = "158458440150-pn993ueqskf8ph9k8tdd1vrdjjein8sp.apps.googleusercontent.com",
#                     client.secret = "wyHGCl9-MzL1RP3kormjuyYG")
# # Save the token object for future sessions
# save(oauth_token, file="./oauth_token")
# Load the token object
load("oauth_token")

ValidateToken(oauth_token)


# # This example assumes that a token object is already created
# # Create a list of Query Parameters
# query.list <- Init(start.date = "2014-11-28",
#                    end.date = "2014-12-04",
#                    dimensions = "ga:pageTitle",
#                    metrics = "ga:sessions,ga:pageviews",
#                    max.results = 1000,
#                    table.id = "ga:26776898")


# This example assumes that a token object is already created
# Create a list of Query Parameters
query.list <- Init(start.date = as.character(Sys.Date()-1),
                   end.date = as.character(Sys.Date()),
                   dimensions = "ga:pageTitle",
                   metrics = "ga:sessions,ga:pageviews",
                   max.results = 1000,
                   table.id = "ga:26776898")

# Create the query object
ga.query <- QueryBuilder(query.list)
# Fire the query to the Google Analytics API
ga.df <- GetReportData(ga.query, oauth_token)



####  Visualize ####

lime_green = "#2ecc71"
soft_blue = "#3498db"
pinkish_red = "#e74c3c"
purple = "#9b59b6"
teele = "#1abc9c"
nice_blue = "#2980b9"


my.theme <- 
  theme(#plot.background = element_rect(fill="white"), # Remove background
    panel.grid.major = element_blank(), # Remove gridlines
    # panel.grid.minor = element_blank(), # Remove more gridlines
    # panel.border = element_blank(), # Remove border
    # panel.background = element_blank(), # Remove more background
    axis.ticks = element_blank(), # Remove axis ticks
    axis.text=element_text(size=6), # Enlarge axis text font
    axis.title=element_text(size=8), # Enlarge axis title font
    plot.title=element_text(size=12) # Enlarge, left-align title
    ,axis.text.x = element_text(angle=60, hjust = 1) # Uncomment if X-axis unreadable 
  )


# dates
today <- Sys.Date()
yesterday <- today - 1


#### Top from last day #### 

ga.df$pageTitle <- gsub("| City of Somerville Website", "", ga.df$pageTitle)

# write.csv(ga.df, "K:/Somerstat/Common/Data/2015_Web_Analytics/data/LastTwentyFour.csv")

LastTwentyFour <- ga.df %>%
  filter(pageviews > 100) %>%
  filter(pageTitle != "City of Somerville, Massachusetts") 


ggplot(LastTwentyFour, aes(x=reorder(pageTitle, pageviews)  , y=pageviews)) + 
  geom_bar(stat = "identity", colour="white", fill=nice_blue) + 
  my.theme + ggtitle(paste("Top Web Views From Yesterday:", yesterday)) + xlab("City Webpage") +
  ylab("# of Unique Pageviews") + 
  scale_y_continuous(labels = comma) 

# ggsave(paste("./plots/scratch/", yesterday, "_LastTwentyFour.png", sep=""), dpi=300, width=5, height=5)
ggsave("./plots/LastTwentyFour.png", dpi=300, width=5, height=5)
# ggsave("K:/Somerstat/Common/Data/2015_Web_Analytics/plots/LastTwentyFour.png", dpi=300, width=5, height=5)



