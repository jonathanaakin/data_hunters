library(tidyverse)
library(datahunter)
library(openintro)

ggplot(pokemon_go, aes(cp, cp_new))+
  geom_point(color = IMSCOL["blue", "full"])+
  theme_minimal()+
  labs(
    title = "Pre and post evolution CP in Pokemon Go",
    subtitle = "Species: Caterpie, Eevee, Pidgey, Weedle",
    x = "Pre-evolution CP",
    y = "Post-evolution CP"
  )

ggplot(pokemon_go, aes(cp, cp_new, color = species))+
  geom_point()+
  theme_minimal()+
  labs(
    title = "Pre and post evolution CP in Pokemon Go",
    x = "Pre-evolution CP",
    y = "Post-evolution CP",
    color = "Species"
  )+
  scale_color_manual(
    values = c(IMSCOL["blue", "full"],
               IMSCOL["red", "full"],
               IMSCOL["yellow", "full"],
               IMSCOL["pink", "full"])
  )

plot_data <- pokemon_go %>% 
  mutate(type = case_when(
    species == "Caterpie" ~ "Bug", 
    species == "Weedle" ~ "Bug", 
    species == "Pidgey" ~ "Flying", 
    str_detect(notes, "Vaporeon") ~ "Water", 
    str_detect(notes, "Vaporean") ~ "Water", 
    str_detect(notes, "Flareon") ~ "Fire", 
    str_detect(notes, "Jolteon") ~ "Electric"
  ))

ggplot(plot_data, aes(cp, cp_new, color = type))+
  geom_point()+
  theme_minimal()+
  labs(
    title = "Pre and post evolution CP in Pokemon Go",
    x = "Pre-evolution CP",
    y = "Post-evolution CP",
    color = "Type"
  )+
  scale_color_manual(
    values = c(IMSCOL["green", 3],
               IMSCOL["yellow", "full"],
               IMSCOL["red", "full"],
               IMSCOL["pink", 3],
               IMSCOL["blue", "full"])
  )
