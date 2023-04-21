#' Perform sufficiency test on a select set of variables
#'
#' @param dataCali dataframe, calibrated data
#' @param vSelect string vector, selected variable names (must be in dataCali)
#' @param outcome string, name of the outcome variable
#' @param incl.cut inclusion cut-off(s); see `?QCA::truthTable` for details
#' @param pri.cut  minimal score for the PRI; see `?QCA::truthTable` for details
#' @param n.cut minimum number of cases for a remainder row; see `?QCA::truthTable` for details
#' @param sort.by Sort the truth table according to various columns
#' @param complete Logical, whether to print complete truth table
#'
#' @return a list of two tables
#' \itemize{
#'  \item table: truth table
#'  \item path: sufficiency test solution
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' subsetSuffiTest(voteDataCalibrated, c("P_V530", "V648", "V207", "V141"), "vote")
#' }
subsetSuffiTest <- function(dataCali, vSelect, outcome, incl.cut = 0.8, pri.cut = 0.51, n.cut = 10, sort.by = c("OUT", "incl"), complete=T){
  subdata <- dataCali[,c(outcome, vSelect)] %>% drop_na()

  tTablePass1 <- truthTable(data = subdata,
                            outcome= outcome,
                            conditions = vSelect,
                            incl.cut = incl.cut,
                            pri.cut = pri.cut,
                            n.cut = n.cut,
                            sort.by = sort.by,
                            complete = complete)


  tTableMin <- minimize(input =  tTablePass1,
                        use.tilde = TRUE,
                        details = TRUE)
  tTableList <- list(table=tTablePass1, path=tTableMin)

  return(tTableList)
}
