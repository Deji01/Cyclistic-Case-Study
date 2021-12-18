### Cyclistic_Case_Study_Full_Year_Analysis ###

# This analysis is based on the Cyclistic case study 

# # # # # # # # # # # # # # # # # # # # # # # 
# Install required packages
# tidyverse for data import and wrangling
# lubridate for date functions
# ggplot for visualization
# # # # # # # # # # # # # # # # # # # # # # #  

library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)  #helps visualize data
getwd() #displays your working directory
setwd("~/Downloads/Google Data Analytics Professional Certificate/CASE STUDY I/FILES/CSV") #sets your working directory to simplify calls to data ... 

#=====================
# STEP 1: COLLECT DATA
#=====================
# Uploading All Divvy datasets (csv files) here
dec_2020 <- read.csv('202012-divvy-tripdata.csv')
jan_2021 <- read.csv('202101-divvy-tripdata.csv')
feb_2021 <- read.csv('202102-divvy-tripdata.csv')
mar_2021 <- read.csv('202103-divvy-tripdata.csv')
apr_2021 <- read.csv('202104-divvy-tripdata.csv')
may_2021 <- read.csv('202105-divvy-tripdata.csv')
jun_2021 <- read.csv('202106-divvy-tripdata.csv')
jul_2021 <- read.csv('202107-divvy-tripdata.csv')
aug_2021 <- read.csv('202108-divvy-tripdata.csv')
sep_2021 <- read.csv('202109-divvy-tripdata.csv')
oct_2021 <- read.csv('202110-divvy-tripdata.csv')
nov_2021 <- read.csv('202111-divvy-tripdata.csv')

#====================================================
# STEP 2: WRANGLE DATA AND COMBINE INTO A SINGLE FILE
#====================================================
# Comparing column names each of the files
# While the names don't have to be in the same order, they DO need to match perfectly before we can use a command to join them into one file
colnames(dec_2020)
colnames(jan_2021)
colnames(feb_2021)
colnames(mar_2021)
colnames(apr_2021)
colnames(may_2021)
colnames(jun_2021)
colnames(jul_2021)
colnames(aug_2021)
colnames(sep_2021)
colnames(oct_2021)
colnames(nov_2021)

# Inspecting the dataframes to look for irregularities
str(dec_2020)
str(jan_2021)
str(feb_2021)
str(mar_2021)
str(apr_2021)
str(may_2021)
str(jun_2021)
str(jul_2021)
str(aug_2021)
str(sep_2021)
str(oct_2021)
str(nov_2021)

# Converting ride_length to character so that they can stack correctly
jan_2021 <-  mutate(jan_2021, ride_length = as.character(ride_length))
feb_2021 <-  mutate(feb_2021, ride_length = as.character(ride_length))
mar_2021 <-  mutate(mar_2021, ride_length = as.character(ride_length))
apr_2021 <-  mutate(apr_2021, ride_length = as.character(ride_length))
may_2021 <-  mutate(may_2021, ride_length = as.character(ride_length))
jun_2021 <-  mutate(jun_2021, ride_length = as.character(ride_length))
jul_2021 <-  mutate(jul_2021, ride_length = as.character(ride_length))
aug_2021 <-  mutate(aug_2021, ride_length = as.character(ride_length))
sep_2021 <-  mutate(sep_2021, ride_length = as.character(ride_length))
oct_2021 <-  mutate(oct_2021, ride_length = as.character(ride_length))
nov_2021 <-  mutate(nov_2021, ride_length = as.character(ride_length))

dec_2020$date <- as.Date(dec_2020$started_at)
jan_2021$date <- as.Date(jan_2021$started_at)
feb_2021$date <- as.Date(feb_2021$started_at)
mar_2021$date <- as.Date(mar_2021$started_at)
apr_2021$date <- as.Date(apr_2021$started_at)
may_2021$date <- as.Date(may_2021$started_at)
jun_2021$date <- as.Date(jun_2021$started_at)
jul_2021$date <- as.Date(jul_2021$started_at)
aug_2021$date <- as.Date(aug_2021$started_at)
sep_2021$date <- as.Date(sep_2021$started_at)
oct_2021$date <- as.Date(oct_2021$started_at)
nov_2021$date <- as.Date(nov_2021$started_at)
 
# Stacking the individual data frames into one big data frame
all_trips <- bind_rows(dec_2020, jan_2021, feb_2021, mar_2021, apr_2021, may_2021, jun_2021, jul_2021, aug_2021, sep_2021, oct_2021, nov_2021)

#======================================================
# STEP 3: CLEAN UP AND ADD DATA TO PREPARE FOR ANALYSIS
#======================================================
# Inspecting the newly created table.
colnames(all_trips)  #List of column names
nrow(all_trips)  #How many rows are in data frame?
dim(all_trips)  #Dimensions of the data frame?
head(all_trips)  #See the first 6 rows of data frame. 
tail(all_trips)  #See the last 6 rows of data frame.
str(all_trips)  #See list of columns and data types (numeric, character, etc)
summary(all_trips)  #Statistical summary of data. Mainly for numerics

# There are a few problems needed to be fixed:
# (1) The data can only be aggregated at the ride-level, which is too granular. We will want to add some additional columns of data -- such as day, month, year -- that provide additional opportunities to aggregate the data.
# (2) There are some rides where tripduration shows up as negative, including several hundred rides where Divvy took bikes out of circulation for Quality Control reasons. We will want to delete these rides.

# Let's see how many observations fall under each usertype
table(all_trips$member_casual)

# Let's see how many observations fall under each rideable_type
table(all_trips$rideable_type)

# Adding columns that list the date, month, day, and year of each ride
# This will allow for the aggregation of ride data for each month, day, or year ... before completing these operations we could only aggregate at the ride level
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")

# Add a "ride_length" calculation to all_trips (in seconds)
all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)

# Inspect the structure of the columns
str(all_trips)

# Convert "ride_length" from Factor to numeric so we can run calculations on the data
is.factor(all_trips$ride_length)
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

# Remove "bad" data
# The dataframe includes a few hundred entries when bikes were taken out of docks and checked for quality by Divvy or ride_length was negative
# Create a new version of the dataframe (v2) since data is being removed
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length<0),]

#=====================================
# STEP 4: CONDUCT DESCRIPTIVE ANALYSIS
#=====================================
# Descriptive analysis on ride_length (all figures in seconds)
mean(all_trips_v2$ride_length) #straight average (total ride length / rides)
median(all_trips_v2$ride_length) #midpoint number in the ascending array of ride lengths
max(all_trips_v2$ride_length) #longest ride
min(all_trips_v2$ride_length) #shortest ride

# You can condense the four lines above to one line using summary() on the specific attribute
summary(all_trips_v2$ride_length)

# Compare members and casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)

# Notice that the days of the week are out of order. Let's fix that.
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Now, let's run the average ride time by each day for members vs casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)

# analyze ridership data by type and weekday
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
  ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, weekday)								# sorts

# Let's visualize the number of rides by rider type
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

# Let's create a visualization for average duration
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")

#=================================================
# STEP 5: EXPORT SUMMARY FILE FOR FURTHER ANALYSIS
#=================================================
counts <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
write.csv(counts, file = '~/Downloads/Google Data Analytics Professional Certificate/CASE STUDY I/FILES/CSV/avg_ride_length.csv')