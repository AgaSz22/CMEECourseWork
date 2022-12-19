### CMEE miniproject
### Agnes Szwarczynska
### 21 Nov 2020
### Exploring linear and non-linear models for population growth curves


###Libraries

library(tidyverse)
library(minpack.lm)
library(ggplot2)
library(AICcmodavg)

### Uploading and viewing data

Bacteria_data <- read_csv("../data/LogisticGrowthData.csv")

Bacteria_data2 <- Bacteria_data[,-1]



#Bacteria_data <- Bacteria_data[-c(1)]
#Bacteria_data <- subset(Bacteria_data, select = -c(X) )

### Exploring unique values

media <- unique(Bacteria_data$Medium)
#media
temperature <- unique(Bacteria_data$Temp)
#temperature
species <- unique(Bacteria_data$Species)
#species
time_units <- unique(Bacteria_data$Time_units)
#time_units
pop_units <- unique(Bacteria_data$PopBio_units)
#pop_units

### Creating a duplicate data set for data wrangling and manipulation

Bacteria_data2 <- subset(Bacteria_data, Bacteria_data$PopBio > 0)
Bacteria_data2$LogPopBio <-log(Bacteria_data2$PopBio)

### Creating unique combinations of Medium x Species x Temperatures x Citation an saving it in an ID column

Bacteria_data2  <- Bacteria_data2 %>%
  group_by(Medium, Species, Temp, Citation) %>%
  mutate(ID = cur_group_id())

### Ploting to explore data and saving to data

# pdf(file = "../results/bacteria_initial_plots.pdf")
# 
# ids <- unique(Bacteria_data2$ID)
# 
# for (unique_id in ids){
#   sub_df <- subset(Bacteria_data2, Bacteria_data2$ID==unique_id)
#   print(ggplot(data = sub_df) +
#           geom_point(mapping = aes(x = Time, y = log(PopBio)))+
#           ggtitle(paste("Medium =", Bacteria_data2$Medium), subtitle = paste("Temperature =", Bacteria_data2$Temp," Species =",Bacteria_data2$Species)))
#   break
# }
# 
# dev.off()

### Fitting a model
### logistic models ####
logistic_model <- function(t, r_max, K, N_0){return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}

#quadratic_model <- function(t, a, b, c){return(a*(x^2)+b*x+c)}

### qompertz model ####
gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}    
#########################
output_table_logistic <- data.frame()
output_table_quadratic <- data.frame()
output_table_qubic <- data.frame()
output_table_gompertz <-data.frame()



pdf(file = "../results/bacteria_initial_models.pdf")

ids <- unique(Bacteria_data2$ID)

