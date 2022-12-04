### CMEE miniproject
### Agnes Szwarczynska
### 21 Nov 2020
### Exploring linear and non-linear models for population growth curves

######### Cleaning the environment ######### 

rm(list=ls())

######### Libraries ######### 

library(tidyverse)
library(minpack.lm)
library(ggplot2)
library(reshape2)
library(dplyr)

######### Data wrangling and manipulation ######### 

### Uploading and viewing data

Bacteria_data <- read_csv("../data/LogisticGrowthData.csv")
Bacteria_data2 <- Bacteria_data[,-1]  ### removing a redundant column

### Creating a duplicate data set to store original data

Bacteria_data2 <- subset(Bacteria_data, Bacteria_data$PopBio > 0) ### removing PopBio values that are smaller than 0
Bacteria_data2$LogPopBio <-log(Bacteria_data2$PopBio)

### Creating unique combinations of Medium x Species x Temperatures x Citation an saving it in an ID column

Bacteria_data2  <- Bacteria_data2 %>%
  group_by(Medium, Species, Temp, Citation) %>%
  mutate(ID = cur_group_id())

######### Functions ######### 

### Calculating residuals

cal_res <- function(predicted_points) {
  original_points <- sub_df$LogPopBio
  residuals <- original_points - predicted_points 
  return(residuals)
}

### Calculating R-squared values

cal_RSq <- function(residuals){
  RSS <- sum((residuals)^2)  
  TSS <- sum((sub_df$LogPopBio - mean(sub_df$LogPopBio))^2)
  RSq <- 1 - (RSS/TSS)
  return(RSq)
}

### Calculating AICc values

cal_AICc <- function(fit_model, residuals){
  n <- nrow(sub_df)
  p <- length(coef(fit_model))
  RSS <- sum((residuals)^2)
  AICc <- n + 2 + n * log((2 * pi) / n) + n * log(RSS) + 2 * p * (n / (n-p-1))
  return(AICc)
}

######### Model functions ######### 

### Logistic model ####

logistic_model <- function(t, r_max, K, N_0)
{return(log(N_0) + log(K) + r_max * t - log(K + N_0 * (exp(r_max * t) - 1)))
}

######### Creating empty data frames for storing output values ######### 

output_table_logistic <- data.frame()
output_table_quadratic <- data.frame()
output_table_cubic <- data.frame()

failures_table <-c() ### storing ID values of failed logistic models

######### Setting seed ######### 
set.seed(123)

######### Loop - fitting and plotting models ######### 

pdf(file = "../data/good_model.pdf")

ids <- unique(Bacteria_data2$ID) ### storing unique ID values

