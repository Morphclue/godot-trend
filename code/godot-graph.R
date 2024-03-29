if (!require('pacman')) install.packages('pacman')
p_load(pacman, tidyverse, ggplot2, lubridate, plyr)

df <- read.csv('data/steamdb-godot.csv', sep = ';')
names(df)[1] <- 'DateTime'
names(df)[2] <- 'Apps'

timestamps <- parse_date_time(df$DateTime, orders = 'Ymd HMS', tz = 'GMT')
data <- table(floor_date(timestamps, "month"))
data <- data.frame(timestamps, df$Apps)
names(data)[1] <- 'Date'
names(data)[2] <- 'Count'

data$Date <- as.Date(data$Date, format = '%Y-%m-%d')

ggplot(data = data, aes(Date, group = 1)) +
  geom_line(aes(y = Count)) +
  ylab("# of apps") +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))