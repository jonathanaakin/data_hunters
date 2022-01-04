library(tidyverse)
library(openintro)
library(infer)
library(kableExtra)
library(scales)

summary_data <- piracy %>% 
  mutate(money_pro = replace_na(money_pro, 0), 
         money_con = replace_na(money_con, 0),
         money_total = money_pro+money_con) %>% 
  filter(party != " I", money_pro >= 0 & money_con >= 0)

t_test(summary_data,
       formula = money_total~party, 
       order = c(" D"," R"), 
       mu = 0, 
       alternative = "two.sided", 
       var.equal = TRUE, 
       conf_int = TRUE,
       conf_level = 0.99)  %>%
  kbl(linesep = "", booktabs = TRUE, align = "lcccccc", caption = "") %>%
  kable_styling(bootstrap_options = c("striped", "condensed"),
                latex_options = c("striped", "hold_position"))

ggplot(summary_data, aes(party, money_total/10^6))+
  geom_col(fill = IMSCOL["green", "full"])+
  theme_minimal()+
  labs(
    title = "Campaign donations from anti-piracy legislation",
    subtitle = "from pro and con lobby groups",
    x = "Party",
    y = "Total campaign donations ($US, millions)"
  )

ggsave(here::here("data_set_week/images/piracy_paterno_plot-1.png"), bg = "white")

ggplot(summary_data)+
  geom_point(aes(money_pro, money_con), color = IMSCOL["green", "full"], alpha= 0.3)+
  geom_abline(slope = 1, intercept = 0, alpha = 0.2)+
  facet_wrap(~party)+
  theme_minimal()+
  labs(
    title = "Campaign donations from pro v con lobby groups",
    x = "Pro lobby groups", 
    y = "Con lobby groups"
  )+
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1)
  )+
  scale_x_continuous(labels = comma)+
  scale_y_continuous(labels = comma)

ggsave(here::here("data_set_week/images/piracy_paterno_plot-2.png"), bg = "white")
