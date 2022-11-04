MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))
class(MyData)

MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep=";")

head(MyData)
fix(MyData)

MyData <- t(MyData) 
view(MyData)

require(tidyverse)