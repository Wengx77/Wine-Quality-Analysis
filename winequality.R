library("ggplot2")
library("dplyr")
library("gridExtra")
library(gridExtra)
library(corrplot)
library(pander)
library(memisc)

redwine <- read.csv("~/Desktop/RPI-2/Data analytics/assignment/my assign/assign 7/winequality-red.csv",sep=";")
whitewine <- read.csv("~/Desktop/RPI-2/Data analytics/assignment/my assign/assign 7/winequality-white.csv", sep=";")
# summary of dataset
str(redwine)
summary(redwine)

str(whitewine)
summary(whitewine)
#Observation from the summary
#1. the dataset contain 12 variables with 1599 observations;
#2. the big range of total.sulfur.diocide as compared to free.sulfur.dioxide;
#3. the quality of sample wine range from 3 to 8 with 6 being the median;
#4. the PH value from 2.74 to 4.01 with the median of 3.31, so the wine is acidity;
#5. the range of fixed.acidity is quite high with minimum of 4.6 ane maximum of 15.90.

#distribution of variables
par(mfrow = c(1,2))
quality1 <- hist(redwine$quality, main="Red Wine Quality", xlab="", col="red")
quality2 <- hist(whitewine$quality, main="White Wine Quality", xlab="", col="blue")

alcohol1 <- hist(redwine$alcohol, main="Red Wine Alcohol Content", xlab="", col="red")
alcohol2 <- hist(whitewine$alcohol, main="White Wine Alcohol Content", xlab="", col="blue")
#rate the quality
redwine$quality <- factor(redwine$quality, ordered =T)
whitewine$quality <- factor(whitewine$quality, ordered =T)
redwine$rating <- ifelse(redwine$quality <5, 'bad', ifelse(
  redwine$quality <7, 'average', 'good'))
redwine$rating <- ordered(redwine$rating,
                          levels = c('bad', 'average', 'good')) 
str(redwine)
summary(redwine)

whitewine$rating <- ifelse(whitewine$quality <5, 'bad', ifelse(
  redwine$quality <7, 'average', 'good'))
whitewine$rating <- ordered(whitewine$rating,
                          levels = c('bad', 'average', 'good'))
str(whitewine)
summary(whitewine)
plot(redwine$rating, main="Red Wine Quality Rate", col="red")
plot(whitewine$rating, main="White Wine Quality Rate", col="blue")
#Univariate analysis
p1 <- qplot(x=fixed.acidity, data =redwine)
p2 <- qplot(x=volatile.acidity, data =redwine)
p3 <- qplot(x=citric.acid, data =redwine)
p4 <- qplot(x=residual.sugar, data =redwine)
p5 <- qplot(x=chlorides, data =redwine)
p6 <- qplot(x=free.sulfur.dioxide, data =redwine)
p7 <- qplot(x=total.sulfur.dioxide, data =redwine)
p8 <- qplot(x=density, data =redwine)
p9 <- qplot(x=pH, data =redwine)
p10 <- qplot(x=sulphates, data =redwine)
p11 <- qplot(x=alcohol, data =redwine)
grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11, ncol=2)

p11 <- qplot(x=fixed.acidity, data =whitewine)
p12 <- qplot(x=volatile.acidity, data =whitewine)
p13 <- qplot(x=citric.acid, data =whitewine)
p14 <- qplot(x=residual.sugar, data =whitewine)
p15 <- qplot(x=chlorides, data =whitewine)
p16 <- qplot(x=free.sulfur.dioxide, data =whitewine)
p17 <- qplot(x=total.sulfur.dioxide, data =whitewine)
p18 <- qplot(x=density, data =whitewine)
p19 <- qplot(x=pH, data =whitewine)
p110 <- qplot(x=sulphates, data =whitewine)
p111 <- qplot(x=alcohol, data =whitewine)
grid.arrange(p11,p12,p13,p14,p15,p16,p17,p18,p19,p110,p111, ncol=2)

#Bivariate Plots
c <- cor(
  redwine %>%
    dplyr::select(-rating)%>%
    mutate(
      quality = as.numeric(quality)
    )
)
emphasize.strong.cells(which (abs(c) >.3 & c !=1, arr.ind =TRUE))
pandoc.table(c)

c <- cor(
  whitewine %>%
    dplyr::select(-rating)%>%
    mutate(
      quality = as.numeric(quality)
    )
)
emphasize.strong.cells(which (abs(c) >.3 & c !=1, arr.ind =TRUE))
pandoc.table(c)
# as we can see, the volatile acidity has an negatibe correlation with quality
ggplot(data=redwine, aes(x=quality, y=volatile.acidity))+
  geom_jitter(alpha = .3)+
  geom_boxplot(alpha = .5, color= "blue")+
  stat_summary(fun.y="mean", geom="point", color="red", shape = 8, size = 4)
