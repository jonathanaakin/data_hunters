library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(openintro)
library(kableExtra)
library(patchwork)

#-------------------------------------------------------------------------------

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

# Show alternate cause of increase in boost clock with hyper threading
time_series <- consumer %>% 
  mutate(year_released = year(released)) %>% 
  count(year_released, hyper_threading) %>% 
  na.omit() %>% 
  group_by(year_released) %>% 
  mutate(prop = n/sum(n)) 

ggplot(time_series, aes(factor(year_released), prop, fill = hyper_threading))+
  geom_col(position = "dodge")+
  labs(
    title = "Proportion of processors with multithreading",
    subtitle = "by year released",
    x = "Year",
    y = "Number of Processors", 
    fill = "Multithreaded?"
  )+
  scale_fill_manual(values = c(IMSCOL["pink", "full"], IMSCOL["blue", "full"]), 
                     labels = c("No", "Yes"))+
  theme_minimal()

ggsave(here::here("data_set_week/images/cpu_time-series_col.png"))

plot_data_2 <- cpu %>% 
  group_by(process) %>% 
  summarize(mean_boost = mean(boost_clock, na.rm = TRUE)) %>% 
  filter(mean_boost > 2)

plot_1 <- ggplot(plot_data_2, aes(process, mean_boost))+
  geom_point(color = IMSCOL["blue", "full"])+
  labs(
    title = "Average boost clock increases as the size \nof the process node decreases",
    x = "Process Node Size (nm)",
    y = "Average Boost Clock (GHz)"
  )

plot_data_3 <- cpu %>% 
  mutate(year_released = year(released)) %>% 
  na.omit() %>% 
  group_by(year_released) %>% 
  summarize(mean_process = mean(process, na.rm = TRUE))

plot_2 <- ggplot(plot_data_3, aes(factor(year_released), mean_process))+
  geom_point(color = IMSCOL["blue", "full"])+
  labs(
    title = "Average process node size has been decreasing \nsteadily",
    x = "Year Released",
    y = "Average Process Node Size (nm)"
  )

plot_1 + plot_2 
  
plot_data_4 <- cpu %>%
  mutate(year_released = year(released),) %>% 
  na.omit() %>% 
  group_by(year_released) %>% 
  summarize(mean_process = mean(process, na.rm = TRUE),
            mean_boost = mean(boost_clock, na.rm = TRUE))

ggplot(plot_data_4, aes(factor(year_released), mean_process, size = mean_boost))+
  geom_point(color = IMSCOL["blue", "full"])+
  labs(
    title = "Average process node size has been decreasing steadily",
    x = "Year Released",
    y = "Average Process Node Size (nm)", 
    size = "Average Boost Clock (GHz)"
  )+
  theme_minimal()

ggsave(here::here("data_set_week/images/cpu_boost-node-year_scatter.png"))

ggplot(cpu, aes(factor(year(released)), process, size = boost_clock))+
  geom_jitter(color = IMSCOL["blue", "full"], alpha = 0.7)+
  labs(
    title = "The size of the process node has been decreasing over time in 
    conjunction with an increase in boost clock",
    x = "Year Released",
    y = "Process Node Size (nm)", 
    size = "Boost Clock (GHz)"
  )+
  theme_minimal()
