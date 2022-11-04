getwd()
d <- read.table("sandbox/SparrowSize(2).txt", header=TRUE)
str(d)
names(d)
length(d$Tarsus)

hist(d$Tarsus)

mean(d$Tarsus, na.rm = TRUE)

par(mfrow = c(2,2))
hist(d$Tarsus, breaks = 3, col="grey")
hist(d$Tarsus, breaks = 10, col="grey")
hist(d$Tarsus, breaks = 30, col="grey")
hist(d$Tarsus, breaks = 100, col="grey")

table(d$Tarsus)

d$Tarsus.rounded <-round(d$Tarsus, digits=1)
head(d$Tarsus.rounded)

require(dplyr)

TarsusTally <- d %>% count(Tarsus.rounded, sort=TRUE)
TarsusTally

?subset()

d2 <- subset(d, d$Tarsus!="NA")
length(d$Tarsus)-length(d2$Tarsus)


?length()


TarsusTally <- d2 %>% count(Tarsus.rounded, sort = TRUE)
TarsusTally[[1]][1]

head(d2)

bills <- subset(d, d$Bill = "NA")
bills <- subset(d$Bill != "NA")

length(bills)
bills <- d$Bill
bills <- subset(bills, d$Bill != "NA")

length(bills)

head(bills)

?subset()

TarsusTally[[1]][1]

var(d$Tarsus, na.rm = TRUE)
sum((d2$Tarsus - mean(d2$Tarsus))^2)/(length(d2$Tarsus)-1)

sqrt(var(d2$Tarsus))
?length()

head(d2$Bill)
length(d2$Bill)
bills <- subset(d2, is.na(Bill) ==F)
nrow(bills)

nrow(d2)==nrow(bills)

x <- c(1,2,3,4,8)
y <- c(4,3,5,7,9)
modell <- (lm(y~x))
modell
summary(modell)
anova(modell)
resid(modell)
cov(x,y)
var(x)
plot(y~x)



#########
rm(list=ls())
getwd()

d <- read.table("sandbox/SparrowSize(2).txt", header = TRUE)
d

d1<-subset(d, d$Wing !="NA")
head(d1)
summary(d1$Wing)
hist(d1$Wing)

model1 <-lm(Wing~Sex.1,data=d1)
summary(model1)

anova(model1)

daphnia <-read.delim("daphnia.txt")
summary(daphnia)

str(daphnia)

par(mfrow = c(1,2))
plot(Growth.rate ~as.factor(Detergent), data=daphnia)
plot(Growth.rate ~ as.factor(Daphnia), data=daphnia)

require(dplyr)

daphnia %>%
  group_by(Detergent) %>%
  summarise (variance=var(Growth.rate))

dev.off

hist(daphnia$Growth.rate)
seFun <- function(x) {
  sqrt(var(x)/length(x))
}
detergentMean <- with(daphnia, tapply(Growth.rate, INDEX = Detergent,
                                      FUN = mean))
detergentSEM <- with(daphnia, tapply(Growth.rate, INDEX = Detergent,
                                     FUN = seFun))
cloneMean <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = mean))
cloneSEM <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = seFun))

par(mfrow=c(2,1),mar=c(4,4,1,1))
barMids <- barplot(detergentMean, xlab = "Detergent type", ylab = "Population
growth rate",
                   ylim = c(0, 5))
arrows(barMids, detergentMean - detergentSEM, barMids, detergentMean +
         detergentSEM, code = 3, angle = 90)

barMids <- barplot(cloneMean, xlab = "Daphnia clone", ylab = "Population grow
th rate",
                   ylim = c(0, 5))
arrows(barMids, cloneMean - cloneSEM, barMids, cloneMean + cloneSEM,
       code = 3, angle = 90)

daphniaMod <- lm(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaMod)
