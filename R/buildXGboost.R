#' buildXGboost
#'
#' @description
#' this is a wrapper around caret and xgboost to quickly build a xgboost model
#'
#' @param data input dataframe
#' @param outcome string, name of the label column
#' @param customGrid tune grid constructed from [expand.grid()], if not specified, a preset tune grid will be used
#'
#' @return a caret model object that contains the best-tuned xgboost model
#' @export
#'
#' @examples
#' \dontrun{
#' xgbModel <- buildXGboost(voteDf, "vote")
#'
#' # the following grid is used in default if no custom grid is specified
#' myGrid <- expand.grid(eta=c(0.2:0.4),
#'                         gamma=0,
#'                         max_depth=c(3:5),
#'                         colsample_bytree=c(0.6,0.8, 1),
#'                         min_child_weight=1,
#'                         subsample=c(0.75, 0.85,1),
#'                         nrounds=c(50,100,150))
#'
#' xgbModel <- buildXGboost(voteDf, "vote", customGrid = myGrid)
#' }
#'
#'
buildXGboost <- function(data, outcome, customGrid = NULL){
  data <- data %>% rename(Label = all_of(outcome))
  data$Label <- factor(data$Label)

  if (is.null(customGrid)){
    custGrid <- expand.grid(eta=c(0.2:0.4),
                            gamma=0,
                            max_depth=c(3:5),
                            colsample_bytree=c(0.6,0.8, 1),
                            min_child_weight=1,
                            subsample=c(0.75, 0.85,1),
                            nrounds=c(50,100,150))
  } else {
    custGrid <- customGrid
  }


  xgb = caret::train(
    Label ~ .,
    data = data,
    method = "xgbTree",
    trControl = caret::trainControl(method = "cv", number = 5),
    na.action = na.pass,
    tuneGrid = custGrid,
    verbosity = 0
  )

  return(xgb)
}
