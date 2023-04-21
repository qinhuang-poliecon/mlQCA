#' Helper function to join the feature-level QCA and XGboost metrics
#'
#' @param featureMetric dataframe, result from the `getQCAMetric()`
#' @param qcaMetric dataframe, result from the `getFeatureImp()`
#'
#' @return dataframe, combined dataframe of feature-level importance
#' @export
#'
#' @examples
#' \dontrun{
#' fDf <- getFeatureImp(xgb, voteData, "vote")
#' qDf <- getQCAMetric(voteDataCalibrated, "vote")
#' joinDf <- joinMetrics(fDf, qDf)
#' }
joinMetrics <- function(featureMetric, qcaMetric){
  fDf <- featureMetric
  qDf <- qcaMetric
  rDf <- full_join(fDf, qDf, by = "feature") %>%
    arrange(desc(.data$shap))
  rDf <- rDf %>%mutate(fRank = c(1:nrow(rDf)))
  return(rDf)
}
