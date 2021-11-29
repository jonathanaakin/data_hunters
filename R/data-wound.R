#' Soap or Saline: Which is better for cleaning wounds?
#'
#' An experiment where patients' who had open wounds were cleaned
#' with either soap or saline.
#'
#'
#' @format A data frame with 30 rows and 2 variables.
#' \describe{
#'   \item{cleaning}{The type of irrigation solution used to clean
#'     the wound.}
#'   \item{outcome}{If the patient required additional procedures
#'     due to infection of the wound.}
#' }
#' @examples
#' table(wound)
#'
#' @source
#'   \href{https://www.nejm.org/doi/full/10.1056/NEJMoa1508502}
#'     {The FLOW Investigators. 2015. A Trial of Wound Irrigation
#'       in the Initial Management of Open Fracture Wounds.
#'       New England Journal of Medicine 373:2629-2641.}
#'
#'   For an informal overview of the experiment and findings, see
#'   \href{https://www.upi.com/Health_News/2015/12/17/Study-Saline-better-than-soap-and-water-to-clean-wounds/7011450356518/}
#'     {this United Press International article}.
#'
"wound"
