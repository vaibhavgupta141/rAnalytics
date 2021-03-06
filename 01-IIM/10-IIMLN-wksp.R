#IIMLN
#day1

mtcars
?mtcars   #help on mtcars
class(mtcars)
x= 1:5
class(x)
x
y=c(1, 3.5,5)
y
class(y)
class(as.integer(y))
as.integer(y)
z=c(1L, 3L, 5L)
z
class(z)
str(mtcars)
?str
summary(mtcars)

#vectors----
x = 1:5
x
x1 = c(1,2,3,4,5)
x1
(x3 = c(2,4,36,3))
x3
print(x3)
x3
x3[2]
plot(x3)
(x4 = rnorm(n=100, mean=60, sd=10))
plot(x4)
plot(density(x4))
hist(x4)
hist(x4, breaks=10, col=1:10)
range(x4)
min(x4); max(x4)
mean(x4) ; median(x4)
boxplot(x4)
sort(x4)
sort(x4, decreasing = TRUE)
plot(sort(x4), type='b') #line and point
plot(x4, type='l')
x4[x4>65]
mean(x4[x4 > 65])  #mean of values more than 65
x4
x4[1:10]
x4[91:100]
x4[-c(1:10)]
x4[x4 > 65]
length(x4[x4 > 65])
sum(x4 > 65)
rev(x4)
sum(x4[x4 > 65])
x4[x4 > 60 & x4 < 70]
sum(x4)
#
#matrices----
(data = c(10,30,40,44,22,55))
(m1 = matrix(data = data, nrow=2))
(m2 = matrix(data = data, nrow=2, byrow=T))
rownames(m1) = c('R1','R2')
m1
colnames(m1) = c('C1','C2','C3')
m1
m1[1,]
m1['R1', ]
m1[,3]
m1
m1[,2:3]
m1[, c('C1','C3')]
colSums(m1)
rowSums(m1)
colMeans(m1)
rowMeans(m1)
apply(m1, 1, FUN=min)
m1
apply(m1[, 'C2', drop=F], 2, FUN=max)

#dataframe----
(rollno = paste('IIMLN', 1:13, sep='-'))
(name = paste('Student',1:13, sep=' & '))
(age = round(runif(13, min=24, max=32),2))
(marks = trunc(rnorm(13, mean=60, sd=10)))
set.seed(34)
(gender =  sample(c('M','F'), size=13, replace=T, prob=c(.7, .3)))
table(gender)
prop.table(table(gender))
(x=c(-14.35, 14.35, -14.55, 15.35))
floor(x) ;  ceiling(x) ; trunc(x)
set.seed(55)
(grade =  sample(c('Ex','Good','Sat'), size=13, replace=T, prob=c(.6, .3,.1)))
table(grade)
prop.table(table(grade))
sapply(list(rollno, name, age, marks, gender, grade), length)
(students = data.frame(rollno, name, age, marks, gender, grade, stringsAsFactors = F ))

write.csv(students,'data/students.csv' , row.names = F )

df1 = read.csv('data/students.csv')
df1

df2 = read.csv('https://raw.githubusercontent.com/DUanalytics/rAnalytics/master/data/students.csv')
df2

df3 = read.csv(file.choose())
df3

students
#install.packages("dplyr")


class(students)
summary(students)
str(students)
students$gender = factor(students$gender)
str(students)
students$grade = factor(students$grade, ordered=T, levels=c('Ex','Sat','Good'))
str(students)
table(students$gender)
table(students$grade)

students
library(dplyr)  #loading library

students %>% group_by(gender)  %>% tally()
students %>% group_by(gender)  %>% summarise(mean(age), n(), min(marks), max(marks))
students %>% group_by(gender, grade)  %>% summarise(mean(age))



#dplyr - mtcars
library(dplyr)
#library(tidyverse)
#Filter----
mtcars
filter(mtcars, cyl == 8)
filter(mtcars, cyl < 6)

# Multiple criteria
filter(mtcars, cyl < 6 & vs == 1)
filter(mtcars, cyl < 6 | vs == 1)

