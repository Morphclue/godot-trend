if (!require('pacman')) install.packages('pacman')
p_load(pacman, tidyverse, ggplot2, lubridate, plyr)

csv_to_df <- function(file_name) {
  df <- read.csv(file_name, header = FALSE)
  names(df)[1] <- 'Game'
  names(df)[2] <- 'Date'

  # e.g. Mon, 22 Jan 2018 07:37:15 GMT
  timestamps <- parse_date_time(df$Date, orders = 'dbYHMS', tz = 'GMT')

  data <- table(floor_date(timestamps, "month"))
  data <- data.frame(data)
  names(data)[1] <- 'Date'
  names(data)[2] <- 'Count'

  data$Count <- cumsum(data$Count)
  return(data)
}

amulet <- csv_to_df('data/amulet.csv')

ggplot(data = amulet, aes(x = Date, y = Count, group = 1)) +
  geom_line()

