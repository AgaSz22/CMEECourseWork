for (model in models){
  if (nrow(summary_df)==2){
    summary_table <- summary(model)
    values_for_df <- c(summary_table$coefficients[1], #intercept
                       summary_table$r.squared, #r.squared
                       summary_table$fstatistic[1], #f.value
                       summary_table$coefficients[2][2], #slope
                       summary_table$coefficients[2,4]) #p-value
    
  } else {values_for_df <- c(summary_table$coefficients[1], #intercept
                             summary_table$r.squared, #r.squared
                             summary_table$fstatistic[1], #f.value
                             summary_table$coefficients[1,4], #slope
                             'Too few values') #p-value
  }
}


for (model in models){
  summary_table <- summary(model)
  values_for_df <- tryCatch(c(summary_table$coefficients[ ,2][1], #intercept
                              summary_table$r.squared, #r.squared
                              summary_table$fstatistic[1], #f.value
                              summary_table$coefficients[2][2], #slope
                              summary_table$coefficients[2,4])) #p-value
  warning = function(w) {print(paste("too few values", input));
    error = function(e) {print(paste("too few values", input));
      NaN})
  }
  
  for (model in models){
    summary_table <- summary(model)
    values_for_df <- tryCatch(c(summary_table$coefficients[ ,2][1], #intercept
                                summary_table$r.squared, #r.squared
                                summary_table$fstatistic[1], #f.value
                                summary_table$coefficients[2][2], #slope
                                summary_table$coefficients[2,4])) #p-value
    warning = function(w) {print(paste("too few values", input));
      error = function(e) {print(paste("too few values", input));
        NaN})
    }
    
    
    #  summary_df$R.squared[nrow(summary_df)+1] <- summary_table$r.squared 
    
    
    for (model in models){
      summary_table <- summary(model)
      Predator.lifestage <- 
        
        df = cbind(Predator.lifestage, df)
    }
    
    
  }
  
  for (row in predators) {
    
    
  }
  
  pred_insect <- ggplot(data = subset(predators, Type.of.feeding.interaction == "insectivorous"))+
    geom_density(aes(log(Predator.mass)), fill = "#CC79A7", size = 1)+
    xlab("log(predator mass)")+
    ylab("Density")+
    ggtitle("Insectivorous")+
    theme(plot.title = element_text(hjust = 0.5))+
    xlim(-4, 6) # need to adjust the axes to optimise view
  pred_insect
  
  
  
####creaing an output file
  
  
  output_df <- data.frame(Feeding.type=character(),
                          Mean.Predator=double(),
                          Median.Predator=double(),
                          Mean.Prey=double(),
                          Median.Prey=double(),
                          Size.ratio=double())
  
  
  for (types in feeding_types) {
    temp_df <- subset(predators, Type.of.feeding.interaction == types)
    temp_df$Predator.mass <- log(temp_df$Predator.mass)
    temp_df$Prey.mass <- log(temp_df$Prey.mass)
    new_summary <- summary(temp_df)
    print(new_summary)
  }
  
  ########
  for (types in feeding_types) {
    temp_df <- subset(predators, Type.of.feeding.interaction == types)
    temp_df$Predator.mass <- log(temp_df$Predator.mass)
    temp_df$Prey.mass <- log(temp_df$Prey.mass)
    new_summary <- summary(temp_df)
    new_summary <- as.matrix(new_summary)
    values_for_output_df <- c(new_summary[15])
    print(values_for_output_df)
  }
  
  
  output_df <- rbind(new_summary[1][])
  df_sth = rbind(df, values_for_outpu_df)
  
  
  
  colnames(output_df)[1] <- "Predator.mean"
  colnames(output_df)[2] <- "Predator.median"
  colnames(output_df)[3] <- "Prey.mean"
  colnames(output_df)[4] <- "Prey.median"
  colnames(output_df)[5] <- "Size.ratio"