# Multiple arguments are equivalent to and
filter(mtcars, cyl < 6, vs == 1)


filter(mtcars, row_number() == 1L)
filter(mtcars, row_number() == n())
filter(mtcars, between(row_number(), 5, n()-2))


#day2:21Feb20------
library(dplyr)
mtcars
table(mtcars$cyl)
summary(mtcars$cyl)
mtcars %>% group_by(cyl)  %>% tally()
mtcars %>% group_by(cyl)  %>% summarise(COUNT = n())
xtabs( ~ cyl, data=mtcars)
ftable(mtcars$cyl)
#gear & cyl
table(mtcars$cyl, mtcars$gear)
table(mtcars$cyl, mtcars$gear, dnn=c('cylinder','gear'))
mtcars %>% group_by(cyl, gear) %>% tally()
mtcars %>% group_by(cyl, gear) %>% summarise(COUNT = n())
mtcars %>% group_by(cyl, mpg) %>% summarise(COUNT = n()) %>% as.data.frame()

xtabs(  ~ cyl + gear, data=mtcars)
ftable(mtcars$cyl, mtcars$gear)
table(mtcars$cyl, mtcars$gear, mtcars$am, dnn=c('Cyl','Gear','AutoManual'))

df = mtcars
head(df)   
tail(df)
df$am= ifelse(df$am==0, 'Auto', 'Manual')
df
mtcars %>% mutate(TxType = ifelse(am==0, 'Auto', 'Manual'))
mtcars %>% mutate(TxType = ifelse(am==0, 'Auto', 'Manual')) %>% group_by(TxType) %>% summarise(COUNT = n())
mtcars                  
df = mtcars
df$mpg
df[,'mpg']
df
head(df)
df = df %>% mutate(TxType = ifelse(am==0, 'Auto', 'Manual'))
head(df)
#increase mileage by 10%
df$mpg * 1.1
#add mpg + wt into new column MPGWT
df$mpg  + df$wt
df$MPGWT = df$mpg * 1.1  + df$wt
head(df)
df
#top 2 cars from mpg from each gear type : use group_by & top_n
?top_n
df %>% group_by(gear) %>% top_n(n=2, wt=mpg) %>% select(gear, mpg)
df %>% group_by(gear) %>% arrange(-mpg)  %>% select(gear, mpg)
df %>% group_by(gear) %>% top_n(n=2, wt=-mpg) %>% select(gear, mpg)

#list out details of any 2 cars picked randomly: then do 25% of the cars
df %>% sample_n(2)
df %>% sample_frac(.25)
#sort on mpg
df %>% sample_frac(.25)  %>%  arrange(mpg)
#ascending gear, descending mpg
df %>% sample_frac(.25)  %>%  arrange(gear, desc(mpg))

sort(df$mpg)
df[ order(df$mpg), ]
df %>% slice(1)
df %>% slice(10:15)

#find mean of mpg, wt, hp, disp for each gear type
df %>% group_by(gear)  %>% summarise_at(c('mpg','wt', 'hp','disp'),c(mean))
df %>% group_by(gear)  %>% summarise_at(c('mpg','wt', 'hp','disp'),c(mean, median))
df %>% select(gear, mpg, wt, hp,disp) %>% group_by(gear) %>% summarise_all(mean)
#find min and max of wt for each gear type
df %>% select(mpg, wt, gear) %>% group_by(gear) %>% summarise_each(c(min, max))


#graphs----
hist(df$mpg)
barplot(table(df$gear), col=1:3)
L1 <- paste(round(table(df$gear)/nrow(df) * 100),'%')

pie(table(df$gear), labels=c('gear3','G4','G5'))
pie(table(df$gear), labels=L1, col=1:3)
plot(df$wt, df$mpg)

library(ggplot2)
library(reshape2)
#install.packages('ggplot2')  #this is in simple R
#install.packages('reshape2')

