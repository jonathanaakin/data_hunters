  library(kableExtra)
  library(ggplot2)
  library(dplyr)
  library(openintro)

  # Conditional probabilities of response for each race/ethnicity
  race_justice %>%
   count(race_eth, response) %>%
   group_by(race_eth) %>%
     mutate(prop = n / sum(n)) %>% 
    kbl(linesep = "", booktabs = TRUE, align = "lcccccc", caption = "") %>%
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

   plot(1:7, 7:1, col=IMSCOL, pch=19, cex=6, xlab="", ylab="",
        xlim=c(0.5,7.5), ylim=c(-2.5,8), axes=FALSE)
   text(1:7, 7:1+0.7, paste("IMSCOL[", 1:7, "]", sep=""), cex=0.9)
   points(1:7, 7:1-0.7, col=IMSCOL[,2], pch=19, cex=6)
   points(1:7, 7:1-1.4, col=IMSCOL[,3], pch=19, cex=6)
   points(1:7, 7:1-2.1, col=IMSCOL[,4], pch=19, cex=6)   
   