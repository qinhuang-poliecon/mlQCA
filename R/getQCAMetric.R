#' Calculate per-variable QCA metric
#'
#' @param dataCali dataframe, calibrated data
#' @param outcome string, name of the outcome variable
#'
#' @return a data frame that contains 3 QCA metrics
#' \itemize{
#'  \item Cons.Nec: necessity consistency
#'  \item Cov.Nec: necessity coverage
#'  \item RoN: relavance of necessity
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' getQCAMetric(voteDataCalibrated, "vote")
#' }
#'
getQCAMetric <- function(dataCali, outcome){
  features <- setdiff(colnames(dataCali), outcome)
  metricDf <- do.call("rbind", lapply(features, function(fx) {
    subDfx <- dataCali %>% select(all_of(c(fx, outcome))) %>% drop_na()
    labVec <- as.numeric(subDfx[[outcome]])
    valVec <- as.numeric(subDfx[[fx]])
    necDf <- as.data.frame( QCAfit(valVec, labVec, cond.lab = fx) )
    necDf$feature <- fx
    necDf
  }))
  return(metricDf)
}