(rollno = paste('IIM',1:10, sep='_'))
(name = paste('SName',1:10, sep=' '))
(gender = sample(c('M','F'), size=10, replace=T, prob=c(.7,.3)))
(program = sample(c('BBA','MBA'), size=10, replace = T))
(marketing = trunc(rnorm(10, mean=60, sd=10)))
(operations = trunc(rnorm(10, mean=70, sd=5)))
(finance = trunc(rnorm(10, mean=55, sd=12)))
students <- data.frame(rollno, name, gender, program, marketing, finance, operations, stringsAsFactors = F)
students
head(students)
#students %>% group_by(gender, program)  %>% summarise(mean(marketing), mean(finance), mean(operations))

(meltSum1 <- melt(students, id.vars=c('rollno','name', 'gender','program'), variable.name = 'subject', value.name ='marks'))
meltSum1
head(meltSum1)
sum2 <- meltSum1 %>% group_by(program, gender, subject) %>% summarise(MeanMarks = mean(marks))
head(sum2)
ggplot(data=sum2, aes(x=gender, y=MeanMarks, fill=gender)) + geom_bar(stat='identity') + facet_grid(program ~ subject)
#



students
head(students, n=2)
students %>% group_by(gender) %>% summarise(COUNT = n())
ggplot(students %>% group_by(gender) %>% summarise(COUNT = n()), aes(x=gender, y=COUNT, fill=gender)) + geom_bar(stat='identity') + geom_text(aes(label=COUNT)) + labs(title='Gender Wise Count')
#stacked bar
ggplot(students %>% group_by(program, gender) %>% summarise(COUNT = n()), aes(x=gender, y=COUNT, fill=program)) + geom_bar(stat='identity') + geom_text(aes(label=COUNT)) + labs(title='Gender Wise - Program Count')
#side by side
ggplot(students %>% group_by(program, gender) %>% summarise(COUNT = n()), aes(x=gender, y=COUNT, fill=program)) + geom_bar(stat='identity',position = position_dodge2(.7)) + geom_text(aes(label=COUNT), position = position_dodge2(.7)) + labs(title='Gender Wise - Program Count')
#Subject - Program - Gender - Mean Marks 
names(students)
names(meltSum1)
head(meltSum1)
ggplot(meltSum1 %>% group_by(program, gender, subject) %>% summarise(meanMarks = round(mean(marks))), aes(x=gender, y=meanMarks, fill=program)) + geom_bar(stat='identity',position = position_dodge2(.7)) + geom_text(aes(label=meanMarks), position = position_dodge2(.7)) + labs(title='Subject - Program - Gender - Mean Marks ') + facet_grid(~ subject)

ggplot(mtcars, aes(x=wt, y=mpg, size=hp, color=factor(gear), shape=factor(am))) + geom_point()
#
ggplot(students, aes(x=gender, y=..count..)) + geom_bar(stat='count')


#
(dcastSum1 <- dcast(meltSum1, rollno + name ~ variable, value.var='value'))
?recast
recast(data=students,  gender ~ variable, fun.aggregate=mean )




#day3 : 23 Feb -----
(x = c(1,2,4,5))
sum(x)
#(x2 = c(1,2,,4, ,5))   #error
(x2 = c(1,2,NA,4,NA,5))
sum(x2)  # NA
sum(x2, na.rm=T) #12
?sum
length(x2)
is.na(x2)
sum(c(T,F,T,F,T))
sum(is.na(x2))
sum(is.na(x2))/length(x2)  #% perc of missing values
x2
mean(x2, na.rm=T)
x2[is.na(x2)]
x2[c(F,F,T,F,T,T)]
x2[is.na(x2)] = mean(x2, na.rm=T)
x2

library(VIM)
data(sleep)
sleep
?sleep
head(sleep)
tail(sleep)
str(sleep)
dim(sleep)
length(sleep)
summary(sleep)
(x=200:300)
quantile(x)
quantile(x, seq(0,1,.25))
quantile(x, seq(0,1,.1))
quantile(x, seq(0,1,.01))

