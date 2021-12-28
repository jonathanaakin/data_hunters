library(ggplot2)
library(openintro)
library(dplyr)

plot_data <- mariokart %>% 
  mutate(diff_pr = total_pr - start_pr - ship_pr)

ggplot(plot_data, aes(n_bids, diff_pr))+
  geom_point(color = IMSCOL["blue", "full"])+
  theme_minimal()+
  labs(
  title = "Predicting price increase in MarioKart ebay auctions",
  x = "Number of bids", 
  y = "Price increase ($US)"
  )

ggsave(here::here("data_set_week/images/mario_kart_scatter.png"))
