#' helper function to combine results from a series of sufficiency tests
#'
#' @param featureList a list of feature vectors
#' @param resList a list of corresponding results from `subsetSuffiTest()` on the above featureList
#'
#' @return dataframe, that summarizes the results from the sufficiency tests
#' @export
#'
sumSuffTestRes <- function(featureList, resList){
  resDf <- bind_rows(Map(function(features, resl){
    idset <- paste0(features, collapse = ",")

    if (length(resl)==0){
      data.frame(features = idset, path = NA,
                 inclS = 0,
                 PRI = 0,
                 convS = 0)
    } else {
      resPath <- paste0(resl$path$essential, collapse = "+")
      resInc <- resl$path$IC

      if(length(resInc$sol.incl.cov)>0){
        incVec <- resInc$sol.incl.cov
      } else {
        incVec <- resInc$overall$sol.incl.cov
      }

      data.frame(features = idset, path = resPath,
                 inclS = incVec[1, 'inclS'],
                 PRI = incVec[1, 'PRI'],
                 convS = incVec[1, "covS"])
    }

  }, featureList, resList))

  resDfSorted <- resDf %>%
    arrange(desc(.data$convS)) %>%
    mutate(rank = 1:n())

  return(resDfSorted)
}
