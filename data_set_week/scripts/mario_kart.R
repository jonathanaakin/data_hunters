library(ggplot2)
library(openintro)
library(dplyr)
library(broom)
library(patchwork)

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

ggsave(here::here("data_set_week/images/mario_kart_scatter.png"), bg = "white")

mod <- lm(diff_pr ~ n_bids, data = plot_data)
df <- augment(mod)
ggplot(df, aes(x = .fitted, y = .resid)) + 
  geom_point(color = IMSCOL["blue", "full"])+
  theme_minimal()+
  labs(
    title = "",
    x = "Fitted value", 
    y = "Residual"
  )+
  geom_hline(yintercept = 0)

ggsave(here::here("data_set_week/images/mario_kart_residuals.png"), bg = "white")

ggplot(df, aes(x = .resid))+
  geom_histogram(binwidth = 10, color = "white", fill = IMSCOL["blue", "full"])+
  theme_minimal()+
  labs(
    title = "",
    x = "Residual", 
    y = ""
  )

ggsave(here::here("data_set_week/images/mario_kart_residuals-histo.png"), bg = "white")


