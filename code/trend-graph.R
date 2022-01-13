if (!require('pacman')) install.packages('pacman')
p_load(pacman, tidyverse, ggplot2, lubridate)

df <- read.csv('data/amulet.csv', header = FALSE)
names(df)[1] <- 'Game'
names(df)[2] <- 'Date'

# e.g. Mon, 22 Jan 2018 07:37:15 GMT
dates <- parse_date_time(df$Date, orders = 'dbYHMS', tz = 'GMT')
