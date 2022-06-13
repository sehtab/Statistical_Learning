# SVR Regression
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
install.packages('e1071')
library('e1071')
regressor = svm(formula = Salary ~ . , data = df,
                type='eps-regression')
summary(regressor)

# predicting test set results
y_pred = predict(regressor, data.frame(Level = 6.5))
y_pred

# visualization
library('ggplot2')
ggplot() +
  geom_point(aes(x = df$Level, y = df$Salary),
             colour= 'blue') +
  geom_line(aes(x= df$Level, y = predict(regressor, newdata = df)),
            colour = 'green') +
  ggtitle('Salary Vs Level (SVM)') +
  xlab('Level') +
  ylab('Salary')