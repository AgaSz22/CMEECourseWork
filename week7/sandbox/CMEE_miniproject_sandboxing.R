

library(tidyverse)
Bacteria_data <- read_csv("../data/LogisticGrowthData.csv")
View(Bacteria_data)


media <- unique(Bacteria_data$Medium)
media

temperature <- unique(Bacteria_data$Temp)
temperature

species <- unique(Bacteria_data$Species)
species

time_units <- unique(Bacteria_data$Time_units)
time_units

pop_units <- unique(Bacteria_data$PopBio_units)
pop_units

Bacteria_data2 <- Bacteria_data

###
Bacteria_data2  <- Bacteria_data2 %>%
group_by(Medium, Species, Temp, Citation) %>%
  mutate(ID = cur_group_id())




range_col <- vector( , nrow(Bacteria_data2))
for (i in 1:nrow(Bacteria_data2)){
  b <- Bacteria_data2[i,]
  if (b$Temp < 10){
    range_col[i] <- c("R1")
  }
  else if (between(b$Temp, 10,20) ){
    range_col[i] <- c("R2")
  }
  else if (between(b$Temp, 20,30)){
    range_col[i] <- c("R3")
  }
  else if (b$Temp > 30)
    range_col[i] <- c("R4")
}

Bacteria_data2$timedays <- Bacteria_data2$Time / 24
# Bacteria_data2$timedays[which(Bacteria_data2$timedays > 20)] <- 0

days <- vector( , nrow(Bacteria_data2))
for (i in 1:nrow(Bacteria_data2)){
  d <- Bacteria_data2[i,]
    days[i] <- c(d$Time[i]/24)}

Bacteria_data2["days"] <- days

Bacteria_data2["temp_range"] <- range_col

p <- unique(Bacteria_data2$temp_range)
p

#for (e in Bacteria_data2$Temp) {
#  if (e < 10) {
#    e == "R1"
#  }
#  else if (e < 20) {
#    e == "R2"
#  }
#  else if (e < 30){
#    e == "R3"
#  }
#  else (e < 40)
#    e == "R4"
#  }

head(Bacteria_data2)

library(ggplot2)

pdf(file = "../results/bacteria_plots.pdf")

species <- unique(Bacteria_data2$Species)


for (spp in species){
  subdf <- subset(Bacteria_data2, Bacteria_data2$Species==spp)
  print(ggplot(data = subdf) +
    geom_point(mapping = aes(x = Time, y = log(PopBio), color = Medium)) +
    facet_wrap(~ temp_range, nrow = 2)) + labs(title=spp)
}


dev.off()

###########start here

library(minpack.lm)

logistic_model <- function(t, r_max, K, N_0){return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
  }


ids <- unique(Bacteria_data2$ID)
for (uns in ids){
  subdf_f <- subset(Bacteria_data2, Bacteria_data2$ID==uns)
  
  N_0_start <- min(subdf_f$PopBio)
  K_start <- max(subdf_f$PopBio)
  r_max_start <- 0.62
  
  fit_logistic <- nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), data = subdf_f, 
                        list(r_max = r_max_start, N_0=N_0_start, K = K_start))
  
  summary(fit_logistic)
  
  timelenghts <- seq(min(subdf_f$Time),
                     max(subdf_f$Time),
                     len = 100)
  
  logistic_points <- logistic_model(t = timelenghts, 
                                    r_max = coef(fit_logistic)["r_max"], 
                                    K = coef(fit_logistic)["K"], 
                                    N_0 = coef(fit_logistic)["N_0"])
  df1 <- data.frame(timelenghts, logistic_points)
  df1$model <- "Logistic equation"
  names(df1) <- c("Time", "N", "model")
  
p_logistic <-  ggplot(subdf_f, aes(x = Time, y = PopBio)) +
    geom_point(size = 3) +
    geom_line(data = df1, aes(x = Time, y = N, col = model), size = 1) +
    theme(aspect.ratio=1)+ # make the plot square 
    labs(x = "Time", y = "Cell number")

print(p_logistic)
  
  break
}










####
pdf(file = "../results/bacteria_plots.pdf")

par(mfrow=c(2,2))
ids <- unique(Bacteria_data2$ID)
for (uns in ids){
  subdf <- subset(Bacteria_data2, Bacteria_data2$ID==uns)
  print(ggplot(data = subdf) +
          geom_point(mapping = aes(x = Time, y = log(PopBio), color = Medium))+
          #labs(title = uns))
      ggtitle(paste("Medium =", Bacteria_data2$Medium), subtitle = paste("Temperature =", Bacteria_data2$Temp," Species =",Bacteria_data2$Species)))
break
}

dev.off()
###add temperature and strain 


   