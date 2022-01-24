if (!require('pacman')) install.packages('pacman')
p_load(pacman, tidyverse, ggplot2, lubridate, plyr)

df <- read.csv('data/amulet.csv', header = FALSE)
names(df)[1] <- 'Game'
names(df)[2] <- 'Date'

# e.g. Mon, 22 Jan 2018 07:37:15 GMT
timestamps <- parse_date_time(df$Date, orders = 'dbYHMS', tz = 'GMT')

ggplot(df) +
  aes(x = floor_date(timestamps, "month")) +
  geom_bar()