for (unique_id in ids[9]){
  sub_df <- subset(Bacteria_data2, Bacteria_data2$ID==unique_id)
  
  if (nrow(sub_df) < 7) { # if there are fewer data points than 7, terminate loop - that prevents AICc values to go into infinity
    next
  }
  else {
    
    ######### Setting starting parameters ######### 
    
    N_0_start <- min(sub_df$PopBio)
    K_start <- max(sub_df$PopBio) 
    r_max_start <- 0.001
    
    ######### Model equations #########
    
    ### Logistic model ####
    
    tryCatch(
      
      expr ={fit_logistic <- (nlsLM(LogPopBio ~ logistic_model(t = Time, r_max, K, N_0), data = sub_df, 
                                    list(r_max = r_max_start, N_0=N_0_start, K = K_start), lower=c(0,0,0)))},
      error = function(e) {
        print(paste("Logistic model failed, ID =", unique_id))
        failures_table <<- c(failures_table, unique_id) ### when a model fails, store its ID
      })
    
    ### Quadratic model ### 
    
    tryCatch(
      
      expr ={ fit_quadratic  <- lm(LogPopBio ~ poly(Time,2, raw = TRUE), data = sub_df)},
      error = function(e) {
        print("Quadratic model failed")
      })
    
    ### Cubic model ###  
    
    tryCatch(
      
      expr ={fit_cubic  <- lm(LogPopBio ~ poly(Time,3, raw = TRUE), data = sub_df)},
      error = function(e) {
        print("Cubic model failed")
      })
    
    ######### Calculating R-squared ######### 
    
    ### Logistic model ####
    
    logistic_points_for_res <- logistic_model(t = sub_df$Time, 
                                              r_max = coef(fit_logistic)["r_max"],
                                              K = coef(fit_logistic)["K"], 
                                              N_0 = coef(fit_logistic)["N_0"])
    
    residuals_logistic <- cal_res(logistic_points_for_res)
    RSq_logistic <- cal_RSq(residuals_logistic)
    
    ### Quadratic model ###  
    
    quadratic_points_for_res <- predict.lm(fit_quadratic, data.frame(Time = sub_df$Time))
    
    residuals_quadratic <- cal_res(quadratic_points_for_res)
    RSq_quadratic <- cal_RSq(residuals_quadratic)
    
    ### Cubic model ###
    
    cubic_points_for_res <- predict.lm(fit_cubic, data.frame(Time = sub_df$Time))
    
    residuals_cubic <- cal_res(cubic_points_for_res)
    RSq_cubic <- cal_RSq(residuals_cubic)
    
    ######### Creating data frames for plotting ######### 
    
    ### Logistic model ####
    
    timelenghts <- seq(min(sub_df$Time),
                       max(sub_df$Time),
                       length.out = 300)
    
    logistic_points <- logistic_model(t = timelenghts, 
                                      r_max = coef(fit_logistic)["r_max"],
                                      K = coef(fit_logistic)["K"], 
                                      N_0 = coef(fit_logistic)["N_0"])
    
    df1 <- data.frame(timelenghts, logistic_points)
    df1$model <- "Logistic"
    names(df1) <- c("Time", "N", "model")
    
    ### Quadratic model ###
    
    predict_quadratic <- predict.lm(fit_quadratic, data.frame(Time = timelenghts))
    
    df2 <- data.frame(timelenghts, predict_quadratic)
    df2$model <- "Quadratic"
    names(df2) <- c("Time", "N", "model")
    
    ### Cubic model ###
    
    predict_cubic <- predict.lm(fit_cubic, data.frame(Time = timelenghts))
    
    df3 <- data.frame(timelenghts, predict_cubic)
    df3$model <- "Cubic"
    names(df3) <- c("Time", "N", "model")
    
    ######### Calculating AICc #########
    
    AICc_logistic <- cal_AICc(fit_logistic, residuals_logistic)
    AICc_quadratic <- cal_AICc(fit_quadratic, residuals_quadratic)
    AICc_cubic <- cal_AICc(fit_cubic, residuals_cubic)
    
    ######### Creating output tables #########
    
    ### Logistic model ####
    
    shapiro_outcome_logistic <- shapiro.test(residuals_logistic)
    
    values_for_ot <- c(unique_id,
                       sub_df$Species[1],
                       model = "logistic model",
                       sub_df$Medium[1],
                       sub_df$Temp[1],
                       nrow(sub_df),
                       sub_df$Citation[1],
                       coef(fit_logistic)["r_max"],
                       coef(fit_logistic)["N_0"],
                       coef(fit_logistic)["K"],
                       AICc_logistic,
                       RSq_logistic,
                       shapiro_outcome_logistic[2][[1]])
    
    output_table_logistic = rbind(output_table_logistic, values_for_ot)
    
    colnames(output_table_logistic)[1] <- "Unique_ID"
    colnames(output_table_logistic)[2] <- "Species"
    colnames(output_table_logistic)[3] <- "Model_I"
    colnames(output_table_logistic)[4] <- "Medium"
    colnames(output_table_logistic)[5] <- "Temperature"
    colnames(output_table_logistic)[6] <- "Sample_size"
    colnames(output_table_logistic)[7] <- "Experiment"
    colnames(output_table_logistic)[8] <- "r_max_logistic"
    colnames(output_table_logistic)[9] <- "N_0_logistic"
    colnames(output_table_logistic)[10] <- "K_logistic"
    colnames(output_table_logistic)[11] <- "AICc_logistic"
    colnames(output_table_logistic)[12] <- "R_squared_logistic"
    colnames(output_table_logistic)[13] <- "Shapiro_logistic"
    
    ### Quadratic model ### 
    
    shapiro_outcome_quadratic <- shapiro.test(residuals_quadratic)
    
    values_for_ot_quadratic <- c(
      unique_id,
      model = "quadratic model",
      fit_quadratic[[1]][[1]],
      fit_quadratic[[1]][[2]],
      fit_quadratic[[1]][[3]],
      AICc_quadratic,
      RSq_quadratic,
      shapiro_outcome_quadratic[2][[1]])
    
    output_table_quadratic = rbind(output_table_quadratic, values_for_ot_quadratic)
    
    colnames(output_table_quadratic)[1] <- "Unique_ID"
    colnames(output_table_quadratic)[2] <- "Model_II"
    colnames(output_table_quadratic)[3] <- "Intercept_quadratic"
    colnames(output_table_quadratic)[4] <- "a_quadratic"
    colnames(output_table_quadratic)[5] <- "b_quadratic"
    colnames(output_table_quadratic)[6] <- "AICc_quadratic"
    colnames(output_table_quadratic)[7] <- "R_squared_quadratic"
    colnames(output_table_quadratic)[8] <- "Shapiro_quadratic"
    
    ### Cubic model ### 
    
    values_for_ot_cubic <- c(
      unique_id,
      model = "cubic model",
      fit_cubic[[1]][[1]],
      fit_cubic[[1]][[2]],
      fit_cubic[[1]][[3]],
      fit_cubic[[1]][[4]],
      AICc_cubic,
      RSq_cubic)
    
    output_table_cubic = rbind(output_table_cubic, values_for_ot_cubic)
    
    colnames(output_table_cubic)[1] <- "Unique_ID"
    colnames(output_table_cubic)[2] <- "Model_III"
    colnames(output_table_cubic)[3] <- "Intercept_cubic"
    colnames(output_table_cubic)[4] <- "a_cubic"
    colnames(output_table_cubic)[5] <- "b_cubic"
    colnames(output_table_cubic)[6] <- "c_cubic"
    colnames(output_table_cubic)[7] <- "AICc_cubic"
    colnames(output_table_cubic)[8] <- "R_squared_cubic"
    
    ######### Plotting all models #########  
    
    plot_models <-  ggplot(sub_df, aes(x = Time, y = LogPopBio)) +
      geom_point(size = 3) +
      geom_line(data = df1, aes(x = Time, y = N, col = model), size = 1) +    ### Plotting a logistic model
      geom_line(data = df2, aes(x = Time, y = N, col = model), size = 1) +    ### Plotting a quadratic model
      geom_line(data = df3, aes(x = Time, y = N, col = model), size = 1) +    ### Plotting a cubic model
      theme(aspect.ratio=1) + #### Making the plot square 
      labs(x = "Time (hours)", y = "LogPopBio (optical density)") 
    
    plot_models <- plot_models + theme_minimal() 
    
    plot_models <- plot_models + theme(legend.position = "bottom", 
                                       plot.title = element_text(hjust = 0.5),legend.title = element_text( size=15), legend.text = element_text(size = 13)) ### increasing legend title and text
    
    plot_models <- plot_models + theme(axis.text.x=element_text(size=13), axis.text.y=element_text(size=13)) ### increasing x and y axis labels
    plot_models <- plot_models + theme(axis.title.y=element_text(size=13), axis.title.x=element_text(size=14)) ### increasing x and y axis title
    
    print(plot_models)
    
    print(paste("stuff was plotted", unique_id)) ### Message for myself to see whether R is plotting my models
    
  }
}

dev.off()