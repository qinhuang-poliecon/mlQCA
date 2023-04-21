#' Estimate the accuracy of the trained xgboost model
#'
#' @param model output xgboost model from `buildXGboost()`
#' @param data dataframe, input data used to train the model
#' @param outcome string, name of the outcome variable
#'
#' @return a number from 0 to 1 indicating the accuracy of the model (1 being perfect accuracy)
#' @export
#'
#' @examples
#' \dontrun{
#' getAccXGboost(xgb, voteData, "vote")
#' }
getAccXGboost <- function(model, data, outcome){
  tst_lbl <- data[[outcome]]
  xgb_pred <- predict(model, newdata = data, na.action = na.pass)
  acc <- mean(tst_lbl==xgb_pred)
  return(acc)
}
