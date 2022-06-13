# load libraries
library(MASS)
library(ISLR)

##### Simple Linear Regression ###############
fix(Boston)
names(Boston)

# lm - simple linear regression; lm(y~x,data)
lm.fit = lm(medv~lstat, data= Boston)
attach(Boston)
lm.fit
summary(lm.fit)

# names- find out other pieces of info
names(lm.fit)

# coeff - extractor function to access them
coeff(lm.fit)
coefficients(lm.fit)

# confint - confidence interval for the coefficient estimates
confint(lm.fit)

predict(lm.fit, data.frame(lstat=(c(5,10,15))), interval='confidence')

predict(lm.fit, data.frame(lstat=(c(5,10,15))), interval='prediction')

plot(lstat,medv)
abline(lm.fit)

# pch option to create different plotting symbols
abline(lm.fit, lwd=3)
abline(lm.fit, lwd=3, col='red')
abline(lstat,medv, col='red')
abline(lstat,medv,pch=20)
abline(lstat,medv,pch='+')
plot(1:20,1:20,pch=1:20)

# par() - multiple plots
par(mfrow=c(2,2))
plot(lm.fit)

# residuals() - compute residuals() from a linear regression
# rstudent() - returns studentized residuals
plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))

plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))


###  Multiple Linear Regression ##############
# lm(y~x1+x2+x3)
lm.fit(medv~lstat+age, data=Boston)
summary(lm.fit)

# including all variables
lm.fit = lm(medv~.,data= Boston)
summary(lm.fit)
vif(lm.fit)
# vif() - variance inflation factors
library(car)
vif(lm.fit)

# all features except age
lm.fit1 = lm(medv~.-age, data=Boston)
summary(lm.fit1)

lm.fit1 = update(lm.fit, ~.-age)
summary(lm(medv~lstat*age,data=Boston))

# Non-linear transformation of the predictors
lm.fit2 = lm(medv~lstat+I(lstat^2))
summary(lm.fit2)

# anova() - function to quantify the extent to which the quadratic fit is superior to the linear fit
lm.fit=lm(medv~lstat)
anova(lm.fit, lm.fit2)

par(mfrow=c(2,2))
plot(lm.fit2)

# poly() - create polynomial within lm()
lm.fit5 = lm(medv~poly(lstat,5)) # polynomial to 5th order
summary(lm.fit5)

summary(lm(medv~log(rm),data=Boston))

##### Qualitative Predictors ###############
fix(Carseats)
names(Carseats)
# R generates some dummy variables auromatically
lm.fit = lm(Sales~.+Income:Advertising+Price : Age, data=Carseats)
summary(lm.fit)

# contrast function returns the dummy variables R uses
attach(Carseats)
contrasts(ShelveLoc)

#### Writing Functions ############
LoadLibraries = function(){
  + library(ISLR)
  + library(MASS)
  + print('The libraries are loaded.')
}
}
