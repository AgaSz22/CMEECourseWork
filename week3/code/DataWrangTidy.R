#!usr/bin/env Rscript

################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

####Libraries
library(tidyverse)

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

#####creating a df
MyData2 <- as.data.frame(MyData)
class(MyData2)


############# Replace species absences with zeros ###############
MyData2[MyData2 == ""] = NA
MyData2

MyData2 <- MyData2 %>% replace(is.na(.), 0) #replace() function from tidyverse
MyData2

#####creating a tibble

MyData_t <- dplyr::as_tibble(MyData2) 
class(MyData_t)

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
dplyr::glimpse(MyData) #### same as str()
utils::View(MyData) #same as fix()
utils::View(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 

MyData_t <- as_tibble(cbind(nms = names(MyData_t), t(MyData_t)))
MyData_t

head(MyData_t)
dim(MyData_t)


############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData_t[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData_t[1,] # assign column names from original data

######removing the redundant first column
TempData <- TempData[,-1]
############# Convert from wide to long format  ###############
MyWrangledData <- TempData %>% 
  gather(key = Species, value = Count, -Cultivation, -Block, -Plot, -Quadrat)

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############