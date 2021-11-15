library(ggplot2)
library(dplyr)
library(openintro)
library(moderndive)

View(lego_sample)

ggplot(lego_sample, aes(pieces, amazon_price))+
  geom_point(color = IMSCOL["blue", "full"], alpha = 0.5)+
  labs(
    title = "Amazon Price v # of Pieces in Lego Sets", 
    x = "Pieces in the Set", 
    y = "Price on Amazon (US$)"
  )+
  theme_minimal()

get_correlation(data = lego_sample, formula = amazon_price ~ pieces)
