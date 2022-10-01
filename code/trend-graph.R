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

unity <- csv_to_df('data/unity.csv')
construct <- csv_to_df('data/construct.csv')
gamemaker <- csv_to_df('data/gamemaker.csv')
godot <- csv_to_df('data/godot.csv')
twine <- csv_to_df('data/twine.csv')
bitsy <- csv_to_df('data/bitsy.csv')
unreal <- csv_to_df('data/unreal-engine.csv')
rpgmaker <- csv_to_df('data/rpg-maker.csv')
pico <- csv_to_df('data/pico-8.csv')
renpy <- csv_to_df('data/renpy.csv')

merged <- list(unity, construct, gamemaker, godot, twine, bitsy, unreal, rpgmaker, pico, renpy)
merged <- data.frame(merged %>% reduce(full_join, by = 'Date'))

merged$Date <- as.Date(merged$Date, format = '%Y-%m-%d')
merged <- arrange(merged, Date)
colnames(merged) <- c('Date', 'unity', 'construct', 'gamemaker', 'godot', 'twine', 'bitsy', 'unreal', 'rpgmaker', 'pico', 'renpy')

ggplot(data = merged, aes(Date, group = 1)) +
  geom_line(aes(y = unity, color = 'Unity')) +
  geom_line(aes(y = construct, color = 'Construct')) +
  geom_line(aes(y = gamemaker, color = 'GameMaker: Studio')) +
  geom_line(aes(y = godot, color = 'Godot')) +
  geom_line(aes(y = twine, color = 'Twine')) +
  geom_line(aes(y = bitsy, color = 'Bitsy')) +
  geom_line(aes(y = unreal, color = 'Unreal Engine')) +
  geom_line(aes(y = rpgmaker, color = 'RPG Maker')) +
  geom_line(aes(y = pico, color = 'PICO-8')) +
  geom_line(aes(y = renpy, color = "Ren'Py")) +
  ylab("# of projects")
