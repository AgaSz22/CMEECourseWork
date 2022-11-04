#!usr/bin/env Rscript

#Cleaning the environment
rm(list = ls())

# Load the required libraries
library(maps)
library(ggplot2)

#Load data
load("../data/GPDDFiltered.RData")

#Creating a world map
map(database = "world")

# Plotting points on the map
points(x = gpdd$long, y = gpdd$lat, col = "red")

#Expected biases: projection bias; species included in this data set occur primarily in the Northern Hemisphere, which may lead to the false impression that it has higher species richness(map exclusion bias; it is hard to distinguish whether we are looking at multiple samples from one species or multiple species

