library(dplyr)
library(ggplot2)
library(kableExtra)
library(openintro)

blizzard_salary %>%
  mutate(annual_salary = case_when(
    salary_type == "week" ~ current_salary * 52,
    salary_type == "hour" ~ current_salary * 40 * 52,
    TRUE ~ current_salary
  )) %>%
  select(c("current_title", "current_salary")) %>% 
  group_by(current_title) %>% 
  summarize(mean_salary = mean(current_salary)) %>%
  kbl(linesep = "", booktabs = TRUE, align = "lcccccc", caption = "") %>%
  kable_styling(
    bootstrap_options = c("striped", "condensed"),
    latex_options = c("striped", "hold_position")
  )

summary(aov(percent_incr ~ performance_rating + current_title, data = blizzard_salary))

%>%
  kbl(linesep = "", booktabs = TRUE, align = "lcccccc", caption = "") %>%
  kable_styling(
    bootstrap_options = c("striped", "condensed"),
    latex_options = c("striped", "hold_position")
  )

ggplot(blizzard_salary %>% filter(performance_rating %in% c("Top", "Successful", "High")), aes(percent_incr, performance_rating))+
  geom_boxplot(color = IMSCOL["blue", "full"])+
  stat_summary(fun = mean, geom = "point", color = IMSCOL["pink", "full"])+
  stat_summary(fun = mean, geom = "text", color = IMSCOL["pink", "full"], vjust = -1, aes(label = paste("Mean")))+
  theme_minimal()+
  labs(
    title = "Raise given in July 2020",
    subtitle = "based on most recent performange evaluation", 
    x = "Percent Increase",
    y = "Performance Rating"
  )