ggplot(data=whitewine, aes(x=quality, y=volatile.acidity))+
  geom_jitter(alpha = .3)+
  geom_boxplot(alpha = .5, color= "blue")+
  stat_summary(fun.y="mean", geom="point", color="red", shape = 8, size = 4)

ggplot(data=redwine, aes(x=quality, y= citric.acid))+
  geom_jitter(alpha=.3)+
  geom_boxplot(alpha = .5, color = "blue")+
  stat_summary(fun.y = "mean", geom="point", color="red", shape = 8, size =4)
ggplot(data=whitewine, aes(x=quality, y= citric.acid))+
  geom_jitter(alpha=.3)+
  geom_boxplot(alpha = .5, color = "blue")+
  stat_summary(fun.y = "mean", geom="point", color="red", shape = 8, size =4)

ggplot(data=redwine, aes(x=quality, y= alcohol))+
  geom_jitter(alpha=.3)+
  geom_boxplot(alpha = .5, color = "blue")+
  stat_summary(fun.y = "mean", geom="point", color="red", shape = 8, size =4)
whitewine$quality <- as.factor(whitewine$quality)
ggplot(data=whitewine, aes(x=quality, y= alcohol))+
  geom_jitter(alpha=.3)+
  geom_boxplot(alpha = .5, color = "blue")+
  stat_summary(fun.y = "mean", geom="point", color="red", shape = 8, size =4)
ggplot(data=whitewine, aes(x=quality, y=density))+
  geom_jitter(alpha = .3)+
  geom_boxplot(alpha = .5, color= "blue")+
  stat_summary(fun.y="mean", geom="point", color="red", shape = 8, size = 4)

ggplot(data=redwine, aes(x=quality, y= sulphates))+
  geom_jitter(alpha=.3)+
  geom_boxplot(alpha = .5, color = "blue")+
  stat_summary(fun.y = "mean", geom="point", color="red", shape = 8, size =4)
ggplot(data=whitewine, aes(x=quality, y= sulphates))+
  geom_jitter(alpha=.3)+
  geom_boxplot(alpha = .5, color = "blue")+
  stat_summary(fun.y = "mean", geom="point", color="red", shape = 8, size =4)

ggplot(data=redwine, aes(x=quality, y= total.sulfur.dioxide))+
  geom_jitter(alpha=.3)+
  geom_boxplot(alpha = .5, color = "blue")+
  stat_summary(fun.y = "mean", geom="point", color="red", shape = 8, size =4)
ggplot(data=whitewine, aes(x=quality, y= total.sulfur.dioxide))+
  geom_jitter(alpha=.3)+
  geom_boxplot(alpha = .5, color = "blue")+
  stat_summary(fun.y = "mean", geom="point", color="red", shape = 8, size =4)
#the low density is due to higher alcohol content which actually is the driving factor for better wines.

# start build the model - linear regression
redwine$newsul <- log(redwine$sulphates)

ggplot(data=redwine, aes(x=quality, y= newsul))+
  geom_jitter(alpha=.3)+
  geom_boxplot(alpha = .5, color = "blue")+
  stat_summary(fun.y = "mean", geom="point", color="red", shape = 8, size =4)

#Linear Modeling
redwine$ID <- seq.int(nrow(redwine)) 

set.seed(1300)
trainRW <- sample_frac(redwine, .6)
testRW <- redwine[!redwine$ID %in% trainRW$ID, ]
m1 <- lm(as.numeric(quality) ~alcohol, data = trainRW)
m2 <- update(m1, ~ . +newsul)
m3 <- update(m2, ~ . +volatile.acidity)
m4 <- update(m3, ~ . +citric.acid)
m5 <- update(m4, ~ . +fixed.acidity)
m6 <- update(m2, ~ . +pH)
summary(m1)
summary(m2)
summary(m3)
summary(m4)
summary(m5)
summary(m6)

whitewine$ID <- seq.int(nrow(whitewine))

set.seed(1300)
trainWW <- sample_frac(whitewine, .6)
testWW <- whitewine[!whitewine$ID %in% trainWW$ID, ]
m11 <- lm(as.numeric(quality) ~alcohol, data = trainWW)
m12 <- update(m11, ~ . +sulphates)
m13 <- update(m12, ~ . +volatile.acidity)
m14 <- update(m13, ~ . +citric.acid)
m15 <- update(m14, ~ . +fixed.acidity)
m16 <- update(m12, ~ . +pH)
m17 <- update(m11, ~ . +volatile.acidity)
summary(m11)
summary(m12)
summary(m13)
summary(m14)
summary(m15)
summary(m16)
summary(m17)


