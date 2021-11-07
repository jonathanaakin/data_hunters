library(dplyr)
library(ggplot2)
library(kableExtra)
library(openintro)

# Change job types (?) to reflect senior level v. entry. also add/keep per_incr
# might be hard to determine senior v. entry for some job titles

job_salary <- blizzard_salary %>%
  filter(current_salary > 1) %>% 
  mutate(annual_salary = case_when(
    salary_type == "week" ~ current_salary * 52,
    salary_type == "hour" ~ current_salary * 40 * 52,
    TRUE ~ current_salary
  )) %>%
  mutate(job_type = case_when(
    str_detect(current_title, "Analyst") == TRUE ~ "Analyst",
    str_detect(current_title, "Artist") == TRUE ~ "Artist",
    str_detect(current_title, "Animator") == TRUE ~ "Artist",
    str_detect(current_title, "Manager") == TRUE ~ "Manager",
    str_detect(current_title, "Engineer") == TRUE ~ "Engineer",
    str_detect(current_title, "Admin") == TRUE ~ "Admin",
    str_detect(current_title, "Administrator") == TRUE ~ "Admin",
    str_detect(current_title, "Designer") == TRUE ~ "Designer",
    str_detect(current_title, "Producer") == TRUE ~ "Producer",
    str_detect(current_title, "Researcher") == TRUE ~ "Researcher",
    str_detect(current_title, "Cs") == TRUE ~ "Customer Service & Support",
    str_detect(current_title, "Customer Service") == TRUE ~ "Customer Service & Support",
    str_detect(current_title, "Customer Support") == TRUE ~ "Customer Service & Support",
    str_detect(current_title, "Data Scientist") == TRUE ~ "Data Scientist",
    str_detect(current_title, "Editor") == TRUE ~ "Editor",
    str_detect(current_title, "Game Master") == TRUE ~ "Game Master",
    
    str_detect(current_title, "Developer") == TRUE ~ "Developer",
    str_detect(current_title, "Receptionist") == TRUE ~ "Admin"
    )) %>% 
  filter(!is.na(job_type)) %>% 
  select(c(job_type, annual_salary))

job_salary %>% 
  group_by(job_type) %>% 
  summarize(`Mean` = mean(annual_salary),
            `Standard Deviation` = sd(annual_salary),
            `Minimum` = fivenum(annual_salary)[1],
            `Q1` = fivenum(annual_salary)[2],
            `Median` = fivenum(annual_salary)[3],
            `Q3` = fivenum(annual_salary)[4],
            `Maximum` = fivenum(annual_salary)[5],) %>% 
  rename(`Job Type` = job_type) %>% 
  kbl(linesep = "", booktabs = TRUE, align = "lcccccc", caption = "") %>%
  kable_styling(
    bootstrap_options = c("striped", "condensed"),
    latex_options = c("striped", "hold_position")
  )

ggplot(job_salary, aes(annual_salary, job_type))+
  geom_boxplot()

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
