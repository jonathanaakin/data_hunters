library(dplyr)
library(ggplot2)
library(stringr)
library(lubridate)
library(forcats)
library(tidyr)
         
plot_data <- cpu %>% 
  mutate(level = case_when(
    str_detect(name, "Core i3") == TRUE ~ "three", 
    str_detect(name, "Ryzen 3") == TRUE ~ "three",
    str_detect(name, "Core i5") == TRUE ~ "five",
    str_detect(name, "Ryzen 5") == TRUE ~ "five",
    str_detect(name, "Core i7") == TRUE ~ "seven",
    str_detect(name, "Ryzen 7") == TRUE ~ "seven"
  )) %>% 
  type.convert(as.is = FALSE) %>% 
  filter(!is.na(level))%>%
  mutate(level = fct_relevel(level, c("three", "five", "seven"))) %>% 
  separate(released, into = c("year", "month", "day"), sep = "-") %>% 
  filter(as.numeric(year) >= 2017)

ggplot(plot_data, aes(level, base_clock, color = level))+
  geom_boxplot()+
  facet_wrap(~company)+
  stat_summary(fun = "mean", geom = "point", color = "black")

ggplot(plot_data, aes(base_clock, boost_clock, color = level, size = cores))+
  geom_point()+
  facet_wrap(~company+level)
