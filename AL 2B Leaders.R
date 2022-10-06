library(tidyverse)
library(ggimage)

data <- read.csv("MLB Doubles Leaders from BOS - Sheet1.csv")
data <- data[1:50,]

data$Year <- as.numeric(substr(data$Year, start = 1, stop = 4))
data$Team <- rep_len("Not a Red Sox", nrow(data))
data$Team[grep("(BOS)", data$American.League)] <- "Red Sox Player"

graph <- data %>% 
  ggplot(aes(x = Year, y = X2B.1, group = Team, color = Team)) +
  geom_point() +
  labs(y = "Doubles by AL Leader(s)", title = "AL 2B Leaders by Red Sox or Not")
graph

ggsave("AL 2B Leaders by Red Sox or Not.png")

table(data$Team)