head(sleep)
is.na(sleep)
sum(is.na(sleep))
colSums(is.na(sleep))
rowSums(is.na(sleep))
complete.cases(sleep)
sum(complete.cases(sleep))
sleep[complete.cases(sleep), ]
sleep[!complete.cases(sleep), ]
(xy = colSums(is.na(sleep)))
xy[xy > 0]
(c1 <- names(xy[xy > 0]))
sleep[ , c1]
sleep %>% select(c1) %>% length()
sleep %>% select(-c1)  %>% length()

`%notin%` <- Negate(`%in%`)
c2 <- names(sleep) %notin% c1
sleep[ , c2]

#data partitioning
(x = trunc(rnorm(100, mean=60, sd=15)))
set.seed(134)
s1 <- sample(x, size=70)
length(s1)
sum(s1)

s2 <- sample(x, size=.7 * length(x))
length(s2)
x

mtcars
mtcars %>% sample_n(24)
mtcars %>% sample_frac(.7)
dim(mtcars); nrow(mtcars)
(index = sample(1:nrow(mtcars), size=.7 * nrow(mtcars)))
mtcars[ index, ]
dim(mtcars[index, ])
mtcars[ -index, ]

#clusterpackages <- c('factoextra', 'dendextend','NbClust', 'cluster','fpc', 'amap','animation')
#arulepackages <- c('arules','arulesViz')
#classpackages <- c('rpart','rpart.plot')
#iepackages <- c('gsheet', 'readxl', 'rJava', 'xlsx')
#statspackages <- c('modeest','fdth','e1071','caTools', 'caret' )
#tspackages <- c('timeSeries','xts','zoo','forecast','TTR','quantmod', 'lubridate','smooth','Mcomp')
#tmpackages <- c('rtweet',"curl", 'twitterR', 'ROAuth', 'syuzhet','wordcloud', 'wordcloud2')
#lppackages <- c('lpSolve', 'linprog', 'lpSolveAPI')

#install.packages(pinstall)  #replace pinstall with name of vector of package list

#Multiple Install
list.of.packages <- plist #substitute plist with name of list of packages
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load if avl, install if not avl---
#Load if available, install packages if not available in the system & then load
if (!require("quantmod")) {
  install.packages("quantmod")
  library(quantmod)
}
#---------------------------------------------
#data partition
library(caTools)
sample = sample.split(Y=mtcars$am, SplitRatio = .7)
sample
table(sample)
prop.table(table(sample))
(y1= mtcars[sample==T,])  #TRUE set
y2= mtcars[sample==F,]  #FALSE set
table(y1$am) ; prop.table(table(y1$am))
table(y2$am) ; prop.table(table(y2$am))

library(caret)
(intrain <- createDataPartition(y = mtcars$am, p=.7, list=F))
train <- mtcars[ intrain, ]
test <- mtcars[ - intrain, ]
prop.table(table(train$am)) ; prop.table(table(test$am))
           


#linear regression----

women
head(women)
model = lm(weight ~ height, data=women)
summary(model)
#y = mx + c
#weight = 3.45 * height + - 87.51
plot(x=women$height, y=women$weight)
abline(model, col=2)
residuals(model)
women$weight
predWt <- predict(model, newdata=women, type='response')
head(women)
3.45 * 58 - 87
cbind(women, predWt, res = women$weight - predWt, res2= residuals(model))
summary(model)
sqrt(sum(residuals(model)^2))  #SSE

(ndata = data.frame(height=c(66.5, 75.8)))
predict(model, newdata=ndata, type='response')
confint(model)

#case2 : LR -----
link = "https://docs.google.com/spreadsheets/d/1h7HU0X_Q4T5h5D1Q36qoK40Tplz94x_HZYHOJJC_edU/edit#gid=2023826519"
library(gsheet)
df = as.data.frame(gsheet2tbl(link))
head(df)
model2 = lm(Y ~ X, data =df)
plot(df$X, df$Y)
abline(model2)