for (unique_id in ids){
  sub_df <- subset(Bacteria_data2, Bacteria_data2$ID==unique_id)
  
  if (nrow(sub_df) < 7) { # if there are fewer data points than 7 (average no. of parameters in models), terminate loop
    next
  }
  else {
    
    N_0_start <- min(sub_df$PopBio)
    K_start <- max(sub_df$PopBio) ###should multiply by 10?
    r_max_start <- 0.001
    #r_max = max(diff(log(sub_df$PopBio)))/2
    t_lag_start <- sub_df$Time[which.max(diff(diff(sub_df$LogPopBio)))]
    
    ### tryCatch for logistic ###  
    tryCatch(
      
      expr ={fit_logistic <- (nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), data = sub_df, 
                                    list(r_max = r_max_start, N_0=N_0_start, K = K_start), lower=c(0,0,0)))},
      error = function(e) {
        #logistc_success <- 0
        print("Logistic model failed")
      })
    
    ######## tryCatch for gompertz ###########
    
    tryCatch(
      
      expr ={fit_gompertz <- nlsLM(LogPopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), data = sub_df,
                                   list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start))},
      error = function(e) {
        #gompertz_success <- 0
        print("Gompertz model failed")
      })  
    
    
    #### quadratic model ####
    #  
    fit_quadratic  <- lm(PopBio ~ poly(Time,2, raw = TRUE), data = sub_df) ####check
    
    # print(fit_quadratic)
    ###### qubic model #######  
    
    fit_qubic  <- lm(PopBio ~ poly(Time,3, raw = TRUE), data = sub_df)   
    
    ################### quadratic
    
    timelenghts <- seq(min(sub_df$Time),
                       max(sub_df$Time),
                       length.out = 300)
    
    predict_quadratic <- predict.lm(fit_quadratic, data.frame(Time = timelenghts))
    
    df2 <- data.frame(timelenghts, predict_quadratic)
    df2$model <- "Quadratic"
    names(df2) <- c("Time", "N", "model")
    
    ################### qubic
    
    predict_qubic <- predict.lm(fit_qubic, data.frame(Time = timelenghts))
    
    df3 <- data.frame(timelenghts, predict_qubic)
    df3$model <- "Qubic"
    names(df3) <- c("Time", "N", "model")
    #######  
    
    print("fit completed")
    
    #### AICc ######
    
    tryCatch(
      
      expr = {aicc_logistic <-  AICc(fit_logistic, return.K = FALSE, second.ord = TRUE, 
                                     nobs = NULL) ####check whether right command was applied
      },
      error = function(e){print(NA)
        
      })
    
    aicc_quadratic <- AICc(fit_quadratic, return.K = FALSE, second.ord = TRUE, 
                           nobs = NULL) ###check
    
    aicc_qubic <- AICc(fit_qubic, return.K = FALSE, second.ord = TRUE, 
                       nobs = NULL) ###check
    
    aicc_gompertz <- AICc(fit_gompertz, return.K = FALSE, second.ord = TRUE, 
                          nobs = NULL) ###check
    
    ############ Calculating R-squared
    
    ###logistic model
    
    RSS_logistic <- sum(residuals(fit_logistic)^2) # Residual sum of squares
    TSS_logistic <- sum((sub_df$PopBio - mean(sub_df$PopBio))^2) # Total sum of squares
    RSq_logistic <- 1 - (RSS_logistic/TSS_logistic) # R-squared value
    
    ###quadratic model
    
    RSS_quadratic <- sum(residuals(fit_quadratic)^2) # Residual sum of squares
    TSS_quadratic <- sum((sub_df$PopBio - mean(sub_df$PopBio))^2) # Total sum of squares
    RSq_quadratic <- 1 - (RSS_quadratic/TSS_quadratic) # R-squared value
    
    ###qubic model
    
    RSS_qubic <- sum(residuals(fit_qubic)^2) # Residual sum of squares
    TSS_qubic <- sum((sub_df$PopBio - mean(sub_df$PopBio))^2) # Total sum of squares
    RSq_qubic <- 1 - (RSS_qubic/TSS_qubic) # R-squared value
    
    
    ####gompertz model
    
    RSS_gompertz <- sum(residuals(fit_gompertz)^2) # Residual sum of squares
    TSS_gompertz <- sum((sub_df$PopBio - mean(sub_df$PopBio))^2) # Total sum of squares
    RSq_gompertz <- 1 - (RSS_gompertz/TSS_gompertz) # R-squared value
    
    
    ############
    
    r_max = coef(fit_logistic)["r_max"]   ####kick it out
    K = coef(fit_logistic)["K"]
    N_0 = coef(fit_logistic)["N_0"]
    
    print("parameters assigned")
    
    ###########
    
    timelenghts <- seq(min(sub_df$Time), # necessary here?
                       max(sub_df$Time),
                       length.out = 300)
    
    logistic_points <- logistic_model(t = timelenghts, 
                                      r_max = coef(fit_logistic)["r_max"],
                                      #r_max = max(diff(log(sub_df$PopBio)))/2, ### getting various r-max values depending on the subset of data
                                      K = coef(fit_logistic)["K"], 
                                      N_0 = coef(fit_logistic)["N_0"])
    df1 <- data.frame(timelenghts, logistic_points)
    df1$model <- "Logistic equation"
    names(df1) <- c("Time", "N", "model")
    
    
    ########### not sure whether it works?
    gompertz_points <- exp(gompertz_model(t = timelenghts,                             ####check exp here
                                      r_max = coef(fit_gompertz)["r_max"][[1]],
                                      K = coef(fit_gompertz)["K"][[1]],
                                      N_0 = coef(fit_gompertz)["N_0"][[1]],
                                      t_lag = coef(fit_gompertz)["t_lag"][[1]]))
    
    df4 <- data.frame(timelenghts, gompertz_points)
    df4$model <- "Gompertz model"
    names(df4) <- c("Time", "N", "model")
    
    summary(fit_gompertz)
    ############ Creating an output table for the logistic model
    
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
                       aicc_logistic,
                       RSq_logistic)
    
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
    
    ######### Creating an output table for the quadratic model
    
    values_for_ot_quadratic <- c(
      unique_id,
      model = "quadratic model",
      fit_quadratic[[1]][[1]],
      fit_quadratic[[1]][[2]],
      fit_quadratic[[1]][[3]],
      #sub_df$Temp[1],
      #sub_df$Medium[1],
      #sub_df$Species[1],
      #nrow(sub_df),
      #sub_df$Citation[1],
      aicc_quadratic,
      RSq_quadratic)
    
    output_table_quadratic = rbind(output_table_quadratic, values_for_ot_quadratic)
    
    colnames(output_table_quadratic)[1] <- "Unique_ID"
    colnames(output_table_quadratic)[2] <- "Model_II"
    colnames(output_table_quadratic)[3] <- "Intercept_quadratic"
    colnames(output_table_quadratic)[4] <- "a_quadratic"
    colnames(output_table_quadratic)[5] <- "b_quadratic"
    #colnames(output_table_quadratic)[6] <- "Temperature"
    #colnames(output_table_quadratic)[7] <- "Medium"
    #colnames(output_table_quadratic)[8] <- "Species"
    #colnames(output_table_quadratic)[9] <- "Population_size"
    #colnames(output_table_quadratic)[10] <- "Experiment"
    colnames(output_table_quadratic)[6] <- "AICc_quadratic" 
    colnames(output_table_quadratic)[7] <- "R_squared_quadratic"
    
    ######### Creating an output table for the qubic model  
    
    values_for_ot_qubic <- c(
      unique_id,
      model = "qubic model",
      fit_qubic[[1]][[1]],
      fit_qubic[[1]][[2]],
      fit_qubic[[1]][[3]],
      fit_qubic[[1]][[4]],
      #sub_df$Temp[1],
      #sub_df$Medium[1],
      #sub_df$Species[1],
      #nrow(sub_df),
      #sub_df$Citation[1],
      aicc_qubic,
      RSq_qubic)
    
    output_table_qubic = rbind(output_table_qubic, values_for_ot_qubic)
    
    colnames(output_table_qubic)[1] <- "Unique_ID"  
    colnames(output_table_qubic)[2] <- "Model_III"
    colnames(output_table_qubic)[3] <- "Intercept_qubic"
    colnames(output_table_qubic)[4] <- "a_qubic"
    colnames(output_table_qubic)[5] <- "b_qubic"
    colnames(output_table_qubic)[6] <- "c_qubic"
    #colnames(output_table_qubic)[7] <- "Temperature"
    #colnames(output_table_qubic)[8] <- "Medium"
    #colnames(output_table_qubic)[9] <- "Species"
    #colnames(output_table_qubic)[10] <- "Population_size"
    #colnames(output_table_qubic)[11] <- "Experiment"
    colnames(output_table_qubic)[7] <- "AICc_qubic"
    colnames(output_table_qubic)[8] <- "R_squared_qubic"
    
    
    ##########
    
    values_for_ot_gompertz <- c(
      unique_id,
      model = "gompertz model",
      coef(fit_gompertz)["r_max"][[1]],
      coef(fit_gompertz)["N_0"][[1]],
      coef(fit_gompertz)["K"][[1]],
      coef(fit_gompertz)["t_lag"][[1]],
      aicc_gompertz,
      RSq_gompertz)
    
    output_table_gompertz = rbind(output_table_gompertz, values_for_ot_gompertz)
    
    colnames(output_table_gompertz)[1] <- "Unique_ID"  
    colnames(output_table_gompertz)[2] <- "Model_IV"
    colnames(output_table_gompertz)[3] <- "r_max_gompertz"
    colnames(output_table_gompertz)[4] <- "N_0_gompertz"
    colnames(output_table_gompertz)[5] <- "K_gompertz"
    colnames(output_table_gompertz)[6] <- "t_lag_gompertz"
    colnames(output_table_gompertz)[7] <- "AICc_gompertz"
    colnames(output_table_gompertz)[8] <- "RSq_gompertz"
    
    
    ############  
    
    p_logistic <-  ggplot(sub_df, aes(x = Time, y = PopBio)) +
      geom_point(size = 3) +
      geom_line(data = df1, aes(x = Time, y = N, col = model), size = 1) +
      geom_line(data = df2, aes(x = Time, y = N, col = model), size = 1) +
      geom_line(data = df3, aes(x = Time, y = N, col = model), size = 1) +
      geom_line(data = df4, aes(x = Time, y = N, col = model), size = 1) +
      theme(aspect.ratio=1)+ # make the plot square 
      labs(x = "Time", y = "Cell number/ Optical density") +
      ggtitle(paste("Medium =", sub_df$Medium[1], "  Temperature =", sub_df$Temp[1],"  Species =", sub_df$Species[1]), subtitle = paste("r-max =", r_max, "   K =", K, "  N_0 =", N_0)) 
    
    print(p_logistic)
    
    print("stuff was plotted") 
    
  }
}

dev.off()

#######Creating an output table
output_table_full <- merge(x = output_table_logistic, y =output_table_quadratic, by = "Unique_ID", all = TRUE)

output_table_full_2 <- merge(x = output_table_full, y =output_table_qubic, by = "Unique_ID", all = TRUE) 

output_table_full_3 <- merge(x = output_table_full, y =output_table_gompertz, by = "Unique_ID", all = TRUE) 

###Saving the data frame as a csv output file
write.csv(output_table_full_2,"../results/CMEE_miniproject_output", row.names = FALSE)