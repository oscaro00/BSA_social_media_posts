#library(tidyverse)
library(ggplot2)
library(ggimage)
library(scales)

# data from google sheet csv
data <- read.csv("2021 MLB Win % Per $ - Sheet2.csv")

# changing payroll column to numeric by removing commas
remove_commas <- function(x) {
  paste(unlist(strsplit(x, split = ",")), sep = "", collapse = "")
}
data$total_payroll <- as.numeric(vapply(data$total_payroll, remove_commas, character(1)))
# creates size value to increase image size
data$size <- rep(.09, 30)
# converts decimals to percents
data$win_percentage <- data$win_percentage * 100

# creates the geom_image graph
graph <- data %>% 
  ggplot(aes(x = total_payroll, y = win_percentage)) + 
  geom_image(aes(image = link2, size = I(size))) +
  scale_x_continuous(labels = dollar) +
  labs(x = "Total Payroll ($)", y = "Win Percentage (%)",
       title = "2021 MLB Win Percentage by Payroll") +
  theme_light()
graph

ggsave("2021 MLB Wins Per Dollar.png", plot = graph)