library(forecast)
install.packages("fracdiff")
predicRW<-predict(m5, testRW)
predicRW
accuracy(predicRW, as.numeric(testRW$quality))
actual_preds <- data.frame(cbind(actuals=testRW$quality, predicteds=predicRW))
correlation_accuracy <- cor(actual_preds)
correlation_accuracy #60.8%
head(actual_preds)

predicWW<-predict(m15, testWW)
predicWW
accuracy(predicWW, as.numeric(testWW$quality))
actual_preds <- data.frame(cbind(actuals=testWW$quality, predicteds=predicWW))
correlation_accuracy <- cor(actual_preds)
correlation_accuracy 
head(actual_preds)

#Validation of LM
library(DAAG)
cvResults <- suppressWarnings(CVlm(data= redwine, form.lm = m5, m = 5,
                                   dots = FALSE,seed=29, legend.pos = "topleft", printit=FALSE, 
                                   main="Small Symbols are predicted values while bigger ones are actuals."))
attr(cvResults, 'ms')

  

# predict error
RW_predict <- data.frame(
  testRW$quality, predict(m5, testRW) - as.numeric(testRW$quality)
)
names(RW_predict) <- c("quality", "error")
ggplot(data = RW_predict, aes(x=quality, y=error))+
  geom_jitter(alpha=0.3)

# multivariate plot
ggplot(data = redwine, aes(y=sulphates, x= alcohol, color = quality)) +
  geom_point(alpha = 0.8, size =1)+
  geom_smooth(method = "lm", se = FALSE, size =1) +
  scale_y_continuous(limits = c(0.3,1.5))+
  ylab("potassium sulphate (g/dm3)")+
  xlab("Alcohol Percentage")+
  scale_color_brewer(type='seq', 
                     guide=guide_legend(title="Quality"))+
  ggtitle("Alcohol and Sulphates over wine quality")


df <- data.frame(
  testRW$quality, predict(m5, testRW) - as.numeric(testRW$quality)
)
names(df) <- c("quality", "error")
ggplot(data=df, aes(x=quality, y=error))+
  geom_jitter(alpha=0.3) +
  ggtitle("Red wine error vs. expected quality")

df_1 <- data.frame(
  testWW$quality, predict(m15, testWW) - as.numeric(testWW$quality)
)
names(df_1) <- c("quality", "error")
ggplot(data=df_1, aes(x=quality, y=error))+
  geom_jitter(alpha=0.3) +
  ggtitle("White wine error vs. expected quality")

# second model
library(randomForest)
table(redwine$rating)

set.seed(123)
samp <- sample(nrow(redwine), 0.6* nrow(redwine))
train2 <- redwine[samp, ]
test2 <- redwine[-samp, ]

#build the model
RFm <- randomForest(rating ~ . -quality, data = train2)
RFm 

RFpred <- predict(RFm, newdata = test2)
table(RFpred, test2$rating)
# the predicted accuracy is 85.8%

library("party")
RT_1<-ctree(rating ~., data=train2)
plot(RT_1,type="simple")

set.seed(123)
samp_1 <- sample(nrow(whitewine), 0.6* nrow(whitewine))
train2_1 <- whitewine[samp_1, ]
test2_1 <- whitewine[-samp_1, ]

#build the model
RFm_1 <- randomForest(rating ~ . -quality, data = train2_1)
RFm_1 

RFpred_1 <- predict(RFm_1, newdata = test2_1)
table(RFpred_1, test2_1$rating)
# the predicted accuracy is 82.8%

library("party")
RT_2<-ctree(rating ~., data=train2_1)
plot(RT_2,type="simple")

# thrid model knn
library(caret)
knRW <- trainControl(method = "repeatedcv" , number =10, repeats=3)
set.seed(1234)
knfit <- train(quality ~. , data = train2, method = "knn",
               trControl=knRW, 
               preProcess = c("center", "scale"),
               tuneLength = 10)

knfit #knn classifier
plot(knfit) # plot accuracy vs K value graph

knpredict <- predict(knfit, newdata = test2)
knpredict

confusionMatrix(knpredict, test2$quality) 

knWW <- trainControl(method = "repeatedcv" , number =10, repeats=3)
set.seed(1234)
knfit_1 <- train(quality ~. , data = train2_1, method = "knn",
               trControl=knWW, 
               preProcess = c("center", "scale"),
               tuneLength = 10)

knfit_1 
plot(knfit_1) 

knpredict_1 <- predict(knfit_1, newdata = test2_1)
knpredict_1

confusionMatrix(knpredict_1, test2_1$quality) 



