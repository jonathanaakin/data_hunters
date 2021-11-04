library(dplyr)
library(openintro)
library(ggplot2)

plot_data <- pierce_county_house_sales %>% 
  mutate(sales_thousands = sale_price/1000) 

ggplot(plot_data, aes(sale_date, sales_thousands))+
  geom_point(alpha = 0.5, color = IMSCOL["blue","full"])+
  labs(
    title = "2020 Pierce County House Sales",
    x = "Month",
    y = "Sale Price (US$, in thousands)"
  )+
  theme_minimal()

ggsave(here::here("data_set_week/images/pierce_county_scatter.png"))
