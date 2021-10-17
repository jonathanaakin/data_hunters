library(dplyr)
library(ggplot2)
library(stringr)
library(lubridate)
library(forcats)
library(tidyr)

#-------------------------------------------------------------------------------

core_i7 <- cpu %>% 
  filter(str_detect(name, "Core i7")==TRUE) %>% 
  separate(name, into = c("series", "gen"), sep = "-") %>% 
  separate(gen, into = c("model", "suffix"), sep = "(?<=[0-9])(?=[A-Za-z])") %>%
  mutate(gen = case_when(
    str_detect(model, "[:digit:]{3}") ~ "First",
    str_detect(model, "^2") ~ "Second",
    str_detect(model, "^3") ~ "Third",
    str_detect(model, "^4") ~ "Fourth",
    str_detect(model, "^5") ~ "Fifth",
    str_detect(model, "^6") ~ "Sixth",
    str_detect(model, "^7") ~ "Seventh",
    str_detect(model, "^8") ~ "Eighth",
    str_detect(model, "^9") ~ "Ninth",
    str_detect(model, "^10") ~ "Tenth"
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


















