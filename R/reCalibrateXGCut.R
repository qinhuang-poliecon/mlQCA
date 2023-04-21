#' Calibrate data based on xgboost model cutoffs
#'
#' @description
#' this function performs crisp calibration based on a set of cutoffs derived from the xgboost trees
#'
#'
#' @param data the input data that was used to train xgboost model
#' @param cutoffs dataframe, contains cutoffs extracted from trained xgboost model
#' @param outcome string, indicates the name of the outcome variable
#' @param na.rm logical, whether to remove rows that contain NA after calibration (default: True)
#'
#' @return a calibrated dataframe
#' @export
#'
#' @examples
#' \dontrun{
#'reCalibrateXGCut(voteData, cutDataFrame, "vote")
#' }
reCalibrateXGCut <- function(data, cutoffs, outcome, na.rm=T){
  dfx <- data %>%
    select(all_of(c(cutoffs$feature, outcome)))

  dfx_Cali <- bind_cols(map2(cutoffs$feature, cutoffs$cutoff, function(fx, cx){
    vx <- dfx[[fx]]
    vx <- ifelse(vx>=cx, 1, 0)
    dfy <- data.frame(vx)
    colnames(dfy) <- fx
    dfy
  }))

  dfx_Cali[[outcome]] <- dfx[[outcome]]

  if (na.rm){
    dfx_Cali <- drop_na(dfx_Cali)
  }

  return(dfx_Cali)
}
