#Prey_mass <- as.logical(predators$prey.mass.unit)
#head(Prey_mass)



#prey_mass <- rep(NA, 34930)
#predator_mass <- (predators$Predator.mass)
#z <- (predators$Type.of.feeding.interaction)


predators_3 <-predators

for (i in predators_3$Prey.mass.unit){
  if (i == "mg"){
    for (e in predators_3$Prey.mass){
      e[i] <- e*0.01
    }
  }
}


#ggplot(predators, aes(log(Predator.mass), log(Prey.mass), group = Predator.lifestage)) +
#  geom_point(aes(colour = Predator.lifestage), pch = 4) +
#  geom_smooth(method = lm, fullrange = TRUE)+
#  theme_bw()+
#  theme(legend.position = "bottom")+
#facet_wrap(vars(Type.of.feeding.interaction), nrow = 5, strip.position = "right")
#geom = c("point", "smooth")



#for (i in predators$Prey.mass.unit){ 
#  if (i  == "mg"){
#    for (e[i] in predators$Prey.mass){
#    x[e] <- e*0.01}
#  } else x[i] <- i {
#  
#  }
#}



#  if (i  == "mg"){ 
#    for (e[i] in predators$Prey.mass){
#    x[e] <- e*0.01
#    }
#  else
#    x[i] <- i}

predators_2 <- predators
predators_2$Prey.mass <- prey_mass  


co_df<- cbind(predator_mass, prey_mass,z)
covariances <- cov.group(co_df, Type.of.feeding.intearction)

#for (i in predators$Prey.mass.unit){ 
#  if (i  == "mg"){
#    for (e[i] in predators$Prey.mass){
#    x[e] <- e*0.01}
#  } else x[i] <- i {
#  
#  }
#}



#  if (i  == "mg"){ 
#    for (e[i] in predators$Prey.mass){
#    x[e] <- e*0.01
#    }
#  else
#    x[i] <- i}

predators_2 <- predators
predators_2$Prey.mass <- prey_mass  


co_df<- cbind(predator_mass, prey_mass,z)
covariances <- cov.group(co_df, Type.of.feeding.intearction)


fitted_models = predators %>% group_by(Type.of.feeding.interaction, Predator.lifestage) %>% do(model = lm(Predator.mass ~ Prey.mass, data = .))

fitted_models = predators %>% group_by(Type.of.feeding.interaction, Predator.lifestage) %>% do(model = lm(Predator.mass ~ Prey.mass, data = .))


fit <- lm(Predator.mass ~ Prey.mass, data=predators)
summary(fit) # show results


predators %>%
  nest(data = -Type.of.feeding.interaction) %>% 
  mutate(
    fit = map(data, ~ lm(Predator.mass ~ Prey.mass, data = .x)),
    tidied = map(fit, tidy)
  ) %>% 
  unnest(tidied)


################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

####Libraries
library(tidyverse)
library(dplyr)
############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")


#####creating a data frame
MyData2 <- as.data.frame(MyData)
class(MyData2)

MyData_t <- dplyr::as_tibble(MyData2) 
class(MyData_t)

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)## replaced by glimsped
dplyr::glimpse(MyData) ####
fix(MyData) #you can also do this
fix(MyMetaData)

utils::View(MyWrangledData) #same as fix()

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)


MyData_t <- as_tibble(cbind(nms = names(MyData_t), t(MyData_t)))
MyData_t

#MyData2 <- MyData2 %>%
#  rownames_to_column %>% 
# gather(v1, value, -rowname) %>% 
#  spread(rowname, value) 

#library(dplyr)
#library(tidyr)
#MyData2 %>%
#  gather(var, val, 2:ncol(MyData2)) %>%
#  spread(Series.Description, val)




############# Replace species absences with zeros ###############
MyData_t[MyData_t == ""] = NA
MyData_t <- MyData_t %>% replace(is.na(.), 0)
MyData_t



############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
require(reshape2) # load the reshape2 package

?melt #check out the melt function

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############

