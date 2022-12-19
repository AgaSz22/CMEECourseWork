#!usr/bin/env Rscript

library(plyr)
library(ggplot2)
library(dplyr)
library(broom)
library(tibble)
library(tidyr)
library(purrr)


# load the data
predators <- as.data.frame(read.csv("../data/EcolArchives-E089-51-D1.csv"))


#plot the data
p <- qplot(Prey.mass, Predator.mass, log = "xy", xlab = "log[Prey mass (grams)]",
      ylab = "log[Predator mass (grams)]", facets = Type.of.feeding.interaction ~., data = predators,
      colour = Predator.lifestage) + geom_smooth(method = "lm",fullrange = TRUE)
final_plot <- p + theme_bw()+
  theme(legend.position = "bottom")+
  geom_point(shape=1,aes(colour = Predator.lifestage)) 

final_plot

#saving the pdf output in the results folder

pdf("../results/PP_Regress_plots.pdf")
print(final_plot)
dev.off()

#making units uniform - changing mg to g
newpreymass <- c()
for (i in 1:nrow(predators)){
  p <- predators[i,]
  if (p$Prey.mass.unit=="mg"){
    newpreymass <- c(newpreymass, p$Prey.mass/1000)
  }
  else {
    newpreymass <- c(newpreymass, p$Prey.mass)
  }
    
}

predators$Prey.mass <- newpreymass
predators$Prey.mass.unit <- rep("g",34931)

#performing linear regression

fit_model <- function(x) {lm(log(Predator.mass) ~ log(Prey.mass), data = x)}
models <- dlply(predators, .(Type.of.feeding.interaction, Predator.lifestage), fit_model)


#summary_df <- data.frame(Type.of.feeding.interaction=character(),
#                         Predator.lifestage=character(),
#                         Regression.slope=double(),
#                         Regression.intercept=double(),
#                         R.squared=double(),
#                         F.statistic=double(),
#                         P.value=double()
#                         )

#creating an empty data frame
df <- data.frame()

#extracting pieces of information:intercept, R^2, f.value, slope & p-value and adding them to the data frame
for (model in models){
  # print(as.numeric(summary(model)$fstatistic[1]))
  summary_table <- summary(model)
  values_for_df <- c(summary_table$coefficients[1], #intercept
                     summary_table$r.squared, #r.squared
                     as.numeric(summary_table$fstatistic[1]), #f.value
                     #summary(model)$fstatistic[1],
                     summary_table$coefficients[2], #slope
                     summary_table$coefficients[1,4]) #p-value
  df = rbind(df, values_for_df)
}

#Giving meaningful column names

colnames(df)[1] <- "Intercept"
colnames(df)[2] <- "R.squared"
colnames(df)[3] <- "F.value"
colnames(df)[4] <- "Slope"
colnames(df)[5] <- "P.value"

#Creating first two rows with the Predator.lifestage & Type.of.feeding.interaction data 
Predator.lifestage <- c("larva/juvenile","adult","juvenile","larva/juvenile","postlarva","postlarva","adult","juvenile","larva", "larva/juvenile", "postlarva", "adut", "juvenile","larva","larva/juvenile","postlarva", "postlarva/juvenile", "adult")

df <- cbind(Predator.lifestage, df)

Type.of.feeding.interaction <-c("insectivorous", c(rep('piscivorous',5)),c(rep('planktivorous', 5)), c(rep("predacious", 6)), "predacious/piscivorous")

df <- cbind(Type.of.feeding.interaction, df)

#Saving the output as a csv file
write.csv(df, "../results/PP_Regress_Results.csv", row.names = FALSE)

