#' Extract the cutoffs used in the trained xgboost model
#'
#' @param model output xgboost model from `buildXGboost()`
#' @param full logical, whether to report the most frequent cutoff for each feautres or all the cutoffs (default: False)
#' @param treeIndex number, examine cutoffs from a particular tree
#'
#' @return dataframe that contains the cutoffs used by the xgboost model for each feature
#' @export
#'
#' @examples
#' \dontrun{
#' getXGboostCut(xgb)
#' }
getXGboostCut <- function(model, full=F, treeIndex=NULL){
  bst <- model$finalModel
  Ntree <- bst$tuneValue$nrounds
  if (is.null(treeIndex)){
    xx <- xgb.plot.tree(model=bst, trees = 0:(Ntree-1), render = F)
  } else {
    xx <- xgb.plot.tree(model=bst, trees = treeIndex, render = F)
  }
  Edf <- xx$edges_df %>%
    filter(.data$label!="") %>%
    select(.data$from, .data$label)
  ndf <- xx$nodes_df %>%
    select(.data$id, .data$data, .data$label) %>%
    rename(metric=.data$label)
  treeDf <- inner_join(Edf, ndf, by=c("from"="id")) %>%
    rename(feature=.data$data) %>%
    select(-.data$from) %>%
    mutate(cutoff = str_split(.data$label, "<", simplify = T)[,2])
  cutDf <- treeDf %>%
    group_by(.data$feature) %>%
    count(.data$cutoff) %>%
    mutate(Prop = n/sum(n)) %>%
    ungroup() %>%
    arrange(.data$feature, desc(.data$Prop)) %>%
    mutate(cutoff = round(as.numeric(.data$cutoff), 3))
  if (full) {
    return(cutDf)
  } else {
    finalDf <- cutDf %>%
      group_by(.data$feature) %>%
      slice_head(n=1) %>%
      select(-.data$n, -.data$Prop) %>%
      ungroup() %>%
      mutate(cutoff = as.numeric(.data$cutoff))
    return(finalDf)
  }
}