#write your inferences
#R2
#does model exists
#coeff values
#SSE value
summary(model2)
resid(model2)
range(df$X)
ndata2 = data.frame(X=c(3,4))
predict(model2, newdata=ndata2, type='response')
#assumptions 
plot(model)


#MLM - promotion sales
link2 = "https://docs.google.com/spreadsheets/d/1h7HU0X_Q4T5h5D1Q36qoK40Tplz94x_HZYHOJJC_edU/edit#gid=1595306231"

df2 = as.data.frame(gsheet2tbl(link2))
head(df2)
plot(df2$price, df2$sqty)
plot(df2$promotion, df2$sqty)

model3 <- lm(sqty ~ price + promotion     , data=df2)
summary(model3)
plot(model3)
plot(df2$price, df2$sqty)
abline(model3, col=2)
plot(df2$promotion, df2$sqty)
abline(model3, col=4)
range(df2$price) ; range(df2$promotion)
(ndata3 = data.frame(price=c(60, 75), promotion=c(300, 500)))
predict(model3, newdata=ndata3, type='response')
plot(model3)

#decision trees-----
# Decision Tree - Classification
#we want predict for combination of input variables, is a person likely to survive or not

#import data from online site
path = 'https://raw.githubusercontent.com/DUanalytics/datasets/master/csv/titanic_train.csv'
titanic <- read.csv(path)
head(titanic)
names(titanic)
data = titanic[,c(2,3,5,6,7)]  #select few columns only
head(data)
dim(data)
#load libraries
library(rpart)
library(rpart.plot)
str(data)
#Decision Tree
names(data)
table(data$Survived)
prop.table(table(data$Survived))

str(data)
data$Pclass = factor(data$Pclass)
fit <- rpart(Survived ~ ., data = data, method = 'class')
fit
rpart.plot(fit, extra = 104, cex=.8,nn=T)  #plot
head(data)
printcp(fit) #select complexity parameter
prunetree2 = prune(fit, cp=.017544)
rpart.plot(prunetree2, cex=1,nn=T, extra=104)
prunetree2
nrow(data)
table(data$Survived)
# predict for Female, pclass=3, siblings=2, what is the chance of survival

#Predict class category or probabilities
(testdata = sample_n(data,2))
predict(prunetree2, newdata=testdata, type='class')
predict(prunetree2, newdata=testdata, type='prob')
str(data)
testdata2 = data.frame(Pclass=factor(2), Sex=factor('male'), Age=15, SibSp=2)
testdata2
predict(prunetree2, newdata = testdata2, type='class')
predict(prunetree2, newdata = testdata2, type='prob')

#Use decision trees for predicting
#customer is likely to buy a product or not with probabilities
#customer is likely to default on payment or not with probabilities
#Student is likely to get selected, cricket team likely to win etc

#Imp steps
#select columns for prediction
#load libraries, create model y ~ x1 + x2 
#prune the tree with cp value
#plot the graph
#predict for new cases

#rpart, CART, classification model
#regression decision = predict numerical value eg sales

#Clustering ------
set.seed(1234)
(marks1 = trunc(rnorm(n=30, mean=70, sd=8)))
sum(marks1)
df5 <- data.frame(marks1=marks1)
head(df5)
#
km3 <- kmeans(df5, centers=3)
attributes(km3)
km3$cluster
km3$centers
km3$size
sort(df5$marks1)
cbind(df5, km3$cluster)  #which row which cluster
df5$cluster = km3$cluster
head(df5)
df5 %>% arrange(cluster)
dist(df5[1:5,])
#-----------------------------------------
set.seed(1234)
(marks1 = trunc(rnorm(n=30, mean=70, sd=8)))
(marks2 = trunc(rnorm(n=30, mean=120, sd=10)))
df6 <- data.frame(marks1, marks2)
head(df6)
#
km3 <- kmeans(df6, centers=5)
attributes(km3)
km3$cluster
km3$centers
km3$size
cbind(df6, km3$cluster)  #which row which cluster
df6$cluster = km3$cluster
head(df6)
df6 %>% arrange(cluster)
df6[1:5,]
dist(df6[1:5,])
plot(df6$marks1, df6$marks2, col=df6$cluster)

