library(kableExtra)
library(ggplot2)
library(dplyr)
library(openintro)
library(infer)
  
  # Conditional probabilities of response for each race/ethnicity
  race_justice %>%
   count(race_eth, response) %>%
   group_by(race_eth) %>%
     mutate(prop = n / sum(n)) %>% 
    kbl(linesep = "", booktabs = TRUE, align = "lccc", caption = "") %>%
    kable_styling(bootstrap_options = c("striped", "condensed"), 
                  latex_options = c("striped", "hold_position")) 
  
   # Stacked bar plot of proportions
   ggplot(race_justice, aes(x = race_eth, fill = response)) +
     geom_bar(position = "fill") +
     labs(
       x = "Race / ethnicity",
       y = "Proportion",
      title = "Do you think Black and White people receive
   equal treatment from the police?",
       fill = "Response"
    )+
     scale_fill_manual(
       values = c(IMSCOL[1, 1], IMSCOL[2, 1], IMSCOL[2,3])
       )+
     theme_minimal()

   # faceted bar plot of proportions
   plot_data <- race_justice %>%
     count(race_eth, response) %>%
     group_by(race_eth) %>%
     mutate(prop = n / sum(n))
   
   ggplot(plot_data, aes(x = race_eth, y = prop, fill = response)) +
     geom_col() +
     labs(
       x = "Race / ethnicity",
       y = "Proportion",
       title = "Do you think Black and White people receive
   equal treatment from the police?"
     )+
     scale_fill_manual(
       values = c(IMSCOL[1, 1], IMSCOL[2, 1], IMSCOL[2,3])
     )+
     theme_minimal()+
     facet_wrap(~response)+
     guides(fill = "none")
   
   # chi-square test for independence
 race_justice %>% 
   observe(response ~ race_eth, stat = "Chisq", null = "independence")
 
 qchisq(0.05, 6, lower.tail=FALSE)

   