#'Iteratively do sufficiency tests on k features out of the given features
#'
#'@description This function iteratively generates all combinations of k
#'features from the given feature vector (n choose k), and perform a sufficiency
#'test for each combination of the k features.
#'
#'
#'@param features string vector, a vector of features to choose from
#'@param k number, number of features to choose for each sufficiency test
#'@param dataCali dataframe, calibrated data
#'@param outcome string, name of the outcome variable
#'@param incl.cut inclusion cut-off(s); see `?QCA::truthTable` for details
#'@param pri.cut minimal score for the PRI; see `?QCA::truthTable` for details
#'@param n.cut minimum number of cases for a remainder row; see `?QCA::truthTable` for details
#'@param sort.by Sort the truth table according to various columns
#'@param complete Logical, whether to print complete truth table
#'
#'@return a summary table of solutions to all combinations of k out of n feautres
#'@export
#'
#' @examples
#' \dontrun{
#' fDf <- getFeatureImp(xgb, voteData, "vote")
#' fVec <- head(fDf$feature, 10)
#' iterQCA(features = fVec, k=4, dataCali = voteDataCalibrated, outcome = "vote")
#' }
iterQCA <- function(features, k, dataCali, outcome, incl.cut = 0.8, pri.cut = 0.51, n.cut = 10, sort.by = c("OUT", "incl"), complete=T){

  fvec_nk <- combn(features, k, simplify = F)
  res_nk <- lapply(fvec_nk, function(xv){
    tryCatch({
      subsetSuffiTest(dataCali = dataCali,  vSelect=xv,  outcome=outcome,
                      incl.cut = incl.cut, pri.cut = pri.cut, n.cut = n.cut, sort.by = sort.by,
                      complete = complete)
    }, error = function(e){
      return(NULL)
    })
  })
  df_nk <- sumSuffTestRes(fvec_nk, res_nk)
  return(df_nk)
}