#scale data and then do clustering
head(df6)
(df6B <- scale(df6[, c('marks1','marks2')]))
head(df6B)
#
km3B <- kmeans(df6B, centers=5)
attributes(km3B)
km3B$cluster
km3B$centers
km3B$size
cbind(df6B, km3B$cluster)  #which row which cluster
head(df6)
df6$newcluster = km3B$cluster
head(df6)
df6B %>% arrange(cluster)
df6[1:5,]
dist(df6[1:5,])
plot(df6$marks1, df6$marks2, col=df6$cluster)
plot(df6$marks1, df6$marks2, col=df6$newcluster)





#Factor Extra - hclust

library("factoextra")
# Compute hierarchical clustering and cut into 4 clusters
res <- hcut(USArrests, k = 4, stand = TRUE)
res
# Visualize
k_colors = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07")
fviz_dend(res, rect = TRUE, cex = 0.5, k_colors=c('red','green','blue','yellow')  )

# Optimal number of clusters for k-means
library("factoextra")
my_data <- scale(USArrests)
fviz_nbclust(my_data, kmeans, method = "gap_stat")



#----wordcloud-----


#install.packages('wordcloud2')
library(wordcloud2)
df = data.frame(word=c('iit','mdi','iim','imt'),freq=c(50,20,23,15))
df
par(mar=c(0,0,0,0))
wordcloud2(df)

head(demoFreq)
dim(demoFreq)
par(mar=c(0,0,0,0))
wordcloud2(demoFreq)

par(mar=c(0,0,0,0))
wordcloud2(demoFreq, size = 2, color = "random-light", backgroundColor = "grey")

names(demoFreq)
par(mar=c(0,0,0,0))
wordcloud2(demoFreq, size = 2, minRotation = -pi/2, maxRotation = -pi/2)
wordcloud2(demoFreq, size = 2, minRotation = -pi/6, maxRotation = -pi/6,   rotateRatio = 1)
wordcloud2(demoFreq, size = 2, minRotation = -pi/6, maxRotation = pi/6,    rotateRatio = 0.9)
par(mar=c(0,0,0,0))
wordcloud2(demoFreqC, size = 3,  color = "random-light", backgroundColor = "grey")
wordcloud2(demoFreqC, size = 2, minRotation = -pi/6, maxRotation = -pi/6,  rotateRatio = 1)

# Color Vector
?wordcloud2
colorVec = rep(c('red', 'skyblue'), length.out=nrow(demoFreq))
wordcloud2(demoFreq, color = colorVec, fontWeight = "bold")

wordcloud2(demoFreq, color = ifelse(demoFreq[, 2] > 10, 'red', 'skyblue'))


#Example2 -----
#Word Cloud 2

#(https://www.r-graph-gallery.com/the-wordcloud2-library/)

# library : install it first
library(wordcloud2) 

# have a look to the example dataset
head(demoFreq)
dim(demoFreq)
str(demoFreq)
#wordcloud
wordcloud2(demoFreq, size=1.6)
head(demoFreq[order(-demoFreq$freq),])
?wordcloud2

#create your own set of words
word = c('marketing','consumer', 'dhiraj','price','business','iimkashipur', 'sunder','vignesh', 'jyoti','finance', 'operations')
freq = c(30,20,15,36,15,13,11,44,13,44,34)
df1 = data.frame(word, freq)
#rownames(df1)= word
head(df1)
#df1 = head(demoFreq)
wordcloud2(df1, size=.4)
?wordcloud2
# Gives a proposed palette
wordcloud2(demoFreq, size=1.6, color='random-dark')
wordcloud2(df1, size=1, color='random-dark')

# or a vector of colors. vector must be same length than input data
wordcloud2(demoFreq, size=1.6, color=rep_len( c("green","blue"), nrow(demoFreq) ) )
# Change the background color
wordcloud2(demoFreq, size=1.6, color='random-light', backgroundColor="black")

