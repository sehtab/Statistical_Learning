# Decision TreeRegression
df = read.csv('Position_Salaries.csv')
View(df)
df =df[2:3]
View(df)

# splitting the data set
#library(caTools)
#set.seed(123)
#split = sample.split(df$Salary, SplitRatio = 0.75)
#training_set = subset(df, split == TRUE)
#test_set = subset(df, split == FALSE)

# Fitting the SVR to the dataset
#install.packages('rpart')
library('rpart')
regressor = rpart(formula = Salary ~ . , data = df,
                  control = rpart.control(minsplit = 1))
summary(regressor)

# predicting test set results
y_pred = predict(regressor, data.frame(Level = 6.5))
y_pred

# visualization
library(ggplot2)
x_grid = seq(min(df$Level), max(df$Level), 0.01)
ggplot() +
  geom_point(aes(x = df$Level, y = df$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Salary Vs Level (Decision Tree Regression)') +
  xlab('Level') +
  ylab('Salary')