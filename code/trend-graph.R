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

godot <- csv_to_df('data/godot.csv')
unity <- csv_to_df('data/unity.csv')
merged <- data.frame(merge(godot, unity, by = 'Date', all = TRUE))

merged$Date <- as.Date(merged$Date, format = '%Y-%m-%d')
arrange(merged, Date)

ggplot(data = merged, aes(Date, group=1)) +
  geom_line(aes(y = Count.x, color='Godot')) +
  geom_line(aes(y = Count.y, color='Unity'))
