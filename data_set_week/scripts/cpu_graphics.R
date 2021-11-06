library(dplyr)
library(ggplot2)
library(stringr)
library(lubridate)
library(forcats)
library(tidyr)
library(openintro)
library(kableExtra)

#-------------------------------------------------------------------------------

core <- cpu %>% 
  filter(str_detect(name, "Core")==TRUE) %>% 
  separate(name, into = c("level", "series", "gen")) %>% 
  separate(gen, into = c("model", "suffix"), sep = "(?<=[0-9])(?=[A-Za-z])") %>%
  filter(series != "M" & series != "m3") %>% 
  mutate(gen = case_when(
    str_detect(model, "^2[0-9]{3}") ~ "Second",
    str_detect(model, "^3[0-9]{3}") ~ "Third",
    str_detect(model, "^4[0-9]{3}") ~ "Fourth",
    str_detect(model, "^5[0-9]{3}") ~ "Fifth",
    str_detect(model, "^6[0-9]{3}") ~ "Sixth",
    str_detect(model, "^7[0-9]{3}") ~ "Seventh",
    str_detect(model, "^8[0-9]{3}") ~ "Eighth",
    str_detect(model, "^9[0-9]{3}") ~ "Ninth",
    str_detect(model, "^10[0-9]{2,3}") ~ "Tenth",
    TRUE ~ "First"
  ),
  platform = case_when(
    str_detect(suffix, "U$") == TRUE ~ "Mobile",
    str_detect(suffix, "H$") == TRUE ~ "Mobile",
    str_detect(suffix, "H[:upper:]$") == TRUE ~ "Mobile",
    str_detect(suffix, "Y$") == TRUE ~ "Mobile",
    str_detect(suffix, "M$") == TRUE ~ "Mobile",
    str_detect(suffix, "MQ$") == TRUE ~ "Mobile",
    str_detect(suffix, "MX$") == TRUE ~ "Mobile",
    str_detect(suffix, "EQ$") == TRUE ~ "Mobile",
    str_detect(suffix, "G[:digit:]$") == TRUE ~ "Mobile",
    TRUE ~ "Desktop"
    )) %>% 
  mutate(gen = fct_relevel(gen, c("First", "Second", "Third" ,"Fourth", "Fifth",
                                  "Sixth", "Seventh", "Eighth", "Ninth","Tenth"
                                  )))

test <- core %>% 
  group_by(series,gen) %>% 
  summarize(mean = mean(cores))

ggplot(test, aes(gen, mean, fill = series))+
  geom_col(position = "dodge")

consumer <- cpu %>% 
  filter(threads <= 64 & socket != "PCIe x16") %>% 
  mutate(hyper_threading = case_when(
    threads > cores ~ "yes",
    threads == cores ~ "no"
  ),
  yr = year(released)) %>% 
  pivot_longer(cols = c("base_clock", "boost_clock"), names_to = "clock_type", 
               values_to = "clock_speed")

consumer_base <- consumer %>% 
  filter(clock_type == "base_clock")

consumer_boost <- consumer %>% 
  filter(clock_type == "boost_clock")

ggplot()+
  geom_boxplot(consumer, 
               mapping = aes(clock_speed, clock_type, color = hyper_threading))+
  stat_summary(fun = mean, geom = "point", col = "blue")+
  stat_summary(fun = mean, geom = "text", col = "blue", vjust = -1,
               aes(label = paste("Mean:", round(..x.., digits = 4))))+
  labs(
    title = "Are multithreaded processors faster?",
    x = "Processor Speed (GHz)", 
    y = "",
    color = "Multithreaded?"
  )+
  scale_y_discrete(labels = c("Boost clock", "Base clock"))+
  scale_color_manual(values = c(IMSCOL["pink", "full"], IMSCOL["blue", "full"]), 
                     labels = c("No", "Yes"))+
  theme_minimal()

ggsave(here::here("data_set_week/images/cpu_boxplot.png"))


# Hyper threading does not affect base clock but it does affect the boost clock!
# as anova
summary(aov(clock_speed ~ hyper_threading, data = consumer))

# as t-test

infer::t_test(consumer_base, clock_speed ~ hyper_threading,
              order = c("yes", "no")) %>% 
  kbl(linesep = "", booktabs = TRUE, align = "lcccccc", caption = "") %>%
  kable_styling(bootstrap_options = c("striped", "condensed"),
                latex_options = c("striped", "hold_position"))

infer::t_test(consumer_boost, clock_speed ~ hyper_threading,
              order = c("yes", "no"))%>% 
  kbl(linesep = "", booktabs = TRUE, align = "lcccccc", caption = "") %>%
  kable_styling(bootstrap_options = c("striped", "condensed"),
                latex_options = c("striped", "hold_position"))
