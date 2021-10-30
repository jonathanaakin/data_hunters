library(dplyr)
library(ggplot2)
library(openintro)

plot_data <- mlb_teams %>% 
  filter(league_winner != "") %>% 
  group_by(year, league_winner) %>% 
  summarize(mean_era = mean(earned_run_average))

ggplot(plot_data, aes(year, mean_era, color = league_winner))+
  geom_line()+
  theme_minimal()+
  labs(
    title = "Average ERA by year",
    x = "Year",
    y = "Average ERA",
    color = "League Winner"
  )+
  scale_color_manual(labels = c("No", "Yes"),
                     values = c(IMSCOL["pink","full"], IMSCOL["blue","full"]))

ggsave(here::here("/data_set_week"))

  
