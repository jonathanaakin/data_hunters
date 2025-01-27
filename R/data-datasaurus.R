#' The Datasaurus Dozen
#'
#' A compilation of 13 data sets, each of them including different values for the variables x and y.
#'
#'
#' @name datasaurus
#' @docType data
#' @format A data frame with 1846 observations of 3 variables.
#' \describe{
#'   \item{dataset}{The name of each one of the 13 sets. The original datasaurus set is named "dino".}
#'   \item{x}{Values for x.}
#'   \item{y}{Values for y.}
#'   }
#' @source The data sets were created by Justin Matejka and George Fitzmaurice (see \url{https://www.autodesk.com/research/publications/same-stats-different-graphs}), inspired by the datasaurus set from Alberto Cairo (see \url{http://www.thefunctionalart.com/2016/08/download-datasaurus-never-trust-summary.html}). The data can also be found in the [`datasauRus` package](https://cran.r-project.org/web/packages/datasauRus/index.html) ([License](https://cran.r-project.org/web/licenses/MIT), [copyright]( https://cran.r-project.org/web/packages/datasauRus/LICENSE)).
#' @references Justin Matejka and George Fitzmaurice. 2017. Same Stats, Different Graphs: Generating Datasets with Varied Appearance and Identical Statistics through Simulated Annealing. Proceedings of the 2017 CHI Conference on Human Factors in Computing Systems. Association for Computing Machinery, New York, NY, USA, 1290-1294. DOI: \url{https://doi.org/10.1145/3025453.3025912}.
#' @keywords datasets  
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' # Name of all 13 sets
#' unique(datasaurus$dataset)
#' 
#' # Summary statistics for x and y for the "dino" set
#' datasaurus %>%
#'   filter(dataset == "dino") %>%
#'   summarise(
#'     mean_x = mean(x),
#'     sd_x = sd(x),
#'     mean_y = mean(y),
#'     sd_y = sd(y),
#'     cor_xy = cor(x, y)
#'   )
#' 
#' # Contrast with summary statistics for the "circle" set
#' datasaurus %>%
#'   filter(dataset == "circle") %>%
#'   summarise(
#'     mean_x = mean(x),
#'     sd_x = sd(x),
#'     mean_y = mean(y),
#'     sd_y = sd(y),
#'     cor_xy = cor(x, y)
#'   )
#' 
#' # Now plot both
#' datasaurus %>%
#'   filter(dataset %in% c("dino", "circle")) %>%
#'   ggplot(mapping = aes(x = x, y = y)) +
#'   geom_point() +
#'   facet_grid(rows = vars(dataset))
#'
"datasaurus"
