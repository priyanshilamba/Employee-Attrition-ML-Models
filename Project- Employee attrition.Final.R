library(DescTools)
library(dplyr)
library(dvmisc)
library(Hmisc)
library(moments)
library(purrr)
library(rstatix)
library(regclass)
library(lm.beta)
library(ggplot2)
library(caret)
library(rpart.plot)
library(naivebayes)
library(randomForest)

E<- EmployeeAttrition
str(E)
E<- as.data.frame(E)

E[,-c(1,5,7,11,12,13,14,15,16,17)]<-lapply(E[,-c(1,5,7,11,12,13,14,15,16,17)],factor)

E$TotalWorkingYears<-as.numeric(E$TotalWorkingYears)
E$NumCompaniesWorked<-as.numeric(E$NumCompaniesWorked)


#checking missing value
map(E,~sum(is.na(.)))

#Treating missing values
E[12]<-impute(E[12], fun = median)
E[14]<-impute(E[14], fun = median)


#Checking outliers
boxplot(E$Age, E$DistanceFromHome, E$MonthlyIncome, E$NumCompaniesWorked)
boxplot(E$PercentSalaryHike, E$TotalWorkingYears, E$YearsAtCompany, E$YearsSinceLastPromotion, E$YearsWithCurrManager)

#checking normality
skewness<-lapply(E[,c(1,5,11,12,13,14,15,16,17)],skewness)
skewness
kurtosis<-lapply(E[,c(1,5,11,12,13,14,15,16,17)],kurtosis)
kurtosis


#Variables: MonthlyIncome, NumCompaniesWorked, TotalWorkingYears, YearsAtCompany, YearsSinceLastPromotion, YearsWithCurrManager have outliers
#Treatment of outliers

E$MI<-sqrt(E$MonthlyIncome) 
E$YSLP<-sqrt(E$YearsSinceLastPromotion)
E$YWCM<-log10(E$YearsWithCurrManager+1)
E$NCW<-sqrt(E$NumCompaniesWorked)
E$YAC<-log10(E$YearsAtCompany+1)
E$TWY<-log10(E$TotalWorkingYears+1)


skewness(E$TWY)
skewness(E$YAC)
boxplot(E$TWY)


boxplot(E$TotalWorkingYears)
boxplot(E$YearsAtCompany)

outYAC<-boxplot(E$YAC)$out
outTWY<-boxplot(E$TWY)$out

length(outYAC) 
length(outTWY)

# Replace the outliers with NA i.e. missing values
E[E$YAC %in% outYAC, "YAC"] = NA
E[E$TWY %in% outTWY, "TWY"] = NA

# impute NA or missing values
E[22]<-impute(E[22], fun=median)
E[23]<-impute(E[23], fun=median)

skewness(E$TWY)
kurtosis(E$TWY)
skewness(E$YAC)
kurtosis(E$YAC)
boxplot(E$YAC)
boxplot(E$TWY)

str(E)

skewness<-lapply(E[,c(1,5,13,18,19,20,21,22,23)],skewness)
skewness


x<-E[,c(1,5,13,18,19,20,21,22,23)]
cor(x)

E1<-E
str(E1)
E1<-E1[-10]
E1<-E1[-10]
E1<-E1[-11]
E1<-E1[-11]
E1<-E1[-11]
E1<-E1[-11]

##################################################################################

#Logistic regression

#Data partition
set.seed(100)
Train <- createDataPartition(E1$Attrition, p=0.8, list=FALSE)
training <- E1[ Train, ]
testing <- E1[ -Train, ]

#Model 1 

Model1 <- train(data=training, Attrition~., method="glm", family="binomial")
summary(Model1)

# prediction for test data
predAttrition1<-predict(Model1, newdata = testing)

#fitness metrics for validation
confusionMatrix(predAttrition1, testing$Attrition, positive = "No")


#################################################################################

#Naive Bayes

Model2 <- train(Attrition~., data=training, method="naive_bayes")

# prediction for test data
predAttrition2<-predict(Model2, newdata = testing)

#fitness metrics for validation
confusionMatrix(predAttrition2, testing$Attrition, positive="No")


#################################################################################

#Decision Trees
Model3<-train(Attrition~.,data = training , method = "rpart")
rpart.plot(Model3$finalModel)
predAttrition3<-predict(Model3 , newdata = testing)
confusionMatrix(predAttrition3, testing$Attrition)


#################################################################################

#Random Forest
Model4 <- train(Attrition~., data=training, method="rf")
Model4$finalModel
varImp(Model4)
predAttrition4<-predict(Model4, newdata = testing)
confusionMatrix(predAttrition4, testing$Attrition)

