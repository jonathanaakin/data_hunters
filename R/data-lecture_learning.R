#' Lecture Delivery Method and Learning Outcomes
#' 
#' Data was collected from 276 students in a university psychology course
#' to determine the effect of lecture delivery method on learning.  Students were
#' presented a live lecture by the professor on one day and a pre-recorded 
#' lecture on a different topic by the same professor on a different day. 
#' Survey data was collected during the lectures to determine mind wandering,
#' interest, and motivation.  Students were also ultimately asked about the
#' preferred lecture delivery method.  Finally, students completed an assessment
#' at the end of the lecture to determine memory recall.    
#' 
#' 
#' @format A data frame with 552 rows and 8 variables.
#' \describe{
#'   \item{Student}{Identification number of a specific student. Each identification appears twice because same student heard both lecture delivery methods.}
#'   \item{Gender}{Gender of student.}
#'   \item{Method}{Delivery method of lecture was either in-person(Live) or pre-recorded(Video).}
#'   \item{Mindwander}{An indicator of distraction during the lecture. It is a proportion of six mind wandering probes during the lecture when a student answered yes that mind wandering had just occurred.}
#'   \item{Memory}{An indicator of recall ofinformation provided during the lecture. It is the proportion of correct answers in a six question assessment given at the end of the lecture presentation.}
#'   \item{Interest}{A Likert scale that gauged student interest level concerning the lecture.}
#'   \item{Motivation_both}{After experiencing both lecture delivery methods, students were asked about which method they were most motivated to remain attentive.}
#'   \item{Motivation_single}{After a single lecture delivery experience, this Likert scale was used to gauge motivation to remain attentive during the lecture.}
#' }
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' library(ggmosaic)
#' 
#' # Calculate the average memory test proportion by lecture delivery method and gender.
#' lecture_learning %>%
#'  group_by(Method, Gender) %>%
#'  summarize(AverageMemory = mean(Memory), count = n())
#'
#' # Compare visually the differences in memory test proportions by delivery method and gender.
#' ggplot(data = lecture_learning, aes(x = Method, y = Memory, fill = Gender)) +
#'  geom_boxplot() + geom_jitter() 
#' 
#' # Use a paired t-test to determine whether memory test proportion score differed by delivery method.
#' t.test(Memory ~ Method, data = lecture_learning, paired = TRUE)
#' 
#' # Calculating the proportion of students who were most motivated to remain attentive in each delivery method.
#' lecture_learning %>% 
#'  count(Motivation_both) %>% 
#'  mutate(proportion = n / sum(n))
#'
#' # Use a mosaic plot to visualize the relationship between gender and delivery method preference.
#' ggplot(data = lecture_learning) +
#'  geom_mosaic(aes(x = product(Gender, Motivation_both), fill=Gender))
#'
#' @source [PLOS One](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0141587)
#'
"lecture_learning"
