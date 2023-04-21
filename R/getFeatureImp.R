#' Calculate feature importance in terms of xgboost metrics and shap values
#'
#' @param model output xgboost model from `buildXGboost()`
#' @param data dataframe, input data used to train the model
#' @param outcome string, name of the outcome variable
#'
#' @return a data frame that contains 4 metrics for each feature
#' \itemize{
#'  \item Gain: improvement in accuracy brought by the feature to the branches it is on
#'  \item Cover: relative quantity of observations concerned by a feature
#'  \item Frequency: the number of times a feature is used in all generated trees
#'  \item shap: average Shapley value for the feature
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' getFeatureImp(xgb, voteData, "vote")
#' }
getFeatureImp <- function(model, data, outcome){
  bst <- model$finalModel
  impDf <- as.data.frame(xgb.importance(model = bst)) %>%
    rename(feature = .data$Feature)

  ## 2.4 also add shap value
  cols <- setdiff(colnames(data), outcome)
  shapScore <- shap.values(bst, data.matrix(data[, cols]))$mean_shap_score
  shapDf <- data.frame(feature=names(shapScore), shap=shapScore)

  ## 2.5 combine with qca metric
  combDf <- impDf %>%
    full_join(shapDf, by="feature") %>%
    arrange(desc(.data$shap))

  return(combDf)
}
