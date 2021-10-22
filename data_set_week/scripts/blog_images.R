library(ggplot2)
library(dplyr)
library(openintro)
library(forcats)
library(tidyr)

# https://www.census.gov/quickfacts/MO
ggplot(plot_data, aes(race, proportion, fill = Group))+
  geom_col(position = "dodge")+
  labs(
    title = "Fatal Police Shootings in Missouri",
    subtitle = "Comparing Population and Shooting Victim Race Proportions",
    x = "Race", 
    y = "Proportion"
  )+
  theme_minimal(base_size = 13)+
  scale_fill_manual(labels = c("Shooting Victim", "General Population"), values = c(openintro::IMSCOL[1,1], openintro::IMSCOL[1,3])) 

plot_data <- fatal_police_shootings %>%
  mutate(race = case_when(
    race == "" ~ "Unknown", 
    TRUE ~ race
  )) %>% 
  filter(state == "MO") %>% 
  group_by(race) %>%
  summarize(n = n()) %>%
  mutate(freq = n / sum(n)*100) %>% 
  mutate(race = as_factor(race),
         pop = case_when(
           race == "A" ~ 2.2,
           race == "W" ~ 82.9,
           race == "B" ~ 11.8,
           race == "H" ~ 4.4,
           race == "Unknown" ~ 0
         ))

  plot_data$race <- recode_factor(plot_data$race, Unknown = "Unknown" , B = "Black", H = "Hispanic", W = "White", A = "Asian")

  plot_data <- plot_data %>% 
    pivot_longer(cols = c("freq", "pop"), names_to = "Group", values_to = "proportion")
  

  