# Polynomial Regression
df = read.csv('Position_Salaries.csv')
View(df)
df =df[2:3]
View(df)

# Encoding categorical data
#df$State = factor(df$State,
                  #levels = c('New York', 'California', 'Florida'),
                  #labels = c(1, 2, 3))
# splitting the data set
#library(caTools)
#set.seed(123)
#split = sample.split(df$Profit, SplitRatio = 0.75)
#training_set = subset(df, split == TRUE)
#test_set = subset(df, split == FALSE)

# fitting linear regression to the dataset
lin_reg = lm(formula = Salary ~ . , data = df)
summary(lin_reg)


# fitting polynomial regression to the dataset
df$Level2 = df$Level^2
df$Level3 = df$Level^3
df$Level4 = df$Level^4
View(df)
poly_reg = lm(formula = Salary ~ . , data = df)
summary(poly_reg)

# visualization of Linear Regression
library('ggplot2')
ggplot() +
  geom_point(aes(x = df$Level, y = df$Salary),
             colour= 'blue') +
  geom_line(aes(x= df$Level, y = predict(lin_reg, newdata = df)),
            colour = 'green') +
  ggtitle('Salary  Vs Level (Linear Regression)') +
  xlab('Level') +
  ylab('Salary')

# visualization of Polynomial Regression
library('ggplot2')
ggplot() +
  geom_point(aes(x = df$Level, y = df$Salary),
             colour= 'red') +
  geom_line(aes(x= df$Level, y = predict(poly_reg, newdata = df)),
            colour = 'black') +
  ggtitle('Salary  Vs Level (Polynomial Regression)') +
  xlab('Level') +
  ylab('Salary')
# predicting a new result with Linear regression
y_pred = predict(lin_reg, newdata = data.frame(Level=6.5))
y_pred

# predicting a new result with Polynomial regression
y_pred = predict(poly_reg, newdata = data.frame(Level=6.5, Level2 = 6.5^2,
                                                Level3=6.5^3, Level4=6.5^4))
y_pred