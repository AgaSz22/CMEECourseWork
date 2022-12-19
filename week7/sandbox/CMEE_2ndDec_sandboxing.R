df10 <-data.frame(output_table_full$AICc_logistic, output_table_full$AICc_quadratic, output_table_full$AICc_cubic)
colnames(df10)[1] <- "a.logistic"
colnames(df10)[2] <- "quadratic"
colnames(df10)[3] <- "cubic"
df10$Comparison<-colnames(df10)[apply(df10,1,which.min)] ###Checking which model was the best for each ID

outcome <- table(df10$Comparison)###Assessing which model was the best overall

######## Some graphs for the report #######

pdf(file = "../data/pie_chart_plot.pdf")

x <- c(149, 39, 56)
labels <- c("Logistic model", "Quadratic model", "Cubic model")
pie(x,labels)

dev.off()

### Violin plots showing the distribution of AICc values ###

data_violin <- df10[,-4]
data_violin <- melt(df10, id = "Comparison")
data_violin <- data_violin[,-1]

colnames(data_violin)[1] <- "Model_type"
colnames(data_violin)[2] <- "AICc_value"

###consider as.numeric and as.factor commands

str(data_violin)

data_violin$AICc_value <- as.numeric(data_violin$AICc_value)
data_violin$Model_type <- as.factor(data_violin$Model_type)

pdf("../data/violin_plot.pdf")

g <- ggplot(data_violin, aes(x=Model_type, y=AICc_value, fill=Model_type), group = Model_type) +
  geom_violin() +
  geom_boxplot() +
  stat_summary(fun="mean") +
  labs(x = "Model", y = "AICc value")

g <- g + theme_classic()

print(g) 

dev.off()

######### Make a sound when done #########
beep(sound = 6, expr = NULL)


######### ANOVA testing ######### 
all_values <- data_violin$AICc_value ###visually assessing the distribution of residuals
hist(all_values, breaks = 100)
anova_outcome <- aov(AICc_value ~ Model_type, data = data_violin) ###performing ANOVA
summary(anova_outcome)