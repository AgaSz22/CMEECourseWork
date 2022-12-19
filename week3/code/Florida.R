#!usr/bin/env Rscript

###libraries
require("ggpubr")
library("ggplot2")


###Cleaning the global environment

rm(list=ls())

###Loading the data from the data folder

load("../data/KeyWestAnnualMeanTemperature.RData")

ls()

###Checking the class and initial rows of the dataset 
class(ats)
head(ats)

###Plotting temperatures across years and saving the final plot

png(file="../data/plot1.png",
    width=1000, height=600)
ggscatter(ats, x = "Year", y = "Temp", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Time (years)", ylab = "Temperatures")
dev.off()

###Checking the distribution of the temperature data
hist(ats$Temp)

###Calculating the initial correlation coefficient
result1 <- cor(ats$Year, ats$Temp, method = "pearson")

###Shuffling the temperatures 10k times and storing the values in a vector
cor_values <- rep(NA, 10000)

for (i in 1:10000) {
  sth <- sample(ats$Temp, 100, replace = FALSE)
  result <- cor(sth, ats$Year)
  cor_values[i]<- result
}

###Saving the pots in the results folder
png(file="../data/histogram1.png", width=1000, height=600)


###Printing a histogram of generated correlation coefficients with the initial value of the correlation coefficient plotted as a red line
histogram <- hist(cor_values, breaks = 100)
plot(histogram, xlim=c(-1,1), xlab = "Generated correlation coefficients", ylab = "Frequency", main ="Distribution of random correlation coefficients")
abline(v = result1, col="red")

dev.off()


###Calculating what fraction of the random correlation coefficients were greater than the observed one
fraction <- (length(cor_values[cor_values > result1]))/length(cor_values)
print(paste("The fraction is:", fraction))


