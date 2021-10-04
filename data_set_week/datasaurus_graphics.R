#datasaurus table 1
datasaurus %>%
  filter(dataset == "dino") %>%
  summarise(
    n = n(),
    mean_x = mean(x),
    sd_x = sd(x),
    mean_y = mean(y),
    sd_y = sd(y),
    cor_xy = cor(x, y),
    beta_coef = cov(x, y)/var(x)    
  ) %>%
kbl(linesep = "", booktabs = TRUE, align = "lcccccc", caption = "") %>%
  kable_styling(bootstrap_options = c("striped", "condensed"), 
                latex_options = c("striped", "hold_position")) 

#datasaurus plot 1
my_data <- mvtnorm::rmvnorm(n = 142,
                            mean = c(54.26, 47.83),
                            sigma = matrix(c(16.76 ^ 2, 16.76 * 26.93 * -0.06, 16.76 * 26.93 * -0.06, 26.93 ^ 2), 2))

colnames(my_data) <- c("x", "y")

## Potential scatter plot under known summary stats
my_data %>%
  as.data.frame() %>%
  ggplot(aes(x = x, y = y)) +
  geom_point(color = IMSCOL["blue", "full"])+
  theme_minimal()

#datasaurus plot 2
datasaurus %>%
  filter(dataset == "dino") %>%
  ggplot(aes(x = x, y = y)) +
  geom_point(color = IMSCOL["blue", "full"])+
  theme_minimal()

#table 2
datasaurus %>%
  group_by(dataset) %>%
  summarise(
    n = n(),
    mean_x = mean(x),
    sd_x = sd(x),
    mean_y = mean(y),
    sd_y = sd(y),
    cor_xy = cor(x, y),
    beta_coef = cov(x, y)/var(x)    
  ) %>% 
  kbl(linesep = "", booktabs = TRUE, align = "lcccccc", caption = "") %>%
  kable_styling(bootstrap_options = c("striped", "condensed"), 
                latex_options = c("striped", "hold_position")) 

#plot 3
datasaurus %>%
  filter(dataset %in% c("circle", "h_lines", "star", "slant_up")) %>%
  ggplot(mapping = aes(x = x, y = y)) +
  geom_point(color = IMSCOL["blue", "full"]) +
  facet_wrap(vars(dataset), nrow = 2)+
  theme_minimal()
