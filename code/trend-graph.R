if (!require('pacman')) install.packages('pacman')
p_load(pacman, tidyverse, ggplot2)

df <- read.csv('data/amulet.csv', header=FALSE)
names(df)[1] <- 'Game'
names(df)[2] <- 'Date'
