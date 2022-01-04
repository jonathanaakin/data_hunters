library(dplyr)
library(ggplot2)
library(stringr)
library(openintro)

plot_data <- earthquakes %>% 
  count(month) %>% 
  mutate(month = factor(month, levels=month.name))

ggplot(plot_data, aes(month, n))+
  geom_col(fill = IMSCOL["green", "full"])+
  theme_minimal()+
  labs(
    title = "Earthquakes by month", 
    x = "", 
    y = "Number of earthquakes"
  )+
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1)
  )

ggsave(here::here("data_set_week/images/earthquakes_paterno-plot-1.png"), bg = "white")

pd <- earthquakes %>% 
  mutate(
    year = as.character(year),
    decade = case_when(
    str_detect(year, "190") ~ "1900's",
    str_detect(year, "191") ~ "1910's",
    str_detect(year, "192") ~ "1920's",
    str_detect(year, "193") ~ "1930's",
    str_detect(year, "194") ~ "1940's",
    str_detect(year, "195") ~ "1950's",
    str_detect(year, "196") ~ "1960's",
    str_detect(year, "197") ~ "1970's",
    str_detect(year, "198") ~ "1980's",
    str_detect(year, "199") ~ "1990's"
  ))

ggplot(pd, aes(richter, decade))+
  geom_boxplot(color = IMSCOL["green", "full"])+
  theme_minimal()+
  labs(
    title = "Earthquake magnitude by decade", 
    x = "Richter scale", 
    y = "Decade"
  )+
  stat_summary(fun = "mean", geom = "point", color = IMSCOL["pink", "full"])

ggsave(here::here("data_set_week/images/earthquakes_paterno-plot-2.png"), bg = "white")

ggplot(earthquakes, aes(richter))+
  geom_histogram(fill = IMSCOL["green", "full"], color = "white", binwidth = 0.25)+
  theme_minimal()+
  labs(
    title = "Earthquake strength", 
    subtitle = "Richter scale magnitudes",
    x = "",
    y = ""
  )

ggsave(here::here("data_set_week/images/earthquakes_paterno-plot-3.png"), bg = "white")
