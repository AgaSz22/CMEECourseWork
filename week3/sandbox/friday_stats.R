rodents <- read.csv("rodents.csv")
head(rodents)
print(rodents)

range(rodents$yr)

rodents <- as.data.frame(rodents)
colnames(rodents) <- c("Year", "Month", "Tag", "Species", "Sex", "Hfl", "Wegetation", "Precipitation")
head(rodents)

rodents <- subset(rodents, select =- Hfl)
rodents

rodents <- subset(rodents,rodents$Year>=1980 & rodents$Year<=1981)
rodents

rodents <- na.omit(rodents)

str(rodents)
head(rodents)

par = (mfrow = c(1,2))
plot(Wegetation~ as.factor(Sex), data = rodents)
plot(Wegetation ~ as.factor(Year), data = rodents)
hist(rodents$Wegetation)

library(dplyr)
rodents$Sex <- as.factor(rodents$Sex)

head(rodents)


var_Weg <- rodents %>%
  group_by(Year) %>%
  summarise(variance = var(Wegetation), sd = sd(Wegetation), mean = mean(Wegetation))
var_Weg

mean_1980 <- var_Weg[[4]][1]
mean_1980

sd_1980 <- var_Weg[[4]][2]
sd_1980

#y <- var_Weg[[2]][1]
#subset()
par(mfrow=c(2,1),mar=c(4,4,1,1))
barMids <- barplot(mean_1980, xlab = "Year", ylab = "Wegetation",
                   ylim = c(0, 5))


plots <- arrows(barMids, mean_1980 - sd_1980, barMids, mean_1980 +
         sd_1980, code = 3, angle = 90)

plots

?arrows


