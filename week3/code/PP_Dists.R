###Clearing the workspace
rm(list = ls())

###Loading libraries
library(ggplot2)
require(ggpubr)
library(dplyr)


###Loading the data
predators <- as.data.frame(read.csv("../data/EcolArchives-E089-51-D1.csv"))

###Making units uniform - changing mg to g
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


###Assigning feeding types and life stages to vectors

feeding_types <-unique(predators$Type.of.feeding.interaction)
life_stages <-unique(predators$Predator.lifestage)

###predators subplots in a pdf format
pdf("../results/Pred_Subplots.pdf")
par(mfrow = c(3, 2))


for (types in feeding_types) {
  temp_df <- subset(predators, Type.of.feeding.interaction == types)
    plot(density(log(temp_df$Predator.mass)), main = "", col = "dark red", 
         xlab = "log[Predator mass (g)] ",
         xlim = c(-10, 15),
         ylim = c(0.0, 0.4))
  }
  dev.off()

  
###prey subplots in a pdf format  
pdf("../results/Prey_Subplots.pdf")
par(mfrow = c(3, 2)) 

for (types in feeding_types) {
  temp_df <- subset(predators, Type.of.feeding.interaction == types)
  plot(density(log(temp_df$Prey.mass)), main = "", col = "dark red", 
       xlab = "log[Prey mass (g)] ",
       xlim = c(-20, 10),
       ylim = c(0.0, 0.5))
}
dev.off()

###prey mass/predator mass subplots in a pdf format 
pdf("../results/SizeRatio_Subplots.pdf")
par(mfrow = c(3, 2)) 

for (types in feeding_types) {
  temp_df <- subset(predators, Type.of.feeding.interaction == types)
  temp_var <- log(temp_df$Prey.mass)/log(temp_df$Prey.mass)
  plot(density(temp_var), main = "", col = "dark red", 
       xlab = "log(Size ratio) ",
       xlim = c(-1, 3),
       ylim = c(0.0, 4))
}
dev.off()


###First approach - producing a csv output file (didn't work well)

#for (types in feeding_types) {
#  temp_df <- subset(predators, Type.of.feeding.interaction == types)
#  temp_df$Predator.mass <- log(temp_df$Predator.mass)
#  temp_df$Prey.mass <- log(temp_df$Prey.mass)
#  new_summary <- summary(temp_df)
#  new_summary <- as.matrix(new_summary)
#  values_for_output_df <- c(new_summary[15]) #indexing is not very intuitive in this case
#  print(values_for_output_df) #checking whether the loop prints out expected value
#}


###Creating an output data frame
output_df <- predators %>%
  group_by(Type.of.feeding.interaction) %>%
  summarise(mean(log(Predator.mass)),
            median(log(Predator.mass)),
            mean(log(Prey.mass)),
            median(log(Prey.mass)),
            mean(log(Prey.mass/Predator.mass)),
            median(log(Prey.mass/Predator.mass)))

print(output_df)
###Assigning new column names
colnames(output_df) <- c("Feeding type","Predator.mean","Predator.median","Prey.mean","Prey.median","Size.ratio.mean","Size.ratio.median")



###Producing a csv file
write.csv(output_df, "../results/PP_Results.csv")
