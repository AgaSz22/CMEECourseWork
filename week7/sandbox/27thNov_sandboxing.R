

cal_res <- function(predicted_points) {
  original_points <- sub_df$LogPopBio
  residuals <- original_points - predicted_points 
  return(residulals)
}

residuals_logistic <- cal_res(logistic_points_for_res)


cal_RSq <- function(residuals){
  RSS <- sum((residuals_logistic)^2)  
  TSS <- sum((sub_df$LogPopBio - mean(sub_df$LogPopBio))^2)
  RSq <- 1 - (RSS/TSS)
  return(RSq)
}

cal_RSq(residuals_logistic)

RSS_logistic <- sum((residuals_logistic)^2) # Residual sum of squares
TSS_logistic <- sum((sub_df$LogPopBio - mean(sub_df$LogPopBio))^2) # Total sum of squares
RSq_logistic <- 1 - (RSS_logistic/TSS_logistic) # R-squared value




original_points_quadratic <- sub_df$LogPopBio
residuals_quadratic <- original_points_quadratic - quadratic_points_for_res 

RSS_quadratic <- sum((residuals_quadratic)^2) # Residual sum of squares
TSS_quadratic <- sum((sub_df$LogPopBio - mean(sub_df$LogPopBio))^2) # Total sum of squares
RSq_quadratic <- 1 - (RSS_quadratic/TSS_quadratic) # R-squared value



# original_points <- sub_df$LogPopBio
# residuals_logistic <- original_points - logistic_points_for_res 
# 
# RSS_logistic <- sum((residuals_logistic)^2) # Residual sum of squares
# TSS_logistic <- sum((sub_df$LogPopBio - mean(sub_df$LogPopBio))^2) # Total sum of squares
# RSq_logistic <- 1 - (RSS_logistic/TSS_logistic) # R-squared value



n <- nrow(sub_df) #set sample size
p_cubic <- length(coef(fit_cubic)) 
RSS_cubic <- sum((residuals_cubic)^2) # Residual sum of squares
AICc_cubic <- n + 2 + n * log((2 * pi) / n) + n * log(RSS_cubic) + 2 * p_cubic * (n / (n-p_cubic-1))



cal_AICc <- function(fit_model, residuals){
  n <- nrow(sub_df)
  p <- length(coef(fit_model))
  RSS <- sum((residuals)^2)
  AICc <- n + 2 + n * log((2 * pi) / n) + n * log(RSS) + 2 * p * (n / (n-p-1))
}

AICc_logistic <- cal_AICc(fit_logistic, residuals_logistic)





