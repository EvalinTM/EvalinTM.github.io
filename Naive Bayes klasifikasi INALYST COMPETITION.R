#Packages 
library(e1071)
library(caret)
library(mlbench)
library(openxlsx)

#### load data
dataTrain<-read.xlsx("D:/Data Enthusiast/Inalyst Competition/train.xlsx", 3)
datatest <- read.xlsx("D:/Data Enthusiast/Inalyst Competition/test.xlsx", 2)
str(dataTrain)
str(datatest)
names <- c('gender' ,'phone_flag', 
           'student', 'employment', 
           'credit_card', 'hasil')
dataTrain[,names] <- lapply(dataTrain[,names] , factor)
str(dataTrain)
head(dataTrain, 6)
names_test <- c('gender' ,'phone_flag', 
                'student', 'employment', 
                'credit_card')
datatest[,names_test] <- lapply(datatest[,names_test] , factor)
str(datatest)

#Membagi data menjadi data training dan testing
set.seed(1000)
id<-sample(1:nrow(dataTrain),round(0.75*nrow(dataTrain),0))
dataTrain<-dataTrain[id,]
DataTest<-dataTrain[-id,-9]
DataTest_Y<-dataTrain[-id,9]

#Model NaiveBayes
model <- naiveBayes(hasil ~ .,
                    data=dataTrain)
model

prediksitrain <- predict(model, DataTest)

#Evaluasi Prediksi
confusionMatrix(prediksitrain,DataTest_Y)

#Prediksi data test
prediksi <- predict(model, newdata = datatest)
prediksi
write.xlsx(prediksi, "PredictInalyst5.xlsx")
