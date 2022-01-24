library(dplyr)
library(ggplot2)
library(openintro)
library(kableExtra)

biontech_adolescents %>% 
  count(group, outcome) %>% 
  tidyr::pivot_wider(names_from = outcome, values_from = n, values_fill = 0) %>% 
  janitor::adorn_totals(where = c("row", "col")) %>% 
  kbl(linsep = "", booktabs = TRUE, align = "lccc", caption ="") %>% 
    kable_styling(bootstrap_options = c("striped", "condensed"), latex_options = c("striped", "hold_position"))

biontech_adolescents %>% 
  infer::chisq_test(outcome ~ group) %>% 
  kbl(linsep = "", booktabs = TRUE, align = "lcc", caption ="") %>% 
  kable_styling(bootstrap_options = c("striped", "condensed"), latex_options = c("striped", "hold_position"))

plot_data <- biontech_adolescents %>% 
  mutate(result = ifelse(outcome == "COVID-19", "Yes", "No"))

ggplot(plot_data, aes(group, fill = result))+
  geom_bar(position = "dodge")+
  scale_fill_manual(values = c(IMSCOL["blue", "full"], IMSCOL["green", "full"]))+
  labs(
    title = "Efficacy of Pfizer-BioNTech vaccine on adolescents",
    x = "Group", 
    y = "Number of trial participants", 
    fill = "Did the participant get COVID-19?"
  )
