library(RGoogleAnalytics)

# working Directory and packages #
setwd("c:/Users/dhadley/Documents/GitHub/City_Web_Analytics/")


# # Generate the oauth_token object
# oauth_token <- Auth(client.id = "158458440150-pn993ueqskf8ph9k8tdd1vrdjjein8sp.apps.googleusercontent.com",
#                     client.secret = "wyHGCl9-MzL1RP3kormjuyYG")
# # Save the token object for future sessions
# save(oauth_token, file="./oauth_token")
# Load the token object
load("oauth_token")


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




