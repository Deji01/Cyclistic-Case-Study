# Importing libraries
library(tidyverse)
library(janitor)
library(lubridate)

# Read in data
df <- read_csv('C:/Users/SOLA/Downloads/Dejavu/Google Data Analytics Professional Certificate/CASE STUDY I/FILES/SQL/combined_dataset.csv')

# Full column specification
spec(df)

# Preview of the data
head(df)

# Remove empty row and columns 
df <- janitor :: remove_empty(df,which = c('cols'))
df <- janitor :: remove_empty(df,which = c('rows'))

# Format the datetime columns
df$started_at <- lubridate::ymd_hms(df$started_at)
df$ended_at <- lubridate::ymd_hms(df$ended_at)

# Parse time
df$start_time<- lubridate::hms(df$started_at)
df$end_time <- lubridate::hms(df$ended_at)

# Create hour column
df$start_hour <- lubridate::hour(df$started_at)
df$end_hour <- lubridate::hour(df$ended_at)

# Create duration column
df$trip_duration <- difftime(df$started_at, df$ended_at)

# Create trip_date column
df$start_date <- as.Date(df$started_at)
df$end_date <- as.Date(df$ended_at)

# Check size of dataframe
dim(df)

gc()
memory.limit(9999999999)
# Export data
write.csv(df, file='tidy_rides.csv', row.names=FALSE)